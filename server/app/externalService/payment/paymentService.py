import os
import requests
import cv2
# from pyzbar.pyzbar import decode
from pymongo import MongoClient
from fastapi import HTTPException, Request
from dotenv import load_dotenv
from bson import ObjectId
from datetime import datetime
from app.model.paymentModel import PaymentData
from app.internalService.authorization.authorizationService import AuthorizationService
from app.model.postModel import PostData

load_dotenv()

class PaymentService:
    def __init__(self, dbCollection):
        self.payments_collection = dbCollection["payments"]

        self.authorization_service = AuthorizationService(dbCollection)
        self.verify_api_token = "a2ae274e-9774-4ea8-ab99-d51fdc472bc0"  # API Token for slip verification

    def create_user_payment(self, post_data: PostData, finder_data: dict, request: Request):
        user = self.authorization_service.verify_jwt_token(request)
        if not user:
            raise HTTPException(status_code=404, detail="User not found.")
        
        user_id = self.authorization_service.users_collection.find_one({"_id": ObjectId(user_id)})

        """Generate a bill for the owner to send money to the finder."""
        payment_data = {
            "ownerUserId": user_id,
            "petName": post_data.name,
            "finderName": finder_data.get("finderName"),
            "finderBankAccountNumber": finder_data.get("finderBankAccountNumber"),
            "finderBankAccountType": finder_data.get("finderBankAccountType"),
            "finderBankAccountName": finder_data.get("finderBankAccountName"),
            "amount": post_data.reward,
            "status": "unpaid",
            "timestamp": datetime.utcnow().isoformat(),
        }
        
        transaction_id = str(ObjectId())
        payment_data["transaction_id"] = transaction_id
        
        self.payments_collection.insert_one(payment_data)

        return {
            "transaction_id": transaction_id,
            "status": "unpaid",
            "timestamp": payment_data["timestamp"]
        }

    def upload_slip(self, transaction_id: str, slip_image_url: str):
        """Owner uploads transaction slip, and status changes to 'pending'."""
        payment_record = self.payments_collection.find_one({"transaction_id": transaction_id})

        if not payment_record:
            raise HTTPException(status_code=404, detail="Payment record not found")

        refNbr = self.extract_qr_code_data(slip_image_url)

        update_result = self.payments_collection.update_one(
            {"transaction_id": transaction_id},
            {"$set": {"slip_image_url": slip_image_url, "status": "pending", "refNbr": refNbr}}
        )

        if update_result.modified_count == 1:
            return {"detail": "Slip uploaded successfully", "status": "pending"}
        else:
            raise HTTPException(status_code=500, detail="Failed to upload the slip")

    # def verify_slip(self, transaction_id: str):
    #     """Verify the uploaded slip using OpenSlipVerify API and update the status."""
    #     payment_record = self.payments_collection.find_one({"transaction_id": transaction_id})

    #     if not payment_record:
    #         raise HTTPException(status_code=404, detail="Payment record not found")

    #     # Extract necessary details from the payment record
    #     slip_image_url = payment_record.get("slip_image_url")
    #     amount = payment_record.get("amount")

    #     if not slip_image_url:
    #         raise HTTPException(status_code=400, detail="No slip uploaded for verification")

    #     # Assuming the `refNbr` is fetched from the QR code (this part depends on how you extract the QR code from the image)
    #     refNbr = payment_record.get("refNbr")
    #     if not refNbr:
    #         raise HTTPException(status_code=400, detail="Cannot extract refNbr from the uploaded slip.")

    #     # API payload for slip verification
    #     verification_payload = {
    #         "refNbr": refNbr,
    #         "amount": str(amount),  # Convert amount to string as required by the API
    #         "token": self.verify_api_token  # Using the token provided for OpenSlipVerify API
    #     }

    #     # API request to OpenSlipVerify
    #     verification_response = requests.post(
    #         "https://api.openslipverify.com/",
    #         headers={"Content-Type": "application/json"},
    #         json=verification_payload
    #     )

    #     if verification_response.status_code == 200:
    #         response_data = verification_response.json()

    #         if response_data["success"]:
    #             # Update payment status to 'successful'
    #             update_result = self.payments_collection.update_one(
    #                 {"transaction_id": transaction_id},
    #                 {
    #                     "$set": {
    #                         "status": "successful",
    #                         "verified_timestamp": datetime.utcnow().isoformat()
    #                     }
    #                 }
    #             )

    #             if update_result.modified_count == 1:
    #                 return {"detail": "Slip verified successfully", "status": "successful"}
    #             else:
    #                 raise HTTPException(status_code=500, detail="Failed to update payment status")
    #         else:
    #             # Slip verification failed (e.g., incorrect amount, invalid slip)
    #             raise HTTPException(status_code=400, detail=response_data.get("msg", "Slip verification failed"))
    #     else:
    #         # Handle errors from the OpenSlipVerify API
    #         raise HTTPException(
    #             status_code=verification_response.status_code,
    #             detail=verification_response.json().get("msg", "Slip verification error")
    #         )

    # def extract_qr_code_data(self, image_path: str):
    #     """Extract QR code data from the slip image."""
    #     image = cv2.imread(image_path)
    #     decoded_objects = decode(image)

    #     if not decoded_objects:
    #         raise HTTPException(status_code=400, detail="Cannot extract refNbr: No QR code found in the image.")

    #     for obj in decoded_objects:
    #         return obj.data.decode('utf-8')

    #     raise HTTPException(status_code=400, detail="Cannot extract refNbr: QR code could not be decoded.")

    def get_user_payment(self, transaction_id: str):
        """View payment details."""
        payment_record = self.payments_collection.find_one({"transaction_id": transaction_id})

        if not payment_record:
            raise HTTPException(status_code=404, detail="Payment record not found")

        return payment_record

    def reupload_slip(self, transaction_id: str, slip_image_url: str):
        """Allow re-uploading of the slip if the status is 'pending'."""
        payment_record = self.payments_collection.find_one({"transaction_id": transaction_id})

        if not payment_record:
            raise HTTPException(status_code=404, detail="Payment record not found")

        if payment_record["status"] != "pending":
            raise HTTPException(status_code=400, detail="Slip not found")

        update_result = self.payments_collection.update_one(
            {"transaction_id": transaction_id},
            {"$set": {"slip_image_url": slip_image_url}}
        )

        if update_result.modified_count == 1:
            return {"detail": "Slip re-uploaded successfully", "status": "pending"}
        else:
            raise HTTPException(status_code=500, detail="Failed to re-upload the slip")

def update_user_payment_data(self, user_id: str, finder_data: dict):
    """
    Update user payment data if the finder has not entered bank account details.
    """
    user = self.authorization_service.users_collection.find_one({"_id": ObjectId(user_id)})

    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    finder_bank_account_number = finder_data.get("finderBankAccountNumber")
    finder_bank_account_name = finder_data.get("finderBankAccountName")
    finder_bank_account_type = finder_data.get("finderBankAccountType")

    if not finder_bank_account_number or not finder_bank_account_name or not finder_bank_account_type:
        raise HTTPException(
            status_code=400,
            detail="Finder bank details missing. Please enter the required data."
            # need to be prompt to page for enter payment data
        )

    update_result = self.authorization_service.users_collection.update_one(
        {"_id": ObjectId(user_id)},
        {"$set": {
            "finderBankAccountNumber": finder_bank_account_number,
            "finderBankAccountName": finder_bank_account_name,
            "finderBankAccountType": finder_bank_account_type
        }}
    )

    if update_result.modified_count == 1:
        return {"detail": "User payment data updated successfully"}
    else:
        raise HTTPException(status_code=500, detail="Failed to update user payment data")
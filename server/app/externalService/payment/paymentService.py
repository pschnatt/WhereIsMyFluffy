import os
import requests
# from pyzbar.pyzbar import decode
from pymongo import MongoClient
from fastapi import HTTPException, Request
from dotenv import load_dotenv
from bson import ObjectId
from datetime import datetime
from app.model.paymentModel import AccountDetail, PaymentDetail
from app.internalService.authorization.authorizationService import AuthorizationService
from app.model.postModel import PostData
from app.model.authorizationModel import UserId

load_dotenv()

class PaymentService:
    def __init__(self, dbCollection):
        self.account_collection = dbCollection["account"]
        self.payment_collection = dbCollection["payment"]
        self.authorization_service = AuthorizationService(dbCollection)
        self.verify_api_token = "a2ae274e-9774-4ea8-ab99-d51fdc472bc0"  # API Token for slip verification

    def create_user_payment(self, accountDetail: AccountDetail, request: Request):
        user_id = self.authorization_service.verify_jwt_token(request)
        if not user_id:
            raise HTTPException(status_code=404, detail="User not found.")
        
        payment_data = {
            "userId": user_id,
            "finderBankAccountNumber": accountDetail.finderBankAccountNumber,
            "finderBankAccountType": accountDetail.finderBankAccountType,
            "finderBankAccountName": accountDetail.finderBankAccountName,
            "paymentList": []
        }
                
        result = self.account_collection.insert_one(payment_data)

        inserted_id = result.inserted_id

        return {
            "payment_id": str(inserted_id)  
        }
    
    def get_user_payment(self, userId: UserId):
        try:
            payment_data = self.account_collection.find_one({"userId": userId})
            
            if not payment_data:
                raise HTTPException(status_code=404, detail="Account details not found for the user.")
            
            payment_data["_id"] = str(payment_data["_id"])
            
            return payment_data

        except Exception as e:
            raise HTTPException(status_code=500, detail=str(e))
        
    def addPayment(self, paymentDetail: PaymentDetail):
        try:
            payment_data = {
                "payerId": paymentDetail.payerId,
                "receiverId": paymentDetail.receiverId,
                "status": paymentDetail.status, 
                "amount": paymentDetail.amount
            }
            
            result = self.payment_collection.insert_one(payment_data)
            payment_id = result.inserted_id  
            
            update_result = self.account_collection.update_one(
                {"userId": paymentDetail.payerId},
                {"$push": {"paymentList": str(payment_id)}}  
            )
            
            if update_result.matched_count == 0:
                raise HTTPException(status_code=404, detail="Payer not found.")

            return {
                "payment_id": str(payment_id),
                "message": "Payment added and linked to payer successfully."
            }

        except Exception as e:
            raise HTTPException(status_code=500, detail=f"Error adding payment: {str(e)}")

    # def upload_slip(self, transaction_id: str, slip_image_url: str):
    #     payment_record = self.payments_collection.find_one({"transaction_id": transaction_id})

    #     if not payment_record:
    #         raise HTTPException(status_code=404, detail="Payment record not found")

    #     refNbr = self.extract_qr_code_data(slip_image_url)

    #     update_result = self.payments_collection.update_one(
    #         {"transaction_id": transaction_id},
    #         {"$set": {"slip_image_url": slip_image_url, "status": "pending", "refNbr": refNbr}}
    #     )

    #     if update_result.modified_count == 1:
    #         return {"detail": "Slip uploaded successfully", "status": "pending"}
    #     else:
    #         raise HTTPException(status_code=500, detail="Failed to upload the slip")

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

    

    # def reupload_slip(self, transaction_id: str, slip_image_url: str):
    #     """Allow re-uploading of the slip if the status is 'pending'."""
    #     payment_record = self.payments_collection.find_one({"transaction_id": transaction_id})

    #     if not payment_record:
    #         raise HTTPException(status_code=404, detail="Payment record not found")

    #     if payment_record["status"] != "pending":
    #         raise HTTPException(status_code=400, detail="Slip not found")

    #     update_result = self.payments_collection.update_one(
    #         {"transaction_id": transaction_id},
    #         {"$set": {"slip_image_url": slip_image_url}}
    #     )

    #     if update_result.modified_count == 1:
    #         return {"detail": "Slip re-uploaded successfully", "status": "pending"}
    #     else:
    #         raise HTTPException(status_code=500, detail="Failed to re-upload the slip")

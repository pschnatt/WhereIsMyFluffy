import os
import requests
import qrcode
import uuid
from pymongo import MongoClient
from fastapi import HTTPException, Request
from dotenv import load_dotenv
from bson import ObjectId
from io import BytesIO
from datetime import datetime
from app.internalService.authorization.authorizationService import AuthorizationService

load_dotenv()

class PaymentService:
    def __init__(self, dbCollection):
        self.users_collection = dbCollection["users"]
        self.payments_collection = dbCollection["payments"]
        self.paypal_api_base_url = "https://api.sandbox.paypal.com"

        self.client_id = os.getenv("PAYPAL_CLIENT_ID")
        self.client_secret = os.getenv("PAYPAL_CLIENT_SECRET")

        if not self.client_id or not self.client_secret:
            raise ValueError("PayPal credentials not found in environment variables")

        self.authorization_service = AuthorizationService(dbCollection)

    def generate_qr_code(self, link):
        """Generate a QR code for a given PayPal link."""
        qr = qrcode.QRCode(version=1, box_size=10, border=5)
        qr.add_data(link)
        qr.make(fit=True)
        img = qr.make_image(fill="black", back_color="white")
        byte_io = BytesIO()
        img.save(byte_io, 'PNG')
        byte_io.seek(0)
        return byte_io

    def generate_payment_qr_code(self, finder_paypal_link, amount):
        """Generate a QR code for direct payment to the finder."""
        payment_link = f"{finder_paypal_link}?amount={amount}"
        return self.generate_qr_code(payment_link)

    def verify_user_token(self, request: Request):
        """Verify the user's JWT token using AuthorizationService."""
        try:
            user_id = self.authorization_service.verify_jwt_token(request)
            user = self.users_collection.find_one({"_id": user_id})
            if not user:
                raise HTTPException(status_code=401, detail="User not registered in the system")
            return user
        except Exception as e:
            raise HTTPException(status_code=401, detail=f"Unauthorized: {str(e)}")

    def process(self, request: Request, data):
        """Main method to process payment tasks, including user verification and QR code generation."""
        # Verify user token and retrieve user details
        user = self.verify_user_token(request)

        # Retrieve owner and finder details
        owner_id = data["owner_id"]
        finder_id = data["finder_id"]
        reward_amount = data["reward_amount"]

        owner = self.users_collection.find_one({"_id": owner_id})
        finder = self.users_collection.find_one({"_id": finder_id})

        if not owner or not finder:
            raise HTTPException(status_code=400, detail="Either the owner or finder is not registered.")

        # Fetch PayPal account from the registered finder
        finder_paypal_account = finder.get("paypal")
        if not finder_paypal_account:
            raise HTTPException(status_code=400, detail="Finder does not have a PayPal account registered.")

        # Generate payment QR code for finder
        finder_qr_code = self.generate_payment_qr_code(finder_paypal_account, reward_amount)

        # Create a new payment record in the database with a unique transaction ID
        transaction_id = str(uuid.uuid4())  # Generate a unique transaction ID
        payment_record = {
            "owner_id": data.owner_id,
            "finder_id": data.finder_id,
            "reward_amount": data.reward_amount,
            "transaction_id": transaction_id,  # Store the generated transaction ID
            "status": "pending",                # Default status
            "timestamp": datetime.utcnow().isoformat()  # Record the current time
        }

        # Insert the payment record into MongoDB
        self.payments_collection.insert_one(payment_record)

        return {
            "finder_qr_code": finder_qr_code,
            "transaction_id": transaction_id,  # Return the unique transaction ID
            "status": "pending",
            "timestamp": payment_record["timestamp"]
        }

    def confirm_payment(self, request: Request, transaction_id: str):
        """
        Update the payment status to 'successful' once the finder confirms receipt of the money.
        """
        # Verify the user token to ensure the finder is authorized
        user = self.verify_user_token(request)

        # Find the payment record based on the transaction ID
        payment_record = self.payments_collection.find_one({"transaction_id": transaction_id})

        if not payment_record:
            raise HTTPException(status_code=404, detail="Payment record not found")

        # Check if the user is the finder
        if str(payment_record["finder_id"]) != str(user["_id"]):
            raise HTTPException(status_code=403, detail="You are not authorized to confirm this payment")

        # Update the payment status to 'successful'
        update_result = self.payments_collection.update_one(
            {"transaction_id": transaction_id},
            {"$set": {"status": "successful", "confirmation_timestamp": datetime.utcnow().isoformat()}}
        )

        if update_result.modified_count == 1:
            return {"detail": "Payment successfully confirmed", "transaction_id": transaction_id, "status": "successful"}
        else:
            raise HTTPException(status_code=500, detail="Failed to update the payment status")

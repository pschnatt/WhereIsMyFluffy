import os
import requests
# from pyzbar.pyzbar import decode
from pymongo import MongoClient
from fastapi import HTTPException, Request
from dotenv import load_dotenv
from bson import ObjectId
from datetime import datetime
from app.model.paymentModel import AccountDetail, PaymentDetail, UpdatePaymentDetail
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
        

    def updatePaymentStatus(self, updateDetail : UpdatePaymentDetail):
        try:
            
            update_result = self.payment_collection.update_one(
                {"_id": ObjectId(updateDetail.paymentId)},
                {"$set": {"status": updateDetail.status}}
            )

            if update_result.matched_count == 0:
                raise HTTPException(status_code=404, detail="Payment not found.")
            
            return {
                "payment_id": updateDetail.paymentId,
                "new_status": updateDetail.status,
                "message": "Payment status updated successfully."
            }

        except Exception as e:
            raise HTTPException(status_code=500, detail=f"Error updating payment status: {str(e)}")

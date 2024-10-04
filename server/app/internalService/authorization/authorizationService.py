from datetime import datetime, timedelta, timezone
import os
from dotenv import load_dotenv
import bcrypt
from fastapi import HTTPException, Request, Response
import jwt
from app.model.authorizationModel import RegisterData, LoginData

class AuthorizationService:
    def __init__(self, dbCollection):
        self.users_collection = dbCollection["users"]

    def register_user(self, data : RegisterData):
        if self.users_collection.find_one({"email": data.email}):
            raise ValueError("Email already exists.")
        hashed_password = bcrypt.hashpw(data.password.encode('utf-8'), bcrypt.gensalt())
        user_document = {
            "firstName" : data.firstName, 
            "lastName" : data.lastName,  
            "email" : data.email,
            "password" : hashed_password,
            "phoneNumber": data.phoneNumber,
            "posts" : [],
            "paypal" : data.paypal,
            "createdAt" : datetime.now(timezone.utc).strftime("%Y-%m-%d"),
            "updatedAt" : datetime.now(timezone.utc).strftime("%Y-%m-%d"),
            "rewards" : [],
            "petIds" : [],
            "imageId" : None,
            "address": str
        }

        try:
            result = self.users_collection.insert_one(user_document)
            if result.inserted_id:
                return {"message": "User registered successfully.", "user_id": str(result.inserted_id)}
            else:
                return {"message": "Failed to register user."}
        except:
            raise Exception(f"An error occurred while inserting the user")  
        
    def login_user(self, data : LoginData, response: Response):
        user = self.users_collection.find_one({"email": data.email})

        if not user:
            raise Exception("User not found.")

        stored_password = user.get("password")

        if bcrypt.checkpw(data.password.encode('utf-8'), stored_password):
            token = self.create_jwt_token(user["_id"])
            
            expiration_time = datetime.now(timezone.utc) + timedelta(hours=1)
            response.set_cookie(
                key="jwt_token",
                value=token,
                httponly=True,  
                secure=True,    
                samesite="Lax",
                expires=expiration_time
            )
            
            return {
                "message": "Login successful",
                "user_id": str(user["_id"]),
                "token" : token
            }

    def create_jwt_token(self, user_id):
        expiration_time = datetime.now(timezone.utc) + timedelta(hours=1)
        payload = {
            "user_id": str(user_id),
            "exp": expiration_time
        }
        load_dotenv()
        SECRET_KEY = os.getenv("SECRET_KEY")
        token = jwt.encode(payload, SECRET_KEY, algorithm="HS256")
        return token

    def verify_jwt_token(self, request: Request):
        load_dotenv()
        SECRET_KEY = os.getenv("SECRET_KEY")
        
        token = request.cookies.get("jwt_token")  
        if not token:
            raise HTTPException(status_code=401, detail="User not logged in. Please log in.")

        try:
            payload = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])            
            return payload["user_id"]
        
        except jwt.ExpiredSignatureError:
            raise HTTPException(status_code=401, detail="Token has expired.")
        except jwt.InvalidTokenError:
            raise HTTPException(status_code=401, detail="Invalid token.")



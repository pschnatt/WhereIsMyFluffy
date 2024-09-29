from app.model.authorizationModel import UserData
from pymongo import MongoClient

class AuthorizationService:
    def __init__(self, dbCollection):
        self.users_collection = dbCollection["users"]

    def register_user(self,data:UserData):
        if self.users_collection.find_one({"email": data.email}):
            raise ValueError("Email already exists.")

        user_document = {
            "firstName" : data.firstName, 
            "lastName" : data.lastName,  
            "email" : data.email,
            "posts" : data.posts,
            "paypal" : data.paypal,
            "createdAt" : data.createdAt,
            "updatedAt" : data. updatedAt,
            "rewards" : data.rewards
        }

        try:
            result = self.users_collection.insert_one(user_document)
            if result.inserted_id:
                return {"message": "User registered successfully.", "user_id": str(result.inserted_id)}
            else:
                return {"message": "Failed to register user."}
        except:
            raise Exception(f"An error occurred while inserting the user")

    
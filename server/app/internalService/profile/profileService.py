from datetime import datetime, timezone
import bcrypt
from bson import ObjectId
from fastapi import HTTPException, Response
import gridfs
from app.model.authorizationModel import RegisterData
from app.model.petmodel import PetData
from app.common.ConvertObjectId import *


class ProfileService:
  def __init__(self, dbCollection):
        self.users_collection = dbCollection["users"]
        self.pets_collection = dbCollection["pets"]
        self.fs = gridfs.GridFS(dbCollection)

  def updateUser(self, userId : str, data: RegisterData, imagePath:str = ""):

      update_data = data.model_dump(exclude_unset=True)

      if "password" in update_data:
          update_data["password"] = bcrypt.hashpw(update_data["password"].encode('utf-8'), bcrypt.gensalt())

      if imagePath != "":
            try:
                with open(imagePath, "rb") as image_file:
                    image_id = self.fs.put(image_file, filename=imagePath.split("/")[-1], content_type="image/jpeg")
                    update_data["imageId"] = image_id  
            except Exception as e:
                raise HTTPException(status_code=400, detail=f"Error uploading image: {str(e)}")
          

      update_data["updatedAt"] = datetime.now(timezone.utc).strftime("%Y-%m-%d")

      if not update_data:
          return {"message": "No updates provided."}

      user_id_obj = ObjectId(userId)

      result = self.users_collection.update_one(
          {"_id": user_id_obj},
          {"$set": update_data}
      )

      if result.matched_count == 1:
          if result.modified_count == 1:
              return {"message": "User updated successfully."}
          else:
              return {"message": "No changes made to the user."}
      else:
          return {"message": "User not found."}

  
  def getUser(self, userId : str):
      try:
          user_id = ObjectId(userId)

          user = self.users_collection.find_one({"_id": user_id})

          if user:
            user = convertObjectIdq(user)
            return user
          else:
              raise HTTPException(status_code=404, detail="User not found.")
        
      except Exception as e:
          raise HTTPException(status_code=500, detail=str(e))
      
  def getUserImage(self, userId : str):
    try:
        user = self.getUser(userId)

        image_id = user.get("imageId")
        if not image_id:
            raise HTTPException(status_code=404, detail="User has no image.")

        image_data = self.fs.get(image_id)

        content_type = image_data.content_type or "image/jpeg"

        return Response(content=image_data.read(), media_type=content_type)

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
  
  def createPet(self, userId: str, data: PetData, imagePath:str = ""):
    
    pet_document = {
        "name": data.name,
        "type": data.type,
        "breed": data.breed,
        "color": data.color,
        "age": data.age,
        "description": data.description,
        "ownerId": userId, 
        "createdAt": datetime.now(timezone.utc).strftime("%Y-%m-%d"),
        "updatedAt": datetime.now(timezone.utc).strftime("%Y-%m-%d"),
        "imageId": None
    }

    if imagePath != "":
            try:
                with open(imagePath, "rb") as image_file:
                    image_id = self.fs.put(image_file, filename=imagePath.split("/")[-1], content_type="image/jpeg")
                    pet_document["imageId"] = image_id  
            except Exception as e:
                raise HTTPException(status_code=400, detail=f"Error uploading image: {str(e)}")
    
    pet_id = self.pets_collection.insert_one(pet_document).inserted_id
    
    user_id_obj = ObjectId(userId)
    result = self.users_collection.update_one(
        {"_id": user_id_obj},
        {"$addToSet": {"petIds": pet_id}}
    )
    
    if result.matched_count == 1:
        return {"message": "Pet created and user updated successfully.", "petId": str(pet_id)}
    else:
        raise HTTPException(status_code=404, detail="User not found.")
      
  def updatePet(self, petId: str, data: PetData, imagePath: str = ""):
    pet_id_obj = ObjectId(petId)
    
    update_data = data.model_dump(exclude_unset=True)
    
    if imagePath != "":
        try:
            with open(imagePath, "rb") as image_file:
                image_id = self.fs.put(image_file, filename=imagePath.split("/")[-1], content_type="image/jpeg")
                update_data["imageId"] = image_id
        except Exception as e:
            raise HTTPException(status_code=400, detail=f"Error uploading image: {str(e)}")
    
    update_data["updatedAt"] = datetime.now(timezone.utc).strftime("%Y-%m-%d")
    
    result = self.pets_collection.update_one(
        {"_id": pet_id_obj},
        {"$set": update_data}
    )
    
    if result.matched_count == 1:
        if result.modified_count == 1:
            return {"message": "Pet updated successfully."}
        else:
            return {"message": "No changes made to the pet."}
    else:
        raise HTTPException(status_code=404, detail="Pet not found.")

  
  def getPet(self, petId: str):
    try:
        pet_id_obj = ObjectId(petId)
        pet = self.pets_collection.find_one({"_id": pet_id_obj})
        
        if pet:
            pet = convertObjectIdq(pet)
            return pet
        else:
            raise HTTPException(status_code=404, detail="Pet not found.")
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

  
  def getPetImage(self, petId: str):
    try:
        pet = self.getPet(petId)
        
        image_id = pet.get("imageId")
        if not image_id:
            raise HTTPException(status_code=404, detail="Pet has no image.")
        
        image_data = self.fs.get(image_id)
        content_type = image_data.content_type or "image/jpeg"
        
        return Response(content=image_data.read(), media_type=content_type)
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

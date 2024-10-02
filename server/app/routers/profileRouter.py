from fastapi import APIRouter, Request
from app.core import Core
from app.model.authorizationModel import  UserForm, UserId
from app.model.petmodel import CreatePetForm, PetData, PetId, UpdatePetForm

router = APIRouter()
core = Core()

routerName = "profile"

@router.post(f"/{routerName}/updateUser/")
def updateUser(request: Request, updateData: UserForm):
  return core.profile.updateUser(request, updateData.registerData, updateData.imagePath)

@router.get(f"/{routerName}/getUser/")
def getUser(userId : UserId):
  return core.profile.getUser(userId.userId)

@router.get(f"/{routerName}/getUserImage/")
def getUser(userId : UserId):
  return core.profile.getUserImage(userId.userId)

@router.post(f"/{routerName}/createPet/")
def createPet(createData : CreatePetForm):
  return core.profile.createPet(createData.userId, createData.data, createData.imagePath)

@router.post(f"/{routerName}/updatePet/")
def updatePet(updateData : UpdatePetForm):
  return core.profile.updatePet(updateData.petId, updateData.data, updateData.imagePath)

@router.get(f"/{routerName}/getPet/")
def getPet(petId : PetId):
  return core.profile.getPet(petId.petId)

@router.get(f"/{routerName}/getPetImage/")
def getPetImage(petId : PetId):
  return core.profile.getPetImage(petId.petId)
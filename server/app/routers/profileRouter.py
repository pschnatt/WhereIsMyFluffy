from fastapi import APIRouter, Depends, Request, Response
from app.core import Core
from app.model.authorizationModel import RegisterData
from app.model.petmodel import PetData

router = APIRouter()
core = Core()

routerName = "profile"

@router.post(f"/{routerName}/updateUser/")
def updateUser(request: Request, data: RegisterData, imagePath:str = ""):
  return core.profile.updateUser(request, data, imagePath)

@router.get(f"/{routerName}/getUser/")
def getUser(userId : str):
  return core.profile.getUser(userId)

@router.get(f"/{routerName}/getUserImage/")
def getUser(userId : str):
  return core.profile.getUserImage(userId)

@router.post(f"/{routerName}/createPet/")
def createPet(userId: str, data: PetData, imagePath:str = ""):
  return core.profile.createPet(userId, data, imagePath)

@router.post(f"/{routerName}/updatePet/")
def updatePet(petId: str, data: PetData, imagePath: str = ""):
  return core.profile.updatePet(petId, data, imagePath)

@router.get(f"/{routerName}/getPet/")
def getPet(petId : str):
  return core.profile.getPet(petId)

@router.get(f"/{routerName}/getPetImage/")
def getPetImage(petId : str):
  return core.profile.getPetImage(petId)
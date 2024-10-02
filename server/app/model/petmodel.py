from typing import Optional
from pydantic import BaseModel

class PetData(BaseModel):
  name : Optional[str]
  type : Optional[str]
  breed : Optional[str]
  color : Optional[str]
  age : Optional[float]
  description : Optional[str]

class PetId(BaseModel):
  petId : str

class CreatePetForm(BaseModel):
  userId : str
  petData : PetData
  imagePath : Optional[str] = ""

class UpdatePetForm(BaseModel):
  petId : str
  petData : PetData
  imagePath : Optional[str] = ""
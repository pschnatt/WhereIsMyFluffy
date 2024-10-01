from typing import Optional
from bson import ObjectId
from pydantic import BaseModel

class PetData(BaseModel):
  name : Optional[str]
  type : Optional[str]
  breed : Optional[str]
  color : Optional[str]
  age : Optional[float]
  description : Optional[str]



from pydantic import BaseModel
from typing import Optional

class RegisterData(BaseModel):
    userName: Optional[str]
    email: Optional[str]
    password: Optional[str]
    address: str

class LoginData(BaseModel):
    email: str
    password: str 
    
class UserId(BaseModel):
    userId: str

class UserForm(BaseModel):
    userId: str
    registerData : RegisterData
    imagePath : Optional[str] = ""
from pydantic import BaseModel
from typing import Optional

class RegisterData(BaseModel):
    firstName: Optional[str]
    lastName: Optional[str]
    email: Optional[str]
    password: Optional[str]
    phoneNumber: Optional[str] 
    paypal: Optional[str]
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
from datetime import datetime
from pydantic import BaseModel, EmailStr, Field
from typing import List, Optional
from uuid import UUID

class RegisterData(BaseModel):
    firstName: str
    lastName: str
    email: str
    password: str 
    paypal: str

class LoginData(BaseModel):
    email: str
    password: str 
from datetime import datetime
from pydantic import BaseModel, EmailStr
from typing import List, Optional
from uuid import UUID

class UserData(BaseModel):
    firstName: str
    lastName: str
    email: Optional[EmailStr] = None
    posts: List[UUID]
    paypal: str
    createdAt: datetime
    updatedAt: datetime
    rewards: List[UUID]

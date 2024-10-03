from pydantic import BaseModel
from typing import Optional

class PostData(BaseModel):
    name: str
    age: Optional[int]
    weight: Optional[float]
    gender: str
    address: str
    reward: Optional[float]

class ReplyData(BaseModel):
    address: str
    detail: Optional[str]
from pydantic import BaseModel
from typing import Optional

class PostData(BaseModel):
    userId : str
    petId : str
    address: str
    reward: Optional[float]

class ReplyData(BaseModel):
    userId : str
    postId : str
    address: str
    detail: Optional[str]

class GetPostById(BaseModel):
    postId : str

class GetReplyById(BaseModel):
    replyId : str
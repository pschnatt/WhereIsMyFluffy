from pydantic import BaseModel

class AdClick(BaseModel):
    ad_unit_id: str
    counter: int
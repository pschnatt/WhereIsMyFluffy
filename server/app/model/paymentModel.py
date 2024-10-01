from pydantic import BaseModel

class PaymentData(BaseModel):
    owner_id: str
    finder_id: str
    reward_amount: float
    transaction_id: str
    status: str
    timestamp: str
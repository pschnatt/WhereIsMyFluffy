from pydantic import BaseModel
from typing import Optional

class PaymentData(BaseModel):
    ownerUserId: str
    petName: str
    finderName: str
    finderBankAccountNumber: str
    finderBankAccountType: str
    finderBankAccountName: str
    amount: float
    status: str

class SlipUploadData(BaseModel):
    transactionId: str
    slip_image_url: str

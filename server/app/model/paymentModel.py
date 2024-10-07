from pydantic import BaseModel
from typing import Optional


class AccountDetail(BaseModel):
    finderBankAccountNumber: str
    finderBankAccountType: str
    finderBankAccountName: str

class PaymentDetail(BaseModel):
    payerId: str
    recieverId: str
    status: str
    amount: float

class UpdatePaymentDetail(BaseModel):
    paymentId : str
    status: str


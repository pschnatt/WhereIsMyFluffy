from fastapi import APIRouter, Request
from app.core import Core
from app.globalAdapter import GlobalAdapter
from app.externalService.payment.paymentService import PaymentService
from app.model.paymentModel import AccountDetail, PaymentDetail, UpdatePaymentDetail
from app.model.authorizationModel import UserId

router = APIRouter()
adapter = GlobalAdapter()
core = Core()

routerName = "payment"

@router.post(f"/{routerName}/create-account")
def createAccount(data: AccountDetail):
   return core.payment.create_user_payment(data)

@router.get(f"/{routerName}/get-account")
def getAccount(data: UserId):
   return core.payment.get_user_payment(data)

@router.post(f"/{routerName}/create-payment")
def createAccount(data: PaymentDetail):
   return core.payment.addPayment(data)

@router.get(f"/{routerName}/get-account")
def getAccount(data: UpdatePaymentDetail):
   return core.payment.updatePaymentStatus(data)

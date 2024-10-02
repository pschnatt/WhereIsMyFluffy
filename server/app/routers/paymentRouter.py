from fastapi import APIRouter, Request
from app.core import Core
from app.globalAdapter import GlobalAdapter
from app.model.paymentModel import PaymentData
from app.externalService.payment.paymentService import PaymentService

router = APIRouter()
adapter = GlobalAdapter()
core = Core()

routerName = "payment"

@router.post(f"/{routerName}/create-payment")
def handle_payment(data: PaymentData):
    data_dict = data.model_dump()
    return core.process(data_dict)
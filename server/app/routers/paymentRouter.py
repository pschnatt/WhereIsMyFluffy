from fastapi import APIRouter, Request
from app.core import Core
from app.globalAdapter import GlobalAdapter
from app.model.paymentModel import PaymentData
from app.externalService.payment.paymentService import PaymentService

router = APIRouter()
adapter = GlobalAdapter()
core = Core()

routerName = "payment"

@router.post(f"/{routerName}/create-transaction")
def handle_transaction(data: PaymentData):
    adapted_data = adapter.adapt_request(routerName, data.data)
    response = core.handle_request("external_service", routerName, adapted_data)
    return adapter.adapt_response(routerName, response)

@router.post(f"/{routerName}/confirm-payment")
def confirm_payment(transaction_id: str, request: Request):
    adapted_data = adapter.adapt_request(routerName, {"transaction_id": transaction_id})
    user = PaymentService.verify_user_token(request)
    response = core.handle_request("external_service", routerName, adapted_data)
    return adapter.adapt_response(routerName, response)

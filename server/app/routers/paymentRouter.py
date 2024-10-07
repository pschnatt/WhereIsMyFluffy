from fastapi import APIRouter, Request
from app.core import Core
from app.globalAdapter import GlobalAdapter
from app.externalService.payment.paymentService import PaymentService

router = APIRouter()
adapter = GlobalAdapter()
core = Core()

routerName = "payment"

@router.post(f"/{routerName}/create-payment")
def create_payment(data):
    adapted_data = adapter.adapt_request(routerName, data)
    response = core.handle_request("external_service", routerName, adapted_data)
    return adapter.adapt_response(routerName, response)

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
def create_payment(data: PaymentData):
    adapted_data = adapter.adapt_request(routerName, data)
    response = core.handle_request("external_service", routerName, adapted_data)
    return adapter.adapt_response(routerName, response)

# @router.get(f"/{routerName}/get-payment/{{transaction_id}}")
# def get_payment(transaction_id: str):
#     try:
#         response = payment_service.get_user_payment(transaction_id)
#         return response
#     except HTTPException as e:
#         raise HTTPException(status_code=e.status_code, detail=e.detail)

# @router.post(f"/{routerName}/upload-slip/{{transaction_id}}")
# def upload_slip(transaction_id: str, slip_image_url: str):
#     try:
#         response = payment_service.upload_slip(transaction_id, slip_image_url)
#         return response
#     except HTTPException as e:
#         raise HTTPException(status_code=e.status_code, detail=e.detail)

# @router.post(f"/{routerName}/verify-payment/{{transaction_id}}")
# def verify_payment(transaction_id: str):
#     try:
#         response = payment_service.verify_slip(transaction_id)
#         return response
#     except HTTPException as e:
#         raise HTTPException(status_code=e.status_code, detail=e.detail)

# @router.post(f"/{routerName}/reupload-slip/{{transaction_id}}")
# def reupload_slip(transaction_id: str, slip_image_url: str):
#     try:
#         response = payment_service.reupload_slip(transaction_id, slip_image_url)
#         return response
#     except HTTPException as e:
#         raise HTTPException(status_code=e.status_code, detail=e.detail)
from fastapi import APIRouter
from app.core import Core
from app.globalAdapter import GlobalAdapter
from app.model.notificationModel import NotificationData

router = APIRouter()
adapter = GlobalAdapter()
core = Core()

routerName = "notification"

@router.post(f"/{routerName}/")
def handle_notification(data: NotificationData):
    adapted_data = adapter.adapt_request(routerName, data.data)
    return core.handle_request("external_service", f"{routerName}", adapted_data)
from fastapi import APIRouter
from app.core import Core
from app.externalService.notification.notificationService import NotificationService
from app.adapters.notificationAdapter import NotificationAdapter

router = APIRouter()
core = Core()

notification_service = NotificationService()
core.register_plugin("notification_service", notification_service)

notification_adapter = NotificationAdapter()

@router.post("/notification/")
def handle_notification(data: str):
    adapted_data = notification_adapter.adapt_notification_data(data)
    return core.handle_request("notification_service", adapted_data)


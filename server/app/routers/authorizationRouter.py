from fastapi import APIRouter
from app.core import Core
from app.model.authorizationModel import UserData

router = APIRouter()
core = Core()

routerName = "authorization"

@router.post(f"/{routerName}/register/")
def handle_notification(data: UserData):
    return core.authorization.register_user(data)
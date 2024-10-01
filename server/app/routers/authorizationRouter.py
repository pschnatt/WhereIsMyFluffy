from fastapi import APIRouter, Depends, Request, Response
from app.core import Core
from app.model.authorizationModel import RegisterData, LoginData

router = APIRouter()
core = Core()

routerName = "authorization"

@router.post(f"/{routerName}/register/")
def register(data: RegisterData):
    return core.authorization.register_user(data)

@router.post(f"/{routerName}/login/") 
def login(data : LoginData, response: Response):
    return core.authorization.login_user(data, response=response)

@router.get(f"/{routerName}/verify/")
def verifyToken(request: Request):  
    user_id = core.authorization.verify_jwt_token(request)
    return {"user_id": user_id}
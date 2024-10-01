from fastapi import Depends, FastAPI
from app.core import Core
from app.externalService.notification.notificationService import NotificationService
from app.externalService.advertisement.advertisementService import advertisementService
from app.routers.notificationRouter import router as notificationRouter
from app.routers.authorizationRouter import router as authorizationRouter
from app.routers.advertisementRouter import router as advertisementRouter

app = FastAPI()
core = Core()

core.register_plugin("external_service", "notification", NotificationService())
core.register_plugin("external_service", "advertisement", advertisementService())
app.include_router(notificationRouter)
app.include_router(authorizationRouter)
app.include_router(advertisementRouter)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
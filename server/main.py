from fastapi import Depends, FastAPI
from app.core import Core
from app.externalService.notification.notificationService import NotificationService
from app.routers.notificationRouter import router as notificationRouter

app = FastAPI()
core = Core()

core.register_plugin("external_service", "notification", NotificationService())
app.include_router(notificationRouter)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
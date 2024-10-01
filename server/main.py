from fastapi import Depends, FastAPI
from app.core import Core
from app.externalService.notification.notificationService import NotificationService
from app.externalService.payment.paymentService import PaymentService
from app.routers.notificationRouter import router as notificationRouter
from app.routers.authorizationRouter import router as authorizationRouter
from app.routers.paymentRouter import router as paymentRouter

app = FastAPI()
core = Core()

core.register_plugin("external_service", "notification", NotificationService())
# core.register_plugin("external_service", "notification", PaymentService())
app.include_router(notificationRouter)
app.include_router(authorizationRouter)
app.include_router(paymentRouter)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
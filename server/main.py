from fastapi import Depends, FastAPI
from app.core import Core
from app.externalService.advertisement.advertisementService import advertisementService
from app.externalService.payment.paymentService import PaymentService
from app.routers.authorizationRouter import router as authorizationRouter
from app.routers.advertisementRouter import router as advertisementRouter
from app.routers.profileRouter import router as profileRouter
from app.routers.postRouter import router as postRouter
from app.routers.paymentRouter import router as paymentRouter

app = FastAPI()
core = Core()

core.register_plugin("external_service", "advertisement", advertisementService(core.db))
core.register_plugin("external_service", "payment", PaymentService(core.db))
app.include_router(authorizationRouter)
app.include_router(advertisementRouter)
app.include_router(profileRouter)
app.include_router(postRouter)
app.include_router(paymentRouter)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
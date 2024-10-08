from fastapi import Depends, FastAPI
from app.core import Core
from app.routers.authorizationRouter import router as authorizationRouter
from app.routers.profileRouter import router as profileRouter
from app.routers.postRouter import router as postRouter
from app.routers.paymentRouter import router as paymentRouter

app = FastAPI()
core = Core()

app.include_router(authorizationRouter)
app.include_router(profileRouter)
app.include_router(postRouter)
app.include_router(paymentRouter)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="127.0.0.1", port=8013, reload=True)
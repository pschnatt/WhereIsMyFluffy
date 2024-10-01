from fastapi import APIRouter
from app.core import Core
from app.globalAdapter import GlobalAdapter
from app.model.advertisementModel import AdClick

router = APIRouter()
adapter = GlobalAdapter()
core = Core()

routerName = "advertisement"

@router.post(f"/{routerName}/ad-click/")
async def ad_click(data: AdClick):
      




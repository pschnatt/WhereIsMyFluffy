from fastapi import APIRouter
from app.core import Core
from app.globalAdapter import GlobalAdapter
from app.model.advertisementModel import AdClick

router = APIRouter()
adapter = GlobalAdapter()
core = Core()

routerName = "advertisement"

@router.post(f"/{routerName}/ad-click/")
def ad_click(data: AdClick):
    data_dict = data.model_dump()
    core.process(data_dict)
    return "Successfullly recorded AD clicked"


      




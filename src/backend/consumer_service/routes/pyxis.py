from fastapi import APIRouter
from controllers.pyxis import controller_get_all_pyxis, controller_get_pyxis_detail

router = APIRouter(prefix="/pyxis", tags=["pyxis"])


@router.get("/")
async def get_all():
    return await controller_get_all_pyxis()


@router.get("/{id}")
async def get_pyxi_detail(id: str):
    return await controller_get_pyxis_detail(id)

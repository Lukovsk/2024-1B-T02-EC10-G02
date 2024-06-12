from fastapi import APIRouter
from schemas.pyxis import CreatePyxiSchema
from controllers.pyxis import (
    controller_create_pyxi,
    controller_relate_item
)

router = APIRouter(prefix="/pyxis", tags=["pyxis"])

# Get all pyxis


@router.get("/all")
async def get_all_pyxis():
    return await controller_get_all()

# Get pyxis' detail


@router.get("/{pyxi_id}")
async def get_pyxis_detail(pyxi_id: str):
    return await controller_get_by_id(pyxi_id)

# Create a pyxi


@router.post("/")
async def create_pyxi(data: CreatePyxiSchema):
    return await controller_create_pyxi(
        name=data.name,
        reference=data.reference,
        sector=data.sector,
        ala=data.ala,
        floor=data.floor,
        items=data.items)

# Relate an item to a pyxi


@router.put("/item")
async def relate_item(data: CreatePyxiSchema):
    return await controller_relate_item(data)

# Change pyxi details


@router.put("/{pyxi_id}")
async def update_pyxi_detail(pyxi_id: str, data: CreatePyxiSchema):
    return await controller_update_pyxi(pyxi_id, data)

# Delete pyxi?

# Permanently delete a pyxi?

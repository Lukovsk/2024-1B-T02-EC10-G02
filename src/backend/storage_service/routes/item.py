from fastapi import APIRouter
from schemas.item import CreateItemSchema, CreateMedSchema
from controllers.item import (
    controller_get_all_medications,
    controller_create_medication,
    controller_create_item,
    controller_get_medication,
)

router = APIRouter(prefix="/item", tags=["itens"])


@router.get("/all")
async def list_all_items():
    return await controller_get_all_medications()


@router.post("/medication")
async def create_medication(medication_data: CreateMedSchema):
    return await controller_create_medication(
        name=medication_data.name,
        area=medication_data.area,
        description=medication_data.description,
        lot=medication_data.lot,
        medClass=medication_data.medClass,
    )
@router.post("/")
async def create_item(item_data: CreateItemSchema):
    return await controller_create_item(
        area=item_data.area,
        name=item_data.name,
        description=item_data.description,
    )

@router.get("/{id}")
async def get_medication(id: str):
    return await controller_get_medication(id)

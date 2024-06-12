from fastapi import APIRouter
from schemas.medication import MedSchema
from controllers.medicine import (
    controller_get_all_medications,
    controller_create_medication,
    controller_create_item,
    controller_get_medication,
)

router = APIRouter(prefix="/item", tags=["itens"])


@router.get("/all")
async def list_all_medications():
    return await controller_get_all_medications()


@router.post("/medication")
async def create_medication(medication_data: MedSchema):
    return await controller_create_medication(
        area=medication_data.area,
        name=medication_data.name,
        description=medication_data.description,
        lot=medication_data.lot,
        medClass=medication_data.medClass,
        isMedication=medication_data.isMedication,
        id=medication_data.id,
    )
@router.post("/")
async def create_item(item_data: MedSchema):
    return await controller_create_item(
        area=item_data.area,
        name=item_data.name,
        description=item_data.description,
        lot=item_data.lot,
        medClass=item_data.medClass,
        isMedication=item_data.isMedication,
        id=item_data.id,
    )

@router.get("/{id}")
async def get_medication(id: str):
    return await controller_get_medication(id)

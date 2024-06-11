from fastapi import Depends, APIRouter
from prisma.models import Medications
from schemas.medication import MedSchema
from storage_service.controllers.medicine import (
    controller_get_all_medications,
    controller_create_medication,
    controller_get_medication,
)

medication_routes = APIRouter(prefix="/medication", tags=["medication"])


@medication_routes.get("/all")
async def list_all_medications():
    return await controller_get_all_medications()


@medication_routes.post("/")
async def create_medication(medication_data: MedSchema):
    return await controller_create_medication(
        area=medication_data.area,
        description=medication_data.description,
        lot=medication_data.lot,
        medClass=medication_data.medClass,
    )


@medication_routes.get("/{id}")
async def get_medication(id: str):
    return await controller_get_medication(id)

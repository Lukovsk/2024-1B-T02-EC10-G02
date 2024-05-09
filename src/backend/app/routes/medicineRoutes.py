from fastapi import Depends, APIRouter
from prisma.models import Medications
from controllers.medicineController import MedicineController

medication_routes = APIRouter()

@medication_routes.post("/newMedications", response_model=None)
async def create_medication(medication: Medications):
    return await MedicineController.create_medication(medication)

@medication_routes.get("/medication/{medication_id}", response_model=Medications)
async def get_medication(medication_id: int):
    return await MedicineController.get_medication(medication_id)

@medication_routes.get("/medications", response_model=list[Medications])
def get_medicatoins():
    return MedicineController.get_all_medications()

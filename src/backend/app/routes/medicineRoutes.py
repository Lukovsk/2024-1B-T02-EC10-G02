from fastapi import Depends, APIRouter
from sqlalchemy.orm import Session
from ..model.model import Medication
from ..controller.medicineController import MedicineController
from ..main import get_db

medication_routes = APIRouter()

@medication_routes.post("/medications/", response_model=None)
async def create_medication(medication: Medication, db: Session = Depends(get_db)):
    return MedicineController.create_medication(db, medication)

@medication_routes.get("/medications/{medication_id}", response_model=None)
def read_medication(medication_id: int, db: Session = Depends(get_db)):
    return MedicineController.get_medication_by_id(db, medication_id)

@medication_routes.put("/medications/{medication_id}", response_model=None)
def update_medication(medication_id: int, updated_medication: Medication, db: Session = Depends(get_db)):
    return MedicineController.update_medication(db, medication_id, updated_medication)

@medication_routes.delete("/medications/{medication_id}")
def delete_medication(medication_id: int, db: Session = Depends(get_db)):
    return MedicineController.delete_medication(db, medication_id)

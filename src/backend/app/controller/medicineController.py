from fastapi import HTTPException
from ..model.model import MedicationBase
from sqlalchemy.orm import Session

class MedicineController:
    @staticmethod
    def create_medication(db: Session, medication: MedicationBase):
        db_medication = MedicationBase(**medication.dict())
        db.add(db_medication)
        db.commit()
        db.refresh(db_medication)
        return db_medication

    @staticmethod
    def get_medication_by_id(db: Session, medication_id: int):
        medication = db.query(MedicationBase).filter(MedicationBase.id == medication_id).first()
        if not medication:
            raise HTTPException(status_code=404, detail="Medication not found")
        return medication

    @staticmethod
    def update_medication(db: Session, medication_id: int, updated_medication: MedicationBase):
        medication = MedicineController.get_medication_by_id(db, medication_id)
        for key, value in updated_medication.dict().items():
            setattr(medication, key, value)
        db.commit()
        db.refresh(medication)
        return medication

    @staticmethod
    def delete_medication(db: Session, medication_id: int):
        medication = MedicineController.get_medication_by_id(db, medication_id)
        db.delete(medication)
        db.commit()
        return {"message": "Medication deleted successfully"}

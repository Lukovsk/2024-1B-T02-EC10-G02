from fastapi import HTTPException
from prisma import errors
from services.medication import MedicationService

async def controller_get_all_medications() -> dict:
    medication = MedicationService()
    try:
        all_medications = await medication.get_all_medications()
        return {"medications": all_medications}
    except HTTPException as e:
        raise HTTPException(status_code=e.status_code, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_medication(id: str) -> dict:
    medication = MedicationService(id=id)
    if id == "": 
        raise HTTPException(status_code=400, detail="Invalid parameters")
    try:
        medications = await medication.get_medication_by_id(id)
        return {"medications": medications}

    except errors.RecordNotFoundError:
        raise HTTPException(status_code=404, detail="User not found")

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_create_medication(area: str, description: str, lot: int, medClass: str) -> dict:
    medication = MedicationService(area=area, description=description, lot=lot, medClass=medClass, id=None)
    try:
        new_medication = await medication.create_medication()
        return {"message": "Medication created successfully", "medication": new_medication}
    except HTTPException as e:
        raise HTTPException(status_code=e.status_code, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def update_medication(id: str, update_data: dict) -> dict:
    try:
        updated_medication = await MedicationService().update_medication_by_id(id, update_data)
        return {"message": "Medication updated successfully", "medication": updated_medication}
    except HTTPException as e:
        raise HTTPException(status_code=e.status_code, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def delete_medication(id: str) -> dict:
    try:
        await MedicationService().delete_medication(id)
        return {"message": "Medication deleted successfully"}
    except HTTPException as e:
        raise HTTPException(status_code=e.status_code, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

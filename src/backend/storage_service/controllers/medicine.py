from fastapi import HTTPException
from services.medication import ItemService


async def controller_get_all_medications() -> dict:
    medication = ItemService()
    try:
        all_medications = await medication.get_all_Item()
        return {"Item": all_medications}
    except HTTPException as e:
        raise HTTPException(status_code=e.status_code, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_medication(id: str) -> dict:
    medication = ItemService(id=id)
    if id == "":
        raise HTTPException(status_code=400, detail="Invalid parameters")
    try:
        medications = await medication.get_medication_by_id(id)
        return {"medications": medications}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_create_medication(
    area: None, name: str, description: None, lot: None, medClass:None, isMedication: None, id: str
) -> dict:
    medication = ItemService(
        area=area, name=name, description=description, lot=lot, medClass=medClass, id=id, isMedication=isMedication
    )
    try:
        new_medication = await medication.create_medication()
        if new_medication:
            return {
                "message": "Medication created successfully",
                "medication": new_medication,
            }
        else:
            new_item = await medication.create_item()
            return {
                "message": "Item created successfully",
                "Itm": new_item,
            }
    except HTTPException as e:
        raise HTTPException(status_code=e.status_code, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_create_item(
    area: None, name: str, description: None, lot: None, medClass:None, isMedication: None, id: str
) -> dict:
    medication = ItemService(
        area=area, name=name, description=description, lot=lot, medClass=medClass, id=id, isMedication=isMedication
    )
    try:
        new_item = await medication.create_item()
        return {
            "message": "item created successfully",
            "Item": new_item,
        }
    except HTTPException as e:
        raise HTTPException(status_code=e.status_code, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def update_medication(id: str, update_data: dict) -> dict:
    try:
        updated_medication = await ItemService().update_medication_by_id(
            id, update_data
        )
        return {
            "message": "Medication updated successfully",
            "medication": updated_medication,
        }
    except HTTPException as e:
        raise HTTPException(status_code=e.status_code, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def delete_medication(id: str) -> dict:
    try:
        await ItemService().delete_medication(id)
        return {"message": "Medication deleted successfully"}
    except HTTPException as e:
        raise HTTPException(status_code=e.status_code, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

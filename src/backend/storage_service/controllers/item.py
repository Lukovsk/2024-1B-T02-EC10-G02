from fastapi import HTTPException
from services.item import ItemService


async def controller_get_all_medications() -> dict:
    item = ItemService()
    try:
        all_itens = await item.get_all_Item()
        return {"Item": all_itens}
    except HTTPException as e:
        raise HTTPException(status_code=e.status_code, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_medication(id: str) -> dict:
    item = ItemService(id=id)
    if id == "":
        raise HTTPException(status_code=400, detail="Invalid parameters")
    try:
        medications = await item.get_medication_by_id(id)
        return {"medications": medications}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_create_medication(
    name: str, area: str = None, description: str = None, lot: int = None, medClass:str = None
) -> dict:
    item = ItemService(
        area=area, name=name, description=description, lot=lot, medClass=medClass
    )
    try:
        new_medication = await item.create_medication()
        return {
            "message": "Medication created successfully",
            "medication": new_medication,
        }
    except HTTPException as e:
        raise HTTPException(status_code=e.status_code, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_create_item(
    name: str, area: str = None, description: str = None
) -> dict:
    medication = ItemService(
        area=area, name=name, description=description
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

from fastapi import HTTPException
from services.pyxis import PyxisService
from schemas.pyxis import CreatePyxiSchema


async def controller_get_all():
    pyxiService = PyxisService()
    try:
        pixyies = await pyxiService.get_all()

        return {"pyxis": pixyies}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_by_id(pyxy_id: str):
    pyxiService = PyxisService(id=pyxy_id)
    try:
        pyxi = await pyxiService.get_by_id()
        return {"pyxi": pyxi}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

from typing import List
async def controller_create_pyxi(name: str, reference: str = None, sector: str = None, ala: str = None, floor: str = None, items: List[str] = None):
    pyxiService = PyxisService(
        name=name,
        reference=reference,
        sector=sector,
        ala=ala,
        floor=floor,
        items=items,
    )

    try:
        pyxi = await pyxiService.create()

        return {"pyxi": pyxi}
    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"O erro tá aqui: {str(e)}")


async def controller_relate_item(pyxi_id: str, items: List[str]) -> dict:

    pyxiService = PyxisService(id=pyxi_id, items=items)
    try:
        pyxi = await pyxiService.relate_items()

        return {"pyxis": pyxi}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_update_pyxi(pyxi_id: str, data: CreatePyxiSchema):
    pyxiService = PyxisService(
        id=pyxi_id,
        name=data.name,
        reference=data.reference,
        sector=data.sector,
        ala=data.ala,
        floor=data.floor,
    )
    try:
        pyxi = await pyxiService.update()

        return {"pyxi": pyxi}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

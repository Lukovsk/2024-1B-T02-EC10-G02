from fastapi import HTTPException
from services.pyxis import PyxisService
from schemas.pyxis import CreatePyxiSchema


async def controller_create_pyxi(name: str, reference: str = None, sector: str = None, ala: str = None, floor: str = None, items: list[str] = None):
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


async def controller_relate_item(data: CreatePyxiSchema):
    try:
        pyxiService = PyxisService()
        await pyxiService.relate_item()
    except Exception as e:
        raise e


async def controller_update_pyxi(data: CreatePyxiSchema):
    try:
        pyxiService = PyxisService(
            name=data.name,
            reference=data.reference,
            sector=data.sector,
            ala=data.ala,
            floor=data.floor,
            items=data.items,
        )
        await pyxiService.update_item_item()
    except Exception as e:
        raise e

from fastapi import HTTPException
from services.pyxis import PyxisService


async def controller_get_pyxis_detail(id: str):
    pyxiService = PyxisService(id=id)
    try:
        pyxis = await pyxiService.get_pyxis()

        return {"pyxis": pyxis}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_all_pyxis():
    pyxiService = PyxisService()
    try:
        pyxis = await pyxiService.get_all()

        return {"pyxis": pyxis}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

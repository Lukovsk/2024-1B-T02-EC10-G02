from fastapi import HTTPException
from services.pyxis import PyxisService
import json
from services.redis import redis_client


async def controller_get_pyxis_detail(id: str):
    redis_id = f"pyxis:{id}"
    result = redis_client.get(redis_id)
    if result:
        return json.loads(result.decode())

    pyxiService = PyxisService(id=id)
    try:
        pyxis = await pyxiService.get_pyxis()

        redis_client.setex(redis_id, 60, json.dumps(pyxis).encode())

        return {"pyxis": pyxis}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_all_pyxis():
    redis_id = "allpyxis"
    result = redis_client.get(redis_id)
    if result:
        return {"pyxis": json.loads(result.decode())}

    pyxiService = PyxisService()
    try:
        pyxis = await pyxiService.get_all()

        redis_client.setex(redis_id, 120, json.dumps(pyxis).encode())

        return {"pyxis": pyxis}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

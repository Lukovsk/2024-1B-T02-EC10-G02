from fastapi import HTTPException
from services.queueConfig import create_order_queue, update_order_queue

async def controller_create_order(data):
    try:
        payload = {
            "order_status": "create",
            "data": data
        }
        order = create_order_queue(payload)
        return {"message": "Order created successfully", "order": order}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

async def controller_update_order(payload):
    try:
        order = await update_order_queue(payload)
        return {"message": "Order updated successfully", "order": order}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

async def controller_cancel_order(payload):
    try:
        order = await cancel_order(payload)
        return {"message": "Order canceled successfully", "order": order}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

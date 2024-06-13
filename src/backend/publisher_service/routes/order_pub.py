from fastapi import APIRouter, Body
from schemas.order import UpdateOrder, CreateOrder
from controllers.order_pub import controller_create_order, controller_update_order

router = APIRouter(prefix="/order", tags=["order_queue"])

@router.post("/")
async def create_order_endpoint(request: CreateOrder = Body()):
    payload = request.json()
    await controller_create_order(payload)
    return {"message":"Order queued succesfully"}

@router.put("/updatestatus")
async def update_order_endpoint(request: UpdateOrder = Body()):
    payload = request.dict()
    return await controller_update_order(payload)

@router.post("/cancel")
async def cancel_order_endpoint(request: UpdateOrder = Body()):
    payload = request.dict()
    return await controller_cancel_order()

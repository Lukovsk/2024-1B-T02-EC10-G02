from fastapi import APIRouter, Body
from schemas.order import UpdateOrder, CreateOrder
from controllers.queue import handle_create_order, handle_update_order

router = APIRouter()

@router.post("/queue/create")
async def create_order_endpoint(request: CreateOrder = Body()):
    payload = request.dict()
    print (payload)
    handle_create_order(payload)
    return {"message":"Order queued succesfully"}

@router.post("/queue/update")
async def update_order_endpoint(request: UpdateOrder = Body()):
    payload = request.dict()
    return await update_order_queue(payload)

@router.post("/queue/cancel")
async def cancel_order_endpoint(request: UpdateOrder = Body()):
    payload = request.dict()
    return await cancel_order_queue()

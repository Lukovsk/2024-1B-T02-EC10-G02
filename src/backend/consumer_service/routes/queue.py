from fastapi import APIRouter, Body
from schemas.order import UpdateOrder, CreateOrder
from controllers.queue import handle_create_order, handle_update_order

router = APIRouter(prefix="/queue", tags=["queue"])

@router.post("/neworder")
async def create_order_endpoint(request: CreateOrder = Body()):
    payload = request.dict()
    await handle_create_order(payload)
    return {"message":"Order queued succesfully"}




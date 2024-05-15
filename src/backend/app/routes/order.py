from fastapi import APIRouter
from controllers.order import get_all_orders, get_canceled_orders, get_receiver_orders, get_sender_orders, controller_create_order, controller_delete_order, controller_update_order, controller_cancel_order
from pydantic import BaseModel


app = APIRouter(prefix="/orders", tags=["order"])


@app.get("/sender/{sender_id}")
async def get_sender_orders_route(sender_id: str):
    return await get_sender_orders(sender_id)

@app.get("/receiver/{receiver_id}")
async def get_receiver_orders_route(receiver_id: str):
    return await get_receiver_orders(receiver_id)

@app.get("/")
async def get_all_orders_route():
    return await get_all_orders()

@app.get("/canceled")
async def get_canceled_orders_route():
    return await get_canceled_orders()

class CreateOrder(BaseModel):
    medicationId: str
    senderId: str
    status: str

@app.post("/")
async def create_order_route(data: CreateOrder):
    return await controller_create_order(data.medicationId, data.status, data.senderId)

class UpdateOrder(BaseModel):
    id: str
    medicationId: str | None = None
    senderId: str | None = None
    receiverId: str | None = None
    feedbackId: str | None = None
    canceled_reason: str | None = None
    canceled_userId: str | None = None

@app.put("/{order_id}")
async def update_order_route(order_id: str, new_data: UpdateOrder):
    return await controller_update_order(new_data, order_id)

class CancelateOrder(BaseModel):
    id: str
    reason: str
    userId: str

@app.put("/cancel/{order_id}")
async def cancel_order_route(data: CancelateOrder):
    return await controller_cancel_order(data.id, data.reason, data.userId)

@app.delete("/{order_id}")
async def delete_order_route(order_id: str):
    return await controller_delete_order(order_id)

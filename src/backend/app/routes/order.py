from fastapi import APIRouter
from controllers.order import (
    get_all_orders,
    get_canceled_orders,
    get_receiver_orders,
    get_sender_orders,
    controller_create_order,
    controller_delete_order,
    controller_update_order,
    controller_cancel_order,
    controller_update_status_accepted,
    controller_update_status_done,
    controller_get_last_pending_order
)
from schemas.order import CreateOrder, UpdateOrder, CancelateOrder
app = APIRouter(prefix="/orders", tags=["order"])


@app.get("/sender/{sender_id}")
async def get_sender_orders_route(sender_id: str):
    """Get sender (nurse) orders

    Args:
        sender_id (str): uuid of the user

    Returns:
        list[Prisma.order]: list of orders
    """
    return await get_sender_orders(sender_id)


@app.get("/receiver/{receiver_id}")
async def get_receiver_orders_route(receiver_id: str):
    """Get receiver (auxiliar) orders

    Args:
        receiver_id (str): uuid of the user

    Returns:
        list[Prisma.order]: list of orders
    """
    return await get_receiver_orders(receiver_id)

@app.get("/pending")
async def get_peding_order():
    return await controller_get_last_pending_order()


@app.get("/")
async def get_all_orders_route():
    """Get all orders not deleted for the admin

    Returns:
        list[dict]: list of orders
    """
    return await get_all_orders()


@app.get("/canceled")
async def get_canceled_orders_route():
    """Get canceled orders

    Returns:
        list[dict]: list of canceled orders
    """
    return await get_canceled_orders()


@app.put("/accepted/{order_id}")
async def update_status_order_accepted(order_id:str):
    return await controller_update_status_accepted(order_id)

@app.put("/done/{order_id}")
async def update_status_order_accepted(order_id:str):
    return await controller_update_status_done(order_id)


@app.post("/")
async def create_order_route(data: CreateOrder):
    """Create a new order

    Args:
        data (CreateOrder): medicationId, senderId and status are required parameters

    Returns:
        dict: the new order
    """
    return await controller_create_order(data.medicationId, data.status, data.senderId)


@app.put("/{order_id}")
async def update_order_route(order_id: str, new_data: UpdateOrder):
    return await controller_update_order(new_data, order_id)


@app.put("/cancel/{order_id}")
async def cancel_order_route(data: CancelateOrder):
    return await controller_cancel_order(data.id, data.reason, data.userId)


@app.delete("/{order_id}")
async def delete_order_route(order_id: str):
    return await controller_delete_order(order_id)

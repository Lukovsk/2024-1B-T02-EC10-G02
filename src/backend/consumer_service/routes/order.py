from fastapi import APIRouter
from controllers.order import (
    controller_get_receiver_orders,
    controller_get_sender_orders,
    controller_get_last_pending_order,
    controller_get_order_details,
    controller_get_pending_orders,
)

app = APIRouter(prefix="/orders", tags=["order"])


@app.get("/sender/{sender_id}")
async def get_sender_orders_route(sender_id: str):
    """Get sender (nurse) orders

    Args:
        sender_id (str): uuid of the user

    Returns:
        list[Prisma.order]: list of orders
    """
    return await controller_get_sender_orders(sender_id)


@app.get("/receiver/{receiver_id}")
async def get_receiver_orders_route(receiver_id: str):
    """Get receiver (auxiliar) orders

    Args:
        receiver_id (str): uuid of the user

    Returns:
        list[Prisma.order]: list of orders
    """
    return await controller_get_receiver_orders(receiver_id)

@app.get("/pending")
async def get_peding_orders():
    return await controller_get_pending_orders()

@app.get("/last_pending")
async def get_peding_order():
    return await controller_get_last_pending_order()


@app.get("/{order_id}")
async def get_order_details(order_id: str):
    return await controller_get_order_details(id=order_id)
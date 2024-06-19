from fastapi import APIRouter
from controllers.order import (
    controller_get_all_orders,
    controller_get_receiver_orders,
    controller_get_sender_orders,
    controller_get_accepted_orders,
    controller_get_canceled_orders,
    controller_get_last_pending_order,
    controller_get_pending_orders,
    controller_get_order_details,
    controller_accept_order,
    controller_cancel_order,
    controller_close_order,
    controller_create_stock_order,
    controller_create_technical_order,
    controller_delete_order,
)
from schemas.order import CreateOrder, UpdateOrder, CancelateOrder

app = APIRouter(prefix="/orders", tags=["order"])


@app.get("/sender/{sender_id}")
async def get_sender_orders_route(sender_id: str):
    """Get sender (nurse) orders

    Args:
        sender_id (str): uuid of the user

    Returns:
        list[dict]: list of orders
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


@app.get("/last_pending")
async def get_peding_order():
    return await controller_get_last_pending_order()


@app.get("/pending")
async def get_peding_orders():
    return await controller_get_pending_orders()


@app.get("/accepted")
async def get_accepted_orders():
    return await controller_get_accepted_orders()


@app.get("/canceled")
async def get_canceled_orders():
    return await controller_get_canceled_orders()


@app.get("/")
async def get_all_orders_route():
    """Get all orders not deleted for the admin

    Returns:
        list[dict]: list of orders
    """
    return await controller_get_all_orders()


@app.get("/{order_id}")
async def get_order_details(order_id: str):
    return await controller_get_order_details(orderId=order_id)


@app.post("/technical")
async def create_technical_order(data: CreateOrder):
    return await controller_create_technical_order(
        data.pyxiId, data.description, data.senderId
    )


@app.post("/stock")
async def create_stock_order(data: CreateOrder):
    return await controller_create_stock_order(
        data.pyxiId, data.senderId, data.itemId, data.description
    )


@app.put("/accept/{order_id}")
async def update_status_order_accepted(order_id: str, receiverId: str):
    return await controller_accept_order(order_id, receiverId)


@app.put("/close/{order_id}")
async def update_status_order_accepted(order_id: str):
    return await controller_close_order(order_id)


@app.put("/cancel/{order_id}")
async def cancel_order_route(order_id: str, data: CancelateOrder):
    return await controller_cancel_order(data.reason, data.userId, order_id)


@app.delete("/{order_id}")
async def delete_order_route(order_id: str):
    return await controller_delete_order(order_id)

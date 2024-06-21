import json
from services.order import OrderService
from fastapi import HTTPException
from services.redis import redis_client

# from prisma import errors


# Eu quero todos os meus pedidos
async def controller_get_sender_orders(senderId: str):
    redis_id = f"sender:{senderId}"
    result = redis_client.get(redis_id)

    if result:
        return json.loads(result.decode())

    orderService = OrderService(user=senderId)
    try:
        orders = await orderService.get_sender_orders()

        redis_client.setex(redis_id, 15, json.dumps(orders).encode())

        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_receiver_orders(receiverId: str):
    redis_id = f"receiver:{receiverId}"
    result = redis_client.get(redis_id)
    if result:
        return json.loads(result.decode())

    orderService = OrderService(user=receiverId)
    try:
        orders = await orderService.get_receiver_orders()

        redis_client.setex(redis_id, 15, json.dumps(orders).encode())

        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_order_details(id: str):
    redis_id = f"orderdetail:{id}"
    result = redis_client.get(redis_id)
    if result:
        return json.loads(result.decode())

    orderService = OrderService(id=id)
    try:
        order = await orderService.get_order_details()

        redis_client.setex(redis_id, 60, json.dumps(order).encode())

        return order
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_pending_orders():
    redis_id = "pendingorders"
    result = redis_client.get(redis_id)
    if result:
        return json.loads(result.decode())

    orderService = OrderService()
    try:
        orders = await orderService.get_all_pendings()

        redis_client.setex(redis_id, 30, json.dumps(orders).encode())

        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# Eu quero todos os pedidos


async def get_all_orders():
    redis_id = "allorders"
    result = redis_client.get(redis_id)
    if result:
        return json.loads(result.decode())

    orderService = OrderService()
    try:
        orders = await orderService.get_all()

        redis_client.setex(redis_id, 60, json.dumps(orders).encode())

        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_last_pending_order():
    orderService = OrderService()
    try:
        order = await orderService.get_last_pending()

        return order
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


from schemas.consumer import CreateOrder, AcceptOrder, DoneOrder, CancelOrder


def controller_create_order(data: CreateOrder):
    order = OrderService(
        senderId=data["sender_userId"],
        pyxiId=data["pyxiId"],
        description=data["description"],
        itemId=data["itemId"],
    )
    try:
        problem = data["problem"]
        new_order = order.create(problem)
    except Exception as e:
        print(f"Error creating order: {str(e)}")


def controller_accept_order(data: AcceptOrder):
    order = OrderService(
        receiverId=data["receiver_userId"],
        id=data["order_id"],
    )
    try:
        new_order = order.accept()
        print(new_order)
    except Exception as e:
        print(f"Error accepting order: {str(e)}")


def controller_done_order(data: DoneOrder):
    order = OrderService(
        id=data["order_id"],
    )
    try:
        new_order = order.done()
        print(new_order)
    except Exception as e:
        print(f"Error finishing order: {str(e)}")


def controller_cancel_order(data: CancelOrder):
    order = OrderService(
        id=data["order_id"],
        reason=data["canceled_reason"],
        canceledBy=data["canceled_userId"],
    )
    try:
        new_order = order.cancel()
        print(new_order)
    except Exception as e:
        print(f"Error canceling order: {str(e)}")

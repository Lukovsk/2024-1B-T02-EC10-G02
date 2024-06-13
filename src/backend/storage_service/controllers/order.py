from services.order import OrderService
from fastapi import HTTPException

# from prisma import errors


## Eu quero todos os meus pedidos
async def controller_get_sender_orders(senderId: str):
    orderService = OrderService(sender_userId=senderId)
    try:
        orders = await orderService.get_user_orders()

        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_receiver_orders(receiverId: str):
    orderService = OrderService(receiver_userId=receiverId)
    try:
        orders = await orderService.get_user_orders()

        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_order_details(orderId: str):
    orderService = OrderService(id=orderId)
    try:
        order = await orderService.get_by_id()
        return order
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


## Eu quero todos os pedidos
async def controller_get_all_orders():
    orderService = OrderService()
    try:
        orders = await orderService.get_all()

        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_last_pending_order():
    orderService = OrderService()
    try:
        orders = await orderService.get_all_by_status(status="PENDING")

        return orders[0]
    except IndexError as e:
        raise HTTPException(status_code=204, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_pending_orders():
    orderService = OrderService()
    try:
        orders = await orderService.get_all_by_status(status="PENDING")

        return orders
    except IndexError as e:
        raise HTTPException(status_code=204, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_accepted_orders():
    orderService = OrderService()
    try:
        orders = await orderService.get_all_by_status(status="ACCEPTED")
        return orders
    except IndexError as e:
        raise HTTPException(status_code=204, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


## Eu quero todos os pedidos cancelados
async def controller_get_canceled_orders():
    orderService = OrderService()
    try:
        orders = await orderService.get_canceled_orders()
        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


##


async def controller_create_technical_order(
    pyxiId: str, description: str, senderId: str
):
    order = OrderService(pyxiId=pyxiId, description=description, sender_userId=senderId)
    try:
        new_order = await order.create_technical()
        return {"message": f"Order {new_order.id} created successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_create_stock_order(
    pyxiId: str, senderId: str, itemId: str, description: str = None
):
    service = OrderService(
        pyxiId=pyxiId, description=description, sender_userId=senderId, itemId=itemId
    )
    try:
        new_order = await service.create_stock()
        return {"order": new_order}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_accept_order(orderId: str, receiverId: str):
    service = OrderService(id=orderId, receiver_userId=receiverId)
    try:
        order = await service.accept()
        return {"order": order}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_close_order(orderId: str):
    service = OrderService(id=orderId)
    try:
        order = await service.close()
        return {"order": order}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_cancel_order(reason: str, userId: str, orderId: str):
    service = OrderService(canceled_reason=reason, canceledBy=userId, id=orderId)
    try:
        order = await service.cancel()
        return {"order": order}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_delete_order(order_id: str):
    orderService = OrderService(id=order_id)
    try:
        if await orderService.delete():
            return {"message": f"Deleted order {order_id}"}
        else:
            raise HTTPException(status_code=400, detail="Could not delete order")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

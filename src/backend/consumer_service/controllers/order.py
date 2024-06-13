from services.order import OrderService
from fastapi import HTTPException
# from prisma import errors


# Eu quero todos os meus pedidos
async def controller_get_sender_orders(senderId: str):
    orderService = OrderService(user=senderId)
    try:
        orders = await orderService.get_sender_orders()

        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_receiver_orders(receiverId: str):
    orderService = OrderService(user=receiverId)
    try:
        orders = await orderService.get_receiver_orders()

        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_order_details(id: str):
    orderService = OrderService(id=id)
    try:
        order = await orderService.get_order_details()
        
        return order
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_pending_orders():
    orderService = OrderService()
    try:
        orders = await orderService.get_all_pendings()
        
        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Eu quero todos os pedidos


async def get_all_orders():
    orderService = OrderService()
    try:
        orders = await orderService.get_all()

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


async def controller_create_order(medicationId: str, senderId: str):
    order = OrderService(medicationId=medicationId, sender_userId=senderId)
    try:
        new_order = await order.create()
        return {"message": f"Order {new_order.id} created successfully"}
    except NameError:
        raise HTTPException(status_code=404, datail="Order already exists")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_update_order(new_data, order_id):
    orderService = OrderService(id=order_id)
    try:
        order = await orderService.update(new_data=new_data)
        return order
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
# FILA:

# async def controller_update_status(order_id):
#     OrderService = OrderService(id=order_id)
#     try:
#         order = orderService.update(new_data={"status": })

# DELETE


async def controller_update_status_accepted(id: str) -> dict:
    orderService = OrderService(id=id)
    try:
        order = await orderService.update_status_accepted(id)
        return {"message": f"Order {order.id} updated successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_update_status_done(id: str) -> dict:
    orderService = OrderService(id=id)
    try:
        order = await orderService.update_status_done(id)
        return {"message": f"Order {order.id} updated successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_cancel_order(order_id: str, reason: str, user_id: str):
    orderService = OrderService(
        id=order_id, canceled_reason=reason, canceledBy=user_id)
    try:
        if await orderService.cancel():
            return {"message": "Order canceled successfully"}
        else:
            raise HTTPException(
                status_code=400, detail="Failed to cancel order")
    except Exception as e:
        raise e


async def controller_delete_order(order_id: str):
    orderService = OrderService(id=order_id)
    try:
        if await orderService.delete():
            return {"message": f"Deleted order {order_id}"}
        else:
            raise HTTPException(
                status_code=400, detail="Could not delete order")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

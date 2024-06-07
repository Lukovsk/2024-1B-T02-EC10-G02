from services.order import OrderService
from fastapi import HTTPException
# from prisma import errors



## Eu quero todos os meus pedidos
async def get_sender_orders(senderId):
    orderService = OrderService(senderId=senderId)
    try:
        orders = orderService.get_closed_orders()
        
        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

async def get_receiver_orders(receiverId):
    orderService = OrderService(receiverId=receiverId)
    try:
        orders = orderService.get_closed_orders()
        
        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

## Eu quero todos os pedidos
async def get_all_orders():
    orderService = OrderService()
    try:
        orders = orderService.get_all()
        
        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

#TODO: Eu quero todos os pedidos de acordo com algum filtro 

## Eu quero todos os pedidos cancelados
async def get_canceled_orders():
    orderService = OrderService()
    try:
        orders = orderService.get_canceled_orders()
        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
## 

async def controller_create_order(medicationId: str, status: str, senderId: str):
    order = OrderService(medicationId=medicationId, status=status, senderId=senderId)
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
        order = orderService.update(new_data=new_data)
        return order
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

async def _update_status_aux(new_data, order_id):
    orderService = OrderService(id=order_id)
    try:
        order = orderService.update(new_data=new_data)
        return order
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
# FILA:

# async def controller_update_status(order_id):
#     OrderService = OrderService(id=order_id)
#     try:
#         order = orderService.update(new_data={"status": })

#DELETE

async def controller_cancel_order(order_id, reason, user_id):
    orderService = OrderService(id=order_id, canceled_reason=reason, canceledBy=user_id)
    try:
        if orderService.cancel():
            return {"message": "Order canceled successfully"}
        else:
            raise HTTPException(status_code=400, detail="Failed to cancel order")
    except Exception as e:
        raise e

async def controller_delete_order(order_id):
    orderService = OrderService(id=order_id)
    try:
        if orderService.delete():
            return {"message": f"Deleted order {order_id}"}
        else:
            raise HTTPException(status_code=400, detail="Could not delete order")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
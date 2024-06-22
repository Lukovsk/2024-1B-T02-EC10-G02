from fastapi import HTTPException
from services.queue import PubService
from schemas.order import Command, CreateOrder, AcceptOrder, DoneOrder, CancelOrder, RejectOrder
import json


async def controller_create_order(data: CreateOrder):
    payload = json.dumps(
        {"command": Command.create, "data": json.loads(data.model_dump_json())}
    )
    publisher = PubService(message=payload)
    try:
        publisher.publish()
        return {"message": "Order published successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_accept_order(data: AcceptOrder):
    payload = json.dumps(
        {"command": Command.accept, "data": json.loads(data.model_dump_json())}
    )
    publisher = PubService(message=payload)
    try:
        publisher.publish()
        return {"message": "Accepted order successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_done_order(data: DoneOrder):
    payload = json.dumps(
        {"command": Command.done, "data": json.loads(data.model_dump_json())}
    )
    publisher = PubService(message=payload)

    try:
        publisher.publish()
        return {"message": "Order done successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_cancel_order(data: CancelOrder):
    payload = json.dumps(
        {"command": Command.cancel, "data": json.loads(data.model_dump_json())}
    )
    publisher = PubService(message=payload)

    try:
        publisher.publish()
        return {"message": "Order canceled successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_reject_order(data: RejectOrder):
    payload = json.dumps(
        {"command": Command.reject, "data": json.loads(data.model_dump_json())}
    )
    publisher = PubService(message=payload)

    try:
        publisher.publish()
        return {"message": "Order rejected successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# async def controller_update_order(payload):
#     try:
#         order = await update_order_queue(payload)
#         return {"message": "Order updated successfully", "order": order}
#     except Exception as e:
#         raise HTTPException(status_code=500, detail=str(e))


# async def controller_cancel_order(payload):
#     try:
#         order = await cancel_order(payload)
#         return {"message": "Order canceled successfully", "order": order}
#     except Exception as e:
#         raise HTTPException(status_code=500, detail=str(e))

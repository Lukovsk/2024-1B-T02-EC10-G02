from fastapi import APIRouter, Body
from schemas.order import CreateOrder, AcceptOrder, DoneOrder, CancelOrder, RejectOrder
from controllers.order_pub import (
    controller_create_order,
    controller_accept_order,
    controller_cancel_order,
    controller_done_order,
    controller_reject_order,
)

router = APIRouter(prefix="/order", tags=["order_queue"])


@router.post("/")
async def create_order_endpoint(data: CreateOrder = Body()):
    return await controller_create_order(data)


@router.post("/accept")
async def accept_order_endpoint(data: AcceptOrder = Body()):
    return await controller_accept_order(data)


@router.post("/cancel")
async def cancel_order_endpoint(data: CancelOrder = Body()):
    return await controller_cancel_order(data)


@router.post("/reject")
async def reject_order_endpoint(data: RejectOrder = Body()):
    return await controller_reject_order(data)


@router.post("/done")
async def done_order_endpoint(data: DoneOrder = Body()):
    return await controller_done_order(data)

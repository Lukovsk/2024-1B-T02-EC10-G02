from fastapi import APIRouter
# from logs.logger import setup_logger
from controllers.user import (
    controller_login,
    update_aux_status
)
from schemas.user import LoginUserRequest

router = APIRouter(prefix="/user", tags=["user"])

@router.post("/login")
async def login(data: LoginUserRequest):
    return await controller_login(data)

@router.put("/status/{id}")
async def update_order_route(id: str):
    return await update_aux_status(id)
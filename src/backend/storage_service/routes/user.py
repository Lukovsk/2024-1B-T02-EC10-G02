from fastapi import APIRouter
from controllers.user import (
    controller_get_all_users,
    controller_get_user_by_id,
    controller_login,
    controller_update_user,
    controller_create_user,
    controller_delete_user,
    update_aux_status,
)
from schemas.user import UpdateUserRequest, CreateUserRequest, LoginUserRequest

router = APIRouter(prefix="/user", tags=["user"])


@router.post("/")
async def create_user(data: CreateUserRequest):
    return await controller_create_user(data)


@router.get("/all")
async def list_users():
    return await controller_get_all_users()


@router.post("/")
async def create_user(data: CreateUserRequest):
    return await controller_create_user(data.email, data.name, data.password)


@router.post("/login")
async def login(data: LoginUserRequest):
    return await controller_login(data.email, data.password)


@router.put("/update/{id}")
async def update_user_by_id(id: str, update_data: UpdateUserRequest):
    return await controller_update_user(update_data, id)


@router.delete("/delete/{id}")
async def delete_user(id: str):
    return await controller_delete_user(id)


@router.put("/status/{id}")
async def update_order_route(id: str):
    return await update_aux_status(id)

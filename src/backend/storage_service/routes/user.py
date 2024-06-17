from fastapi import APIRouter
from controllers.user import (
    controller_get_all_users,
    controller_get_user_by_id,
    controller_change_role,
    controller_login,
    controller_create_user,
    controller_delete_user,
    update_aux_status,
)
from schemas.user import CreateUserRequest, LoginUserRequest, Role

router = APIRouter(prefix="/user", tags=["user"])


@router.get("/all")
async def list_():
    return await controller_get_all_users()


@router.get("/{id}")
async def get_user_detail(id: str):
    return await controller_get_user_by_id(id)


@router.post("/")
async def create(data: CreateUserRequest):
    return await controller_create_user(data)


@router.post("/login")
async def login(data: LoginUserRequest):
    return await controller_login(data.email, data.password)


@router.put("/status/{id}")
async def update_aux(id: str):
    return await update_aux_status(id)


@router.put("/change_role/{id}")
async def change_role(id: str, new_role: Role):
    return await controller_change_role(id, new_role)


@router.delete("/{id}")
async def delete(id: str):
    return await controller_delete_user(id)

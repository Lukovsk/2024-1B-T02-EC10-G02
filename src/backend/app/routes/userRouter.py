from fastapi import APIRouter, HTTPException, Depends
from logs.logger import setup_logger
from controllers.userController import (
    controller_get_all_users,
    controller_get_user_by_id,
    controller_update_user,
    controller_create_user,
    controller_delete_user,
)
from schemas.user import UpdateUserRequest, CreateUserRequest

router = APIRouter(prefix="/user", tags=["user"])
logger = setup_logger('userRouter')

@router.post("/createUser")
async def create_user(user_data: CreateUserRequest):
    logger.info('Criando usuario')
    return await controller_create_user(
        email=user_data.email,
        name=user_data.name, 
        password=user_data.password
    )


@router.get("/all")
async def list_users():
    logger.info('Listando todos os usuarios')
    return await controller_get_all_users()


@router.put("/update/{id}")
async def update_user_by_id(id: str, update_data: UpdateUserRequest):
    logger.info(f'Atualizando usuario com id {id}')
    return await controller_update_user(update_data.dict(), id)


@router.delete("/delete/{id}")
async def delete_user(id: str):
    logger.info(f'Deletando usuario com id {id}')
    return await controller_delete_user(id)

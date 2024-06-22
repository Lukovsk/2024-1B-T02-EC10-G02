from fastapi import HTTPException
from services.user import UserService
from schemas.user import CreateUserRequest


async def controller_create_user(data: CreateUserRequest) -> dict:
    user = (
        UserService(email=data.email, name=data.name, password=data.password)
        if data.role is None
        else UserService(
            email=data.email, name=data.name, password=data.password, role=data.role
        )
    )
    try:
        new_user = await user.create()
        return {"message": f"User {new_user.name} created successfully"}

    except NameError as e:
        raise HTTPException(status_code=404, detail=str(e))

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_all_users() -> dict:
    userService = UserService()
    try:
        users = await userService.get_all_users()
        return {"users": users}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_get_user_by_id(id: str) -> dict:
    userService = UserService(id=id)
    try:
        user = await userService.get_user_by_id()
        return {"user": user}

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_update_user(update_data: dict, id) -> dict:
    userService = UserService(id=id)
    try:
        updated_user = await userService.update_user(update_data)
        return {"message": f"User {updated_user.name} updated successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_change_role(id: str, role: str):
    service = UserService(id=id, role=role)
    try:
        user = await service.update_role()
        return {"user": user}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_delete_user(id: str) -> dict:
    userService = UserService()
    try:
        await userService.delete_user(id)
        return {"message": f"User with id {id} deleted successfully"}

    except HTTPException:
        raise HTTPException(status_code=400, detail="Invalid parameters")

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def update_aux_status(id: str) -> dict:
    userService = UserService(id=id)
    try:
        updated_user = await userService.update_status(id)
        return {"message": f"User {updated_user.name} updated successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_login(email: str, password: str):
    userSerivce = UserService(email=email, password=password)
    try:
        user = await userSerivce.login()
        return {"user": user}
    except ValueError as wrong:
        raise HTTPException(status_code=401, detail=f"{str(wrong)}")
    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Error while logging in: ${str(e)}"
        )

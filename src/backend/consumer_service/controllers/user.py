from fastapi import HTTPException
from services.user import UserService


async def update_aux_status(id: str) -> dict:
    userService = UserService(id=id)
    try:
        await userService.change_status()
        return {"message": f"User updated successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_login(email: str, password: str):
    userService = UserService(email=email, password=password)
    # logService =
    try:
        user = await userService.login()

        return {"user": user}
    except ValueError as wrong:
        raise HTTPException(status_code=401, detail=f"{str(wrong)}")
    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Error while logging in: ${str(e)}")

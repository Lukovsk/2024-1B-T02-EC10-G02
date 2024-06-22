import json
from fastapi import HTTPException
from services.user import UserService
from schemas.user import LoginUserRequest
from services.redis import redis_client


async def update_aux_status(id: str) -> dict:
    userService = UserService(id=id)
    try:
        await userService.change_status()
        return {"message": f"User updated successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


async def controller_login(data: LoginUserRequest):
    redis_id = f"user:{data.email}"
    result = redis_client.get(redis_id)
    if result:
        return {"user": json.loads(result.decode())}

    userService = UserService(email=data.email, password=data.password)
    # logService =
    try:
        user = await userService.login()

        redis_client.setex(user["email"], 7200, json.dumps(user).encode())

        return {"user": user}
    except ValueError as wrong:
        raise HTTPException(status_code=401, detail=f"{str(wrong)}")
    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Error while logging in: ${str(e)}"
        )

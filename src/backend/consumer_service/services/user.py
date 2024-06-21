from fastapi import HTTPException
import requests
import os


class UserService:
    def __init__(
        self,
        id=None,
        email=None,
        password=None,
    ):
        self.id = id
        self.url = f'{os.getenv("AWS_HOST", "http://localhost")}:3000'
        self.prefix = "/user"

        self.email = email
        self.password = password

    async def login(self) -> dict:
        response = requests.post(
            self.url + self.prefix + "/login",
            json={"email": self.email, "password": self.password},
            headers={"Content-Type": "application/json", "accept": "application/json"},
        )

        if response.status_code == 200:
            data = response.json()
            return data["user"]
        else:
            raise HTTPException(status_code=response.status_code, detail=response)

    async def change_status(self) -> None:
        try:
            url = self.url + self.prefix + "/status/" + self.id
            response = requests.put(
                url,
                headers={
                    "Content-Type": "application/json",
                    "accept": "application/json",
                },
            )

            if response.status_code == 200:
                return
            else:
                # error = response.json()
                raise HTTPException(
                    status_code=response.status_code, detail="Error updating status"
                )
        except Exception as e:
            raise e

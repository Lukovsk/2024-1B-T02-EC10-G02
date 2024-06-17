from fastapi import HTTPException
import requests
import os

class PyxisService:
    def __init__(
        self,
        id=None,
    ):
        self.id = id
        self.url = f'{os.getenv("AWS_HOST", "http://localhost")}:3000'
        self.prefix = "/pyxis"

    async def get_all(self) -> dict:
        response = requests.get(
            self.url + self.prefix + "/all",
            headers={"Content-Type": "application/json", "accept": "application/json"},
        )

        if response.status_code == 200:
            data = response.json()
            return data["pyxis"]
        else:
            error = response.json()
            raise HTTPException(status_code=response.status_code, detail=error.detail)

    async def get_pyxis(self) -> None:
        try:
            url = self.url + self.prefix + "/" + self.id
            response = requests.get(
                url,
                headers={
                    "Content-Type": "application/json",
                    "accept": "application/json",
                },
            )

            if response.status_code == 200:
                data = response.json()
                return data["pyxi"]
            else:
                # error = response.json()
                raise HTTPException(
                    status_code=response.status_code, detail="Error getting pyxi"
                )
        except Exception as e:
            raise e

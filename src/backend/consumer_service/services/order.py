
from fastapi import HTTPException
import requests


class OrderService:
    def __init__(
        self,
        user=None,
        id=None,
    ):
        self.id = id
        self.user = user
        self.url = "http://localhost:3000"
        self.prefix = "/orders"

    async def get_receiver_orders(self) -> list:
        response = requests.get(self.url + self.prefix + "/receiver/" + self.user,
                                headers={
                                    "Accept": "application/json",
                                    "Content-Type": "application/json"
                                })

        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(
                status_code=response.status_code, detail="Errei fui mlk")

    async def get_sender_orders(self):
        response = requests.get(self.url + self.prefix + "/sender/" + self.user,
                                headers={
                                    "Accept": "application/json",
                                    "Content-Type": "application/json"
                                })

        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(
                status_code=response.status_code, detail="Errei fui mlk")

    async def get_all_pendings(self):
        response = requests.get(self.url + self.prefix + "/pending",
                                headers={
                                    "Accept": "application/json",
                                    "Content-Type": "application/json"
                                })

        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(
                status_code=response.status_code, detail="Errei fui mlk")

    async def get_order_details(self):
        response = requests.get(self.url + self.prefix + "/" + self.id,
                                headers={
                                    "Accept": "application/json",
                                    "Content-Type": "application/json"
                                })

        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(
                status_code=response.status_code, detail="Errei fui mlk")
        

    async def get_last_pending(self):
        response = requests.get(self.url + self.prefix + "/last_pending", headers={
            "Accept": "application/json",
            "Content-Type":"application/json"
        })

        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(
                status_code=response.status_code, detail="Errei fui mlk")

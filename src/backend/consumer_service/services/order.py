from fastapi import HTTPException
import requests
import os

class OrderService:
    def __init__(
        self,
        user=None,
        id=None,
        pyxiId=None,
        senderId=None,
        receiverId=None,
        description=None,
        itemId=None,
        reason=None,
        canceledBy=None,
    ):
        self.id = id
        self.user = user
        self.url = f'{os.getenv("AWS_HOST", "http://localhost")}:3000'
        self.prefix = "/orders"

        self.pyxiId = pyxiId
        self.senderId = senderId
        self.receiverId = receiverId
        self.description = description
        self.itemId = itemId

        self.reason = reason
        self.canceledBy = canceledBy

    async def get_receiver_orders(self) -> list:
        response = requests.get(
            self.url + self.prefix + "/receiver/" + self.user,
            headers={"Accept": "application/json", "Content-Type": "application/json"},
        )

        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(
                status_code=response.status_code, detail="Errei fui mlk"
            )

    async def get_sender_orders(self):
        response = requests.get(
            self.url + self.prefix + "/sender/" + self.user,
            headers={"Accept": "application/json", "Content-Type": "application/json"},
        )

        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(
                status_code=response.status_code, detail="Errei fui mlk"
            )

    async def get_all_pendings(self):
        response = requests.get(
            self.url + self.prefix + "/pending",
            headers={"Accept": "application/json", "Content-Type": "application/json"},
        )

        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(
                status_code=response.status_code, detail="Errei fui mlk"
            )

    async def get_order_details(self):
        response = requests.get(
            self.url + self.prefix + "/" + self.id,
            headers={"Accept": "application/json", "Content-Type": "application/json"},
        )

        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(
                status_code=response.status_code, detail="Errei fui mlk"
            )

    async def get_last_pending(self):
        response = requests.get(
            self.url + self.prefix + "/last_pending",
            headers={"Accept": "application/json", "Content-Type": "application/json"},
        )

        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(
                status_code=response.status_code, detail="Errei fui mlk"
            )

    def create(self, problem: str):
        response = requests.post(
            self.url + self.prefix + f"/{problem}",
            headers={"Accept": "application/json", "Content-Type": "application/json"},
            json={
                "pyxiId": self.pyxiId,
                "senderId": self.senderId,
                "description": self.description,
                "itemId": self.itemId,
            },
        )
        print(response.status_code)
        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(status_code=response.status_code, detail="Errei")

    def accept(self):
        response = requests.put(
            self.url + self.prefix + f"/accept/{self.id}?receiverId={self.receiverId}",
            headers={
                "Content-Type": "application/json",
                "Accept": "application/json",
            },
        )
        print(response.status_code)

        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(status_code=response.status_code, detail="Errei")

    def done(self):
        response = requests.put(
            self.url + self.prefix + f"/close/{self.id}",
            headers={
                "Content-Type": "application/json",
                "Accept": "application/json",
            },
        )
        print(response.status_code)

        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(status_code=response.status_code, detail="Errei")

    def cancel(self):
        response = requests.put(
            self.url + self.prefix + f"/cancel/{self.id}",
            headers={
                "Content-Type": "application/json",
                "Accept": "application/json",
            },
            json={
                "reason": self.reason,
                "userId": self.canceledBy,
            },
        )

        print(response.status_code)

        if response.status_code == 200:
            data = response.json()

            return data
        else:
            raise HTTPException(status_code=response.status_code, detail="Errei")

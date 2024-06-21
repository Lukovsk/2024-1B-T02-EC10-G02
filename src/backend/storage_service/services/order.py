from typing import List
from __init__ import db
from contextlib import asynccontextmanager
from prisma import errors, enums
import json
from datetime import datetime
from schemas.order import Status


class OrderService:
    def __init__(
        self,
        id=None,
        status=None,
        problem=None,
        pyxiId=None,
        description=None,
        itemId=None,
        sender_userId=None,
        receiver_userId=None,
        feedbackId=None,
        createdAt=None,
        canceledAt=None,
        canceledBy=None,
        canceled_reason=None,
        deleted=None,
    ):
        self.id = id
        self.status = status
        self.problem = problem
        self.pyxiId = pyxiId
        self.description = description
        self.itemId = itemId
        self.sender_userId = sender_userId
        self.receiver_userId = receiver_userId
        self.feedbackId = feedbackId
        self.createdAt = createdAt
        self.canceledAt = canceledAt
        self.canceledBy = canceledBy
        self.canceled_reason = canceled_reason
        self.deleted = deleted

    @asynccontextmanager
    async def database_connection(self):
        self.db = db
        await self.db.connect()
        try:
            yield
        finally:
            await self.db.disconnect()

    # Eu quero todos os pedidos
    async def get_all(self):
        async with self.database_connection():
            try:
                orders = await self.db.order.find_many(
                    where={
                        "deleted": False,
                    },
                    include={
                        "item": True,
                        "pyxis": True,
                        "sender_user": True,
                        "receiver_user": True,
                    },
                )
                return orders
            except Exception as e:
                raise e

    async def get_user_orders(self):
        async with self.database_connection():
            try:
                orders = (
                    await self.db.order.find_many(
                        where={
                            "deleted": False,
                            "sender_userId": self.sender_userId,
                        },
                        order={
                            "createdAt": "desc",
                        },
                        include={
                            "item": True,
                            "pyxis": True,
                            "sender_user": True,
                            "receiver_user": True,
                        },
                    )
                    if self.sender_userId
                    else await self.db.order.find_many(
                        where={
                            "deleted": False,
                            "receiver_userId": self.receiver_userId,
                        },
                        order={
                            "createdAt": "desc",
                        },
                        include={
                            "item": True,
                            "pyxis": True,
                            "sender_user": True,
                            "receiver_user": True,
                        },
                    )
                )
                return orders
            except Exception as e:
                raise e

    async def get_all_by_status(self, status: str):
        async with self.database_connection():
            try:
                orders = await self.db.order.find_many(
                    where={
                        "deleted": False,
                        "status": status,
                    },
                    order={
                        "createdAt": "desc",
                    },
                    include={
                        "item": True,
                        "pyxis": True,
                        "sender_user": True,
                        "receiver_user": True,
                    },
                )

                return orders
            except IndexError as e:
                raise IndexError(f"Nenhum pedido com o status {status}")
            except Exception as e:
                raise e

    async def get_canceled_orders(self):
        async with self.database_connection():
            try:
                orders = await self.db.order.find_many(
                    where={
                        "deleted": False,
                        "canceled": True,
                    },
                    include={
                        "item": True,
                        "pyxis": True,
                        "sender_user": True,
                        "receiver_user": True,
                        "canceledBy": True,
                    },
                )
                return orders
            except Exception as e:
                raise e

    # Quero meus pedidos em aberto
    async def get_open_orders(self):
        async with self.database_connection():
            try:
                orders = await self.db.order.find_many(
                    where={
                        "deleted": False,
                    },
                    include={
                        "item": True,
                        "pyxis": True,
                        "sender_user": True,
                        "receiver_user": True,
                    },
                )
                return orders
            except Exception as e:
                raise e

    # Eu quero um pedido
    async def get_by_id(self):
        async with self.database_connection():
            try:
                order = await self.db.order.find_unique_or_raise(
                    where={
                        "id": self.id,
                        "deleted": False,
                    },
                    include={
                        "sender_user": True,
                        "receiver_user": True,
                        "canceledBy": True,
                        "item": True,
                        "pyxis": True,
                    },
                )
                return order
            except Exception as e:
                raise e

    async def create_technical(self):
        async with self.database_connection():
            try:
                order = await self.db.order.create(
                    data={
                        "problem": "TECHNICAL",
                        "status": "PENDING",
                        "pyxiId": self.pyxiId,
                        "description": self.description,
                        "sender_userId": self.sender_userId,
                    }
                )
                return order
            except Exception as e:
                raise e

    async def create_stock(self):
        async with self.database_connection():
            try:
                order = await self.db.order.create(
                    data={
                        "problem": "STOCK",
                        "status": "PENDING",
                        "pyxiId": self.pyxiId,
                        "description": self.description,
                        "itemId": self.itemId,
                        "sender_userId": self.sender_userId,
                    }
                )
                return order
            except Exception as e:
                raise e

    async def accept(self):
        async with self.database_connection():
            try:
                order = await self.db.order.update(
                    where={
                        "id": self.id,
                        "deleted": False,
                    },
                    data={
                        "status": "ACCEPTED",
                        "receiver_userId": self.receiver_userId,
                    },
                )

                if order == None:
                    raise Exception("Order not found")

                return order
            except Exception as e:
                raise e

    async def close(self):
        async with self.database_connection():
            try:
                order = await self.db.order.update(
                    where={
                        "id": self.id,
                        "deleted": False,
                    },
                    data={
                        "status": "DONE",
                    },
                )

                if order == None:
                    raise Exception("Order not found")

                return order
            except Exception as e:
                raise e

    async def cancel(self):
        async with self.database_connection():
            try:
                order = await self.db.order.update(
                    where={
                        "id": self.id,
                        "deleted": False,
                    },
                    data={
                        "status": "CANCELED",
                        "canceled": True,
                        "canceled_reason": self.canceled_reason,
                        "canceled_userId": self.canceledBy,
                        "canceledAt": datetime.now(),
                    },
                )

                if order == None:
                    raise Exception("Order not found")

                return order
            except Exception as e:
                raise e

    # Quero deletar um pedido
    async def delete(self) -> bool:
        """update the order with deleted true, returns true if the order was 'deleted' successfully

        Raises:
            e: if any exception raises from here, log it to log service and define the exception

        Returns:
            bool: returns true if the order was 'deleted' successfully, raises exception otherwise
        """
        async with self.database_connection():
            try:
                await self.db.order.update(
                    where={
                        "id": self.id,
                    },
                    data={"deleted": True},
                )

                return True
            except Exception as e:
                raise e

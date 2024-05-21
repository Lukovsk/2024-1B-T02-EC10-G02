from __init__ import db
from contextlib import asynccontextmanager
from queueConfig import get_connection, create_topic
import json


class OrderService:
    def __init__(
        self,
        id=None,
        medicationId=None,
        status=None,
        senderId=None,
        receiverId=None,
        feedbackId=None,
        canceledAt=None,
        canceledBy=None,
        canceled_reason=None,
    ):
        self.id = id
        self.medicationId = medicationId
        self.status = status
        self.senderId = senderId
        self.receiverId = receiverId
        self.feedbackId = feedbackId
        self.canceledAt = canceledAt
        self.canceledBy = canceledBy
        self.canceled_reason = canceled_reason

    @asynccontextmanager
    async def database_connection(self):
        self.db = db
        await self.db.connect()
        try:
            yield
        finally:
            await self.db.disconnect()

    ## Eu quero todos os pedidos
    async def get_all(self):
        async with self.database_connection():
            try:
                orders = await self.db.order.find_many(
                    where={
                        "deleted": False,
                        "status": "CLOSED",  # TODO: change closed status to some enum in prisma
                    },
                )
                return orders
            except Exception as e:
                raise e

    async def get_closed_orders(self):
        async with self.database_connection():
            try:
                orders = (
                    await self.db.order.find_many(
                        where={
                            "deleted": False,
                            "status": "CLOSED",  #  TODO: change closed status to some enum from prisma
                            "senderId": self.senderId,
                        }
                    )
                    if self.senderId
                    else await self.db.order.find_many(
                        where={
                            "deleted": False,
                            "status": "CLOSED",  # TODO: change closed status to some enum from prisma
                            "receiverId": self.receiverId,
                        }
                    )
                )
                return orders
            except Exception as e:
                raise e

    async def get_canceled_orders(self):
        async with self.database_connection():
            try:
                orders = await self.db.order.find_many(
                    where={
                        "deleted": False,
                        "canceled": True,
                    }
                )
                return orders
            except Exception as e:
                raise e

    ## Quero meus pedidos em aberto
    async def get_open_orders(self):
        async with self.database_connection():
            try:
                orders = await self.db.order.find_many(
                    where={
                        "deleted": False,
                        "status": not "CLOSED",
                    },
                )
                return orders
            except Exception as e:
                raise e

    ## Eu quero um pedido
    async def get_by_id(self):
        async with self.database_connection():
            try:
                order = await self.db.order.find_unique_or_raise(
                    where={
                        "id": self.id,
                    },
                )
                return order
            except Exception as e:
                raise e


    def publish_to_queue(self, message):
        connection = get_connection()
        channel = connection.channel()
        channel.queue_declare(queue=create_topic)
        channel.basic_publish(
            exchange="",
            routing_key=create_topic,
            body=json.dumps(message),
        )
        connection.close()
    ## Quero adicionar um novo pedido
 
    async def create(self):
        async with self.database_connection():
            try:
                new_order = await self.db.order.create(
                    data={
                        "medicationId": self.medicationId,
                        "status": self.status,  # deve ser estado com um dos enums do prisma, como PENDING
                        "senderId": self.senderId,
                    }
                )
                await self.publish_to_queue({"action": "CREATE", "order": new_order.dict()})
                return new_order
            except Exception as e:
                raise e

    async def update(self, new_data):
        async with self.database_connection():
            try:
                order = await self.db.order.update(
                    where={
                        "id": self.id,
                    },
                    data={**new_data},
                )
                await self.publish_to_queue({"action": "UPDATE", "order": order.dict()})
                return order
            except Exception as e:
                raise e

    async def cancel(self) -> bool:
        import datetime

        async with self.database_connection():
            try:
                await self.db.order.update(
                    where={
                        "id": self.id,
                    },
                    data={
                        "canceled": True,
                        "canceled_reason": self.canceled_reason,
                        "canceledBy": self.canceledBy,
                        "canceledAt": datetime.datetime.now(),
                        "status": "CANCELED",  # TODO: change this status to an enum with prisma
                    },
                )
                self.publish_to_queue({"action": "CANCEL", "order_id": self.id})
                return True
            except Exception as e:
                raise e

    ## Quero deletar um pedido
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

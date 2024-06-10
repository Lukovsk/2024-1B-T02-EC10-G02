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
        medicationId=None,
        status=None,
        sender_userId=None,
        receiver_userId=None,
        feedbackId=None,
        createdAt=None,
        canceledAt=None,
        canceledBy=None,
        canceled_reason=None,
    ):
        self.id = id
        self.medicationId = medicationId
        self.status = status
        self.sender_userId = sender_userId
        self.receiver_userId = receiver_userId
        self.feedbackId = feedbackId
        self.createdAt = createdAt
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
                            "sender_userId": self.sender_userId,
                        }
                    )
                    if self.sender_userId
                    else await self.db.order.find_many(
                        where={
                            "deleted": False,
                            "receiver_userId": self.receiver_userId,
                        }
                    )
                )
                return orders
            except Exception as e:
                raise e
    
    async def get_all_by_status(self, status: str):
        async with self.database_connection():
            try:
                all_orders = await self.db.order.find_many(
                    where = {
                        "deleted": False,
                    },
                    order = {
                        "createdAt": "desc",
                    }
                )
                
                orders = [order for order in all_orders if status in order.status]
                
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
            
    async def create(self):
        async with self.database_connection():
            try:
                new_order = await self.db.order.create(
                    data={
                        "medicationId": self.medicationId,
                        "sender_userId": self.sender_userId,
                    }
                )
                
                return new_order
            except Exception as e:
                raise e
 
    async def create_in_db(self, payload):
        async with self.database_connection():
            try:
                new_order = await self.db.order.create(
                    data={
                        "medicationId": payload['medicationId'],
                        "sender_userId": payload['sender_userId'],
                        "status": payload.get('status',['PENDING']),
                        "createdAt": datetime.now()
                    }
                )
                print(f"Order stored successfully: {payload['medicationId']}")
            except Exception as e:
                print(f"Failed to store order: {e}")

    async def update_status_accepted(self, id=str):
        async with self.database_connection():
            try:
                order = await self.db.order.find_unique_or_raise(
                    where={
                        "id": id,
                    },
                )
                new_order = Status[order.status[0]]
                if new_order == Status.PENDING:
                    order_updated = await self.db.order.update(
                        where={
                            "id": id,
                        },
                        data={
                            "status": ['ACCEPTED'],
                        })
                    return order_updated
                else:
                    raise ValueError("Order is not pending")
            except errors.RecordNotFoundError:
                    raise ValueError("User not found")
            
    async def update_status_done(self, id=str):
        async with self.database_connection():
            try:
                order = await self.db.order.find_unique_or_raise(
                    where={
                        "id": id,
                    },
                )
                new_order = Status[order.status[0]]
                if new_order == Status.ACCEPTED:
                    order_updated = await self.db.order.update(
                        where={
                            "id": id,
                        },
                        data={
                            "status": ['DONE'],
                        })
                    return order_updated
                else:
                    raise ValueError("Order is not accepted")
            except errors.RecordNotFoundError:
                    raise ValueError("User not found")


    # async def update(self, new_data):
    #     async with self.database_connection():
    #         try:
    #             order = await self.db.order.update(
    #                 where={
    #                     "id": self.id,
    #                 },
    #                 data={**new_data},
    #             )
    #             await self.publish_to_queue({"action": "UPDATE", "order": order.dict()})
    #             return order
    #         except Exception as e:
    #             raise e

    # async def cancel(self) -> bool:
    #     import datetime

    #     async with self.database_connection():
    #         try:
    #             await self.db.order.update(
    #                 where={
    #                     "id": self.id,
    #                 },
    #                 data={
    #                     "canceled": True,
    #                     "canceled_reason": self.canceled_reason,
    #                     "canceledBy": self.canceledBy,
    #                     "canceledAt": datetime.datetime.now(),
    #                     "status": "CANCELED",  # TODO: change this status to an enum with prisma
    #                 },
    #             )
    #             self.publish_to_queue({"action": "CANCEL", "order_id": self.id})
    #             return True
    #         except Exception as e:
    #             raise e

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

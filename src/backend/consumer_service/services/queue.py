from pydantic import BaseModel
from typing import Optional
import http
import os
import pika
import json
from schemas.consumer import Command


class CreateOrder(BaseModel):
    problem: str
    pyxisId: str
    senderId: str

    description: Optional[str]
    itemId: Optional[str]


class Payload(BaseModel):
    order_status: str
    data: CreateOrder


def controller_create_order(data: CreateOrder):
    pass



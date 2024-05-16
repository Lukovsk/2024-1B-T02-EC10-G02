# Serviço 2 - recebe as mensagens via RabbitMQ e as armazena em um banco de dados em memória

from fastapi import APIRouter
import os
from schemas.order import CreateOrder
from controllers.order import controller_create_order
from controllers.queue import send_new_order
from queueConfig import create_topic

# Ajuste para tentar reconectar ao RabbitMQ
from pika.connection import Parameters

Parameters.DEFAULT_CONNECTION_ATTEMPTS = 10


app = APIRouter(prefix="/queues", tags=["RabbitMQ"])


@app.post("/")
async def create_order(message: CreateOrder):
    return send_new_order(message, create_topic)


# @app.put("/")
# async def accepct_order()

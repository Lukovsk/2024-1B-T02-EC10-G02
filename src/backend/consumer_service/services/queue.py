from pydantic import BaseModel
from typing import Optional
import http
import os
import pika
# from controllers.queue import handle_create_order, handle_update_order, handle_cancel_order
import json
from ..services.order import OrderService
import asyncio


def get_connection():
    rabbitmq_host = "localhost"  # os.getenv('RABBITMQ_HOST', 'localhost')
    rabbitmq_port = 5672  # int(os.getenv('RABBITMQ_PORT', 5672))
    rabbitmq_user = "inteli"  # os.getenv('RABBITMQ_DEFAULT_USER', 'inteli')
    # os.getenv('RABBITMQ_DEFAULT_PASS', 'inteli_secret')
    rabbitmq_pass = "inteli_secret"

    credentials = pika.PlainCredentials(rabbitmq_user, rabbitmq_pass)
    parameters = pika.ConnectionParameters(
        host=rabbitmq_host,
        port=rabbitmq_port,
        credentials=credentials
    )

    connection = pika.BlockingConnection(parameters)
    return connection


# create_topic = os.environ["RABBITMQ_QUEUE_CREATE_ORDER"]
# accept_topic = os.environ["RABBITMQ_QUEUE_ACCEPT_ORDER"]
# refuse_topic = os.environ["RABBITMQ_QUEUE_REFUSE_ORDER"]
# complete_topic = os.environ["RABBITMQ_QUEUE_COMPLETE_ORDER"]
# cancel_topic = os.environ["RABBITMQ_QUEUE_CANCEL_ORDER"]
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


def callback(ch, method, properties, body):
    payload = json.loads(body)

    print(body, payload)

    command = payload.get("order_status")
    url = ""
    match command:
        case "cancelled":
            pass
        case "completed":
            pass
        case "created":

            response = http.post(url, data=payload)
        case "accepted":
            pass
        case "rejected":
            pass


def consume_order_queue():
    connection = get_connection()
    channel = connection.channel()
    channel.queue_declare(queue='create_order_queue', durable=True)

    channel.basic_consume(queue='create_order_queue',
                          on_message_callback=callback, auto_ack=True)
    channel.start_consuming()

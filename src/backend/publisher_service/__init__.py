import pika
import json
from dotenv import load_dotenv

load_dotenv()


def get_connection():
    import os

    rabbitmq_host = os.getenv("RABBITMQ_HOST", "50.19.149.200")
    rabbitmq_port = int(os.getenv("RABBITMQ_PORT", 5672))
    rabbitmq_user = os.getenv("RABBITMQ_DEFAULT_USER", "inteli")
    rabbitmq_pass = os.getenv("RABBITMQ_DEFAULT_PASS", "inteli_secret")

    credentials = pika.PlainCredentials(rabbitmq_user, rabbitmq_pass)
    parameters = pika.ConnectionParameters(
        host=rabbitmq_host, port=rabbitmq_port, credentials=credentials
    )

    connection = pika.BlockingConnection(parameters)
    return connection


def publish(message):
    connection = get_connection()
    channel = connection.channel()
    channel.queue_declare(queue="order_queue", durable=True)

    channel.basic_publish(
        exchange="",
        routing_key="order_queue",
        body=json.dumps(message),
        properties=pika.BasicProperties(
            delivery_mode=2,
        ),
    )
    connection.close()

import os
import pika


def get_connection():
    credentials = pika.PlainCredentials(
        os.environ["RABBITMQ_DEFAULT_USER"], os.environ["RABBITMQ_DEFAULT_PASS"]
    )
    connection = pika.BlockingConnection(
        pika.ConnectionParameters(
            os.environ["RABBITMQ_HOST"], os.environ["RABBITMQ_PORT"], "/", credentials
        )
    )

    return connection


create_topic = os.environ["RABBITMQ_QUEUE_CREATE_ORDER"]
accept_topic = os.environ["RABBITMQ_QUEUE_ACCEPT_ORDER"]
refuse_topic = os.environ["RABBITMQ_QUEUE_REFUSE_ORDER"]
complete_topic = os.environ["RABBITMQ_QUEUE_COMPLETE_ORDER"]
cancel_topic = os.environ["RABBITMQ_QUEUE_CANCEL_ORDER"]

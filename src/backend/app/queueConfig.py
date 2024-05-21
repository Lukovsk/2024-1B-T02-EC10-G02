import os
import pika



def get_connection():
    rabbitmq_host = os.getenv('RABBITMQ_HOST', 'localhost')
    rabbitmq_port = int(os.getenv('RABBITMQ_PORT', 5672))
    rabbitmq_user = os.getenv('RABBITMQ_DEFAULT_USER', 'inteli')
    rabbitmq_pass = os.getenv('RABBITMQ_DEFAULT_PASS', 'inteli_secret')
    
    credentials = pika.PlainCredentials(rabbitmq_user, rabbitmq_pass)
    parameters = pika.ConnectionParameters(
        host=rabbitmq_host,
        port=rabbitmq_port,
        credentials=credentials
    )

    connection = pika.BlockingConnection(parameters)
    return connection


create_topic = os.environ["RABBITMQ_QUEUE_CREATE_ORDER"]
accept_topic = os.environ["RABBITMQ_QUEUE_ACCEPT_ORDER"]
refuse_topic = os.environ["RABBITMQ_QUEUE_REFUSE_ORDER"]
complete_topic = os.environ["RABBITMQ_QUEUE_COMPLETE_ORDER"]
cancel_topic = os.environ["RABBITMQ_QUEUE_CANCEL_ORDER"]

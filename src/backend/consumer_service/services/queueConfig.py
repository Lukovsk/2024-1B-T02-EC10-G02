import os
import pika
#from controllers.queue import handle_create_order, handle_update_order, handle_cancel_order
import json
from ...storage.services.order import OrderService
import asyncio



def get_connection():
    rabbitmq_host = "localhost"#os.getenv('RABBITMQ_HOST', 'localhost')
    rabbitmq_port = 5672#int(os.getenv('RABBITMQ_PORT', 5672))
    rabbitmq_user = "inteli"#os.getenv('RABBITMQ_DEFAULT_USER', 'inteli')
    rabbitmq_pass = "inteli_secret"#os.getenv('RABBITMQ_DEFAULT_PASS', 'inteli_secret')
    
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


def publish_order(queue_name, message):
    connection = get_connection()
    channel = connection.channel()
    channel.queue_declare(queue=queue_name, durable=True)  # Durable to ensure it persists  

    channel.basic_publish(
        exchange='',
        routing_key=queue_name,
        body=json.dumps(message),
        properties=pika.BasicProperties(
            delivery_mode=2,  # Make message persistent
        ))
    connection.close()


def create_order_queue(payload):
    publish_order('create_order_queue', payload)

def publish_update(queue_name, message):
    connection = get_connection()
    channel = connection.channel()
    channel.queue_declare(queue=queue_name, durable=True)  # Durable to ensure it persists  

    channel.basic_publish(
        exchange='',
        routing_key=queue_name,
        body=json.dumps(message),
        properties=pika.BasicProperties(
            delivery_mode=2,  # Make message persistent
        ))
    connection.close()

def update_order_queue(payload):
    publish_update('update_order_queue', payload)

def consume_order_queue():
    connection = get_connection()
    channel = connection.channel()
    channel.queue_declare(queue='create_order_queue', durable=True)

    order_service = OrderService()

    def callback(ch, method, properties, body):
        payload = json.loads(body)
        # print(body)
        asyncio.run(order_service.create_in_db(payload))

    channel.basic_consume(queue='create_order_queue', on_message_callback=callback, auto_ack=True)
    channel.start_consuming()
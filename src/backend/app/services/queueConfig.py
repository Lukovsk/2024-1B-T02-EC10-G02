import os
import pika
#from controllers.queue import handle_create_order, handle_update_order, handle_cancel_order
import json



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

# def cancel_order_queue():
#     connection = get_connection()
#     channel = connection.channel()
#     channel.queue_declare(queue='cancel_order_queue', durable=True)

#     def callback(ch, method, properties, body):
#         payload = json.loads(body)
#         asyncio.run(handle_cancel_order(payload))

#     channel.basic_consume(queue='cancel_order_queue', on_message_callback=callback, auto_ack=True)
#     channel.start_consuming()
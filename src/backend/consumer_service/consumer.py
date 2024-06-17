from routes.consumer import callback

import pika

import os

def get_connection():
    rabbitmq_host = os.getenv('RABBITMQ_HOST', 'localhost')
    rabbitmq_port =  int(os.getenv('RABBITMQ_PORT', 5672))
    rabbitmq_user =  os.getenv('RABBITMQ_DEFAULT_USER', 'inteli')
    rabbitmq_pass = os.getenv('RABBITMQ_DEFAULT_PASS', 'inteli_secret')

    credentials = pika.PlainCredentials(rabbitmq_user, rabbitmq_pass)
    parameters = pika.ConnectionParameters(
        host=rabbitmq_host, port=rabbitmq_port, credentials=credentials
    )

    connection = pika.BlockingConnection(parameters)
    return connection


def consume_order_queue():
    connection = get_connection()
    channel = connection.channel()
    channel.queue_declare(queue="order_queue", durable=True)
    try:
        channel.basic_consume(
            queue="order_queue", on_message_callback=callback, auto_ack=True
        )
        print("Consumer service started")
        channel.start_consuming()
    except Exception as e:
        print(f"An exception occurred: {e}")
        print(f"Finalizando a execução da thread")
        channel.stop_consuming()
        channel.close()


if __name__ == "__main__":
    try:
        print("Starting consumer service")
        consume_order_queue()
    except KeyboardInterrupt as key:
        print("Finishing consumer service")
    except Exception as e:
        print(f"Exception caught: {str(e)}")

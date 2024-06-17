from routes.consumer import callback
from dotenv import load_dotenv
import pika
import os


load_dotenv()


def get_connection():
    try:

        rabbitmq_host = os.getenv("RABBITMQ_HOST", "50.19.149.200")
        rabbitmq_port = int(os.getenv("RABBITMQ_PORT", 5672))
        rabbitmq_user = os.getenv("RABBITMQ_DEFAULT_USER", "inteli")
        rabbitmq_pass = os.getenv("RABBITMQ_DEFAULT_PASS", "inteli_secret")

        print(os.getenv("RABBITMQ_HOST"))
        credentials = pika.PlainCredentials(rabbitmq_user, rabbitmq_pass)
        parameters = pika.ConnectionParameters(
            host=rabbitmq_host, port=rabbitmq_port, credentials=credentials
        )

        connection = pika.BlockingConnection(parameters)
        return connection
    except Exception as e:
        print("Error in get_connection: ", str(e))
        raise e


def consume_order_queue():
    try:
        connection = get_connection()
        channel = connection.channel()
        channel.queue_declare(queue="order_queue", durable=True)
        channel.basic_consume(
            queue="order_queue", on_message_callback=callback, auto_ack=True
        )
        print("Consumer service started")
        channel.start_consuming()
    except Exception as e:
        print(f"An exception occurred: {str(e)}")
        channel.stop_consuming()
        channel.close()
        raise e


if __name__ == "__main__":
    try:
        print("Starting consumer service")
        consume_order_queue()
    except KeyboardInterrupt as key:
        print("Finishing consumer service")
    except Exception as e:
        print(f"Exception caught: {str(e)}")

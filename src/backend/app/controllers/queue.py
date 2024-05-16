from queueConfig import get_connection, create_topic

# from controllers.order import controller_create_order


def create_callback(ch, method, properties, body):
    print(f" [x] Received {body}")


# Cria uma função que recebe as mensagens para o RabbitMQ
def create_order_queue():
    import os

    connection = get_connection()
    channel = connection.channel()
    channel.queue_declare(queue=create_topic)
    channel.basic_consume(
        queue=create_topic,
        on_message_callback=create_callback,
    )
    channel.start_consuming()


# For debug


def send_new_order(msg, topic):
    import os

    connection = get_connection()

    channel = connection.channel()
    channel.queue_declare(queue=topic)
    channel.basic_publish(
        exchange="",
        routing_key=topic,
        body=f"{msg}",
    )
    connection.close()

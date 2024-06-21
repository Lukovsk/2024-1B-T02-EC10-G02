from __init__ import get_connection
import json
import pika


class PubService:
    def __init__(self, message=None) -> None:
        self.connection = get_connection()
        self.queue = "order_queue"
        self.message = message

    def _create_channel(self):
        channel = self.connection.channel()
        channel.queue_declare(queue=self.queue, durable=True)

        return channel

    def publish(self):

        channel = self._create_channel()

        channel.basic_publish(
            exchange="",
            routing_key=self.queue,
            body=self.message,
            properties=pika.BasicProperties(
                delivery_mode=2,
            ),
        )

        self.connection.close()

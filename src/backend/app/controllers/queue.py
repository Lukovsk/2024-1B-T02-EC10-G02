from queueConfig import get_connection, create_topic

# from controllers.order import controller_create_order


async def create_callback(ch, method, properties, body):
    message = json.loads(body)
    action = message.get("action")
    order_data = message.get("order")
    if action == "CREATE":
        # Processar criação de pedido
        order_service = OrderService(
            id=order_data['id'],
            medicationId=order_data['medicationId'],
            senderId=order_data['senderId'],
            status=order_data['status'],
        )
        await order_service.create()


    if action == "UPDATE":
        # Processar atualização de pedido
        order_service = OrderService(id=order_data['id'])
        await order_service.update(new_data=order_data)

    print(f" [x] Processed {body}")


    if action == "CANCEL":
        order_id = message.get("order_id")
        order_service = OrderService(id=order_id)
        try:
            order_service.cancel()
        except prisma_errors.PrismaError as e:
            print(f"Failed to cancel order: {e}")
    print(f" [x] Received {message}")


# Cria uma função que recebe as mensagens para o RabbitMQ
def create_order_queue():
    connection = get_connection()
    channel = connection.channel()
    channel.queue_declare(queue=create_topic)
    channel.basic_consume(
        queue=create_topic,
        on_message_callback=create_callback,
        auto_ack=True,
    )
    channel.start_consuming()

def send_new_order(msg, topic):
    connection = get_connection()
    channel = connection.channel()
    channel.queue_declare(queue=topic)
    channel.basic_publish(
        exchange="",
        routing_key=topic,
        body=json.dumps(msg),
    )
    connection.close()

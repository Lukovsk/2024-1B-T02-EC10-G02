---
title: Sistema de fila
sidebar_position: 2
---

# Implementação do fluxo do pedido com a fila

Esta seção consiste em explicitar dois serviços separados que interagem entre si usando RabbitMQ. Um serviço publica pedidos em uma fila, enquanto o outro consome esses pedidos e os armazena em um banco de dados PostgreSQL.

## Estrutura do Projeto

O projeto está organizado em dois serviços principais:

1. **Serviço 1 - main.py**: Publica pedidos na fila RabbitMQ a partir de uma rota HTTP.
2. **Serviço 2 - consume.py**: Consome os pedidos da fila e os armazena em um banco de dados.

### Serviço 1 - Publicador de Pedidos

Este serviço expõe uma API HTTP que permite a criação de pedidos. Quando um pedido é criado, ele é publicado na fila RabbitMQ.

#### Estrutura de Diretórios

- `app/`
  - `controllers/`
    - `queue.py` - Define as funções de controle para criar pedidos.
  - `services/`
    - `queueConfig.py` - Define funções para conexão com RabbitMQ e publicação na fila.
  - `routes/`
    - `queue.py` - Define as rotas da API para publicação das mensagens na fila.
  - `schemas/`
    - `order.py` - Define a estrutura de dados a serem enviados pra fila e armazenados no banco. 
  - `main.py` - Instancia a aplicação FastAPI e configura as rotas.

#### Arquivos Importantes

##### `queueConfig.py`

Este arquivo contém funções para configurar a conexão com RabbitMQ e publicar mensagens na fila.

```python
import os
import pika
import json
from .order import OrderService
import asyncio

def get_connection():
    rabbitmq_host = os.getenv('RABBITMQ_HOST')
    rabbitmq_port = int(os.getenv('RABBITMQ_PORT'))
    rabbitmq_user = os.getenv('RABBITMQ_DEFAULT_USER')
    rabbitmq_pass = os.getenv('RABBITMQ_DEFAULT_PASS')
    
    credentials = pika.PlainCredentials(rabbitmq_user, rabbitmq_pass)
    parameters = pika.ConnectionParameters(
        host=rabbitmq_host,
        port=rabbitmq_port,
        credentials=credentials
    )

    connection = pika.BlockingConnection(parameters)
    return connection

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
```

##### `queue.py` (Controller)

Este arquivo define as funções de controle para criar pedidos.

```python
from fastapi import HTTPException
from services.queueConfig import create_order_queue

async def handle_create_order(payload):
    try:
        order = create_order_queue(payload)
        return {"message": "Order created successfully", "order": order}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

```

##### `queue.py` (Routes)

Define as rotas da API.

```python
from fastapi import APIRouter, Body
from schemas.order import UpdateOrder, CreateOrder
from controllers.queue import handle_create_order

router = APIRouter(prefix="/queue", tags=["queue"])

@router.post("/neworder")
async def create_order_endpoint(request: CreateOrder = Body()):
    payload = request.dict()
    await handle_create_order(payload)
    return {"message":"Order queued succesfully"}
```

##### `main.py`

Instancia a aplicação FastAPI e configura as rotas.

```python
from fastapi import FastAPI
from app.routes.queue import router as queue_router

app = FastAPI()

app.include_router(queue_router)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

### Serviço 2 - Consumer de Pedidos

Este serviço consome os pedidos da fila RabbitMQ e os armazena em um banco de dados.

#### Estrutura de Diretórios

- `app/`
  - `services/`
    - `queueConfig.py` - Define a função para consumir mensagens da fila.
    - `order.py` - Define a lógica de negócios para armazenar pedidos no banco de dados.
  - `consume.py` - Instancia a aplicação FastAPI e inicia a thread para consumir mensagens.

#### Arquivos Importantes

##### `queueConfig.py`

Define a função para consumir mensagens da fila.

```python
import os
import pika
import json
import asyncio
from .order import OrderService

def get_connection():
    rabbitmq_host = os.getenv('RABBITMQ_HOST')
    rabbitmq_port = int(os.getenv('RABBITMQ_PORT'))
    rabbitmq_user = os.getenv('RABBITMQ_DEFAULT_USER')
    rabbitmq_pass = os.getenv('RABBITMQ_DEFAULT_PASS')
    
    credentials = pika.PlainCredentials(rabbitmq_user, rabbitmq_pass)
    parameters = pika.ConnectionParameters(
        host=rabbitmq_host,
        port=rabbitmq_port,
        credentials=credentials
    )

    connection = pika.BlockingConnection(parameters)
    return connection

def consume_order_queue():
    connection = get_connection()
    channel = connection.channel()
    channel.queue_declare(queue='create_order_queue', durable=True)

    order_service = OrderService()  # Instância do OrderService

    def callback(ch, method, properties, body):
        payload = json.loads(body)
        print(body)
        asyncio.run(order_service.create_in_db(payload))

    channel.basic_consume(queue='create_order_queue', on_message_callback=callback, auto_ack=True)
    channel.start_consuming()
```

##### `order.py` (Service)

Define a lógica de negócios para armazenar pedidos no banco de dados.

```python
from prisma import Prisma
from datetime import datetime
from contextlib import asynccontextmanager

class OrderService:
    def __init__(self):
        self.db = Prisma()
        self.createdAt = datetime.now()

    @asynccontextmanager
    async def database_connection(self):
        await self.db.connect()
        try:
            yield
        finally:
            await self.db.disconnect()

    async def create_in_db(self, payload):
        async with self.database_connection():
            try:
                new_order = await self.db.order.create(
                    data={
                        "medicationId": payload['medicationId'],
                        "sender_userId": payload['sender_userId'],
                        "status": payload.get('status', ['PENDING']),
                        "createdAt": self.createdAt,
                        "updatedAt": self.createdAt,
                    }
                )
                print(f"Order stored successfully: {payload['medicationId']}")
            except Exception as e:
                print(f"Failed to store order: {e}")
```

##### `consume.py`

Instancia a aplicação FastAPI e inicia a thread para consumir mensagens.

```python
from fastapi import FastAPI
from contextlib import asynccontextmanager
from fastapi.middleware.cors import CORSMiddleware
import threading
import os
import uvicorn
from services.queueConfig import consume_order_queue

@asynccontextmanager
async def lifespan(app: FastAPI):
    from prismaClient import prismaClient  # Importa aqui para evitar problemas de importação circular
    await prismaClient.connect()
    yield
    await prismaClient.disconnect()

app = FastAPI(lifespan=lifespan)

# Middleware de CORS (caso necessário)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

if __name__ == "__main__":
    if "RABBITMQ_HOST" in os.environ:
        try:
            # Cria uma thread para receber as mensagens do RabbitMQ
            thread = threading.Thread(target=consume_order_queue)
            thread.start()
            uvicorn.run(app, host="0.0.0.0", port=8001)
        except Exception as e:
            print(f"Finalizando a execução da thread: {e}")
            thread.join()
    else:
        raise Exception("HOST and PORT must be defined in environment variables")
```

### Como Executar os Serviços 

#### Serviço 1

1. Configure as variáveis de ambiente necessárias (RABBITMQ_HOST, RABBITMQ_PORT, RABBITMQ_DEFAULT_USER, RABBITMQ_DEFAULT_PASS).
2. Inicie o serviço:
    ```sh
    python3 app/main.py
    ```

#### Serviço 2

1. Configure as variáveis de ambiente necessárias (RABBITMQ_HOST, RABBITMQ_PORT, RABBITMQ_DEFAULT_USER, RABBITMQ_DEFAULT_PASS).
2. Inicie o serviço:
    ```sh
    python3 app/consume.py
    ```

### Conclusão

Esta seção demonstra como dois serviços inicialmente interagem usando RabbitMQ para comunicar e processar pedidos. Um serviço publica pedidos na fila, enquanto o outro consome esses pedidos e os armazena em um banco de dados.

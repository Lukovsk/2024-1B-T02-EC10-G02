---
title: Serviços e Deploy
sidebar_position: 1
---

## Descrição da Arquitetura

Este projeto em si é uma aplicação web baseada em FastAPI que segue a arquitetura MVC. A aplicação é composta por três principais serviços:

1. **Serviço de Publicação de Pedidos**: Publica pedidos em uma fila RabbitMQ utilizando a biblioteca `pika`.
2. **Serviço Backend**: Responsável pelo login dos usuários, criação e obtenção de medicamentos.
3. **Serviço de Consumo de Dados**: Consome dados da fila RabbitMQ e armazena no banco de dados utilizando o Prisma ORM.

## Estrutura do Projeto

### Arquitetura

A aplicação está dividida em três instâncias EC2, cada uma executando um serviço específico:

1. **Instância EC2 - Grupo02**: Serviço que roda o RabbitMQ.
2. **Instância EC2 - Backend**: Serviço Backend para login de usuários, publicação na fila e manipulação de medicamentos.
3. **Instância EC2 - Consumo**: Serviço de Consumo de Dados e armazenamento no banco de dados.

### Serviço de Publicação de Pedidos

#### Estrutura do Diretório

```plaintext
- controllers/
  - order_controller.py
- services/
  - order_service.py
- routes/
  - order_routes.py
- main.py
- Dockerfile
- docker-compose.yml
```

#### Exemplo de Código da Aplicação atual

##### `services/order_service.py`

```python
import pika

class OrderService:
    def __init__(self, rabbitmq_url):
        self.rabbitmq_url = rabbitmq_url

    def publish_order(self, order_data):
        connection = pika.BlockingConnection(pika.URLParameters(self.rabbitmq_url))
        channel = connection.channel()
        channel.queue_declare(queue='order_queue')
        channel.basic_publish(exchange='', routing_key='order_queue', body=order_data)
        connection.close()
```

##### `controllers/order_controller.py`

```python
from services.order_service import OrderService

order_service = OrderService(rabbitmq_url="your_rabbitmq_url")

def publish_order(order_data):
    order_service.publish_order(order_data)
    return {"message": "Order published successfully"}
```

##### `routes/order_routes.py`

```python
from fastapi import APIRouter
from controllers.order_controller import publish_order

order_router = APIRouter()

@order_router.post("/publish_order")
def create_order(order_data: dict):
    return publish_order(order_data)
```

### Serviço Backend

#### Estrutura do Diretório

```plaintext
- controllers/
  - medicineController.py
- services/
  - medication.py
- routes/
  - medicineRoutes.py
- main.py
- Dockerfile
- docker-compose.yml
```

#### Exemplo de Código da Aplicação atual

##### `services/medication.py`

```python
from prisma import Prisma, errors
from prisma.models import Medications
from contextlib import asynccontextmanager
from __init__ import db

class MedicationService:
    # Métodos para criação, obtenção e manipulação de medicamentos
```

##### `controllers/medicineController.py`

```python
from fastapi import HTTPException
from prisma import errors
from services.medication import MedicationService

async def controller_get_all_medications():
    medication = MedicationService()
    try:
        all_medications = await medication.get_all_medications()
        return {"medications": all_medications}
    except HTTPException as e:
        raise HTTPException(status_code=e.status_code, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
```

##### `routes/medicineRoutes.py`

```python
from fastapi import APIRouter
from controllers.medicineController import controller_get_all_medications, controller_create_medication, controller_get_medication

medication_routes = APIRouter(prefix="/medication", tags=["medication"])

@medication_routes.post("/newmedication")
async def create_medication(medication_data: MedSchema):
    return await controller_create_medication(area=medication_data.area, description=medication_data.description, lot=medication_data.lot, medClass=medication_data.medClass)

@medication_routes.get("/{id}")
async def get_medication(id: str):
    return await controller_get_medication(id)

@medication_routes.get("/all")
async def list_all_medications():
    return await controller_get_all_medications()
```

### Serviço de Consumo de Dados

#### Estrutura do Diretório

```plaintext
- consumers/
  - order_consumer.py
- services/
  - database_service.py
- main.py
- Dockerfile
- docker-compose.yml
```

#### Exemplo de Código da Aplicação atual

##### `consumers/order_consumer.py`

```python
import pika

class OrderConsumer:
    def __init__(self, rabbitmq_url, db_service):
        self.rabbitmq_url = rabbitmq_url
        self.db_service = db_service

    def consume_orders(self):
        connection = pika.BlockingConnection(pika.URLParameters(self.rabbitmq_url))
        channel = connection.channel()
        channel.queue_declare(queue='order_queue')

        def callback(ch, method, properties, body):
            order_data = body.decode()
            self.db_service.save_order(order_data)

        channel.basic_consume(queue='order_queue', on_message_callback=callback, auto_ack=True)
        channel.start_consuming()
```

##### `services/database_service.py`

```python
from prisma import Prisma

class DatabaseService:
    def __init__(self, db_url):
        self.db = Prisma(db_url)

    async def save_order(self, order_data):
        # Código para salvar o pedido no banco de dados
```

## Implantação

Cada serviço está implantado em uma instância EC2 separada com IPs públicos para facilitar a integração e comunicação entre os serviços. As variáveis de ambiente devem ser alteradas adequadamente para abrir as portas necessárias nos grupos de segurança das instâncias EC2.
Atualmente, a arquitetura do projeto não inclui um load balancer ou um sistema de orquestração de contêineres como Kubernetes. Isso será desenvolvido em futuras etapas do projeto para facilitar a escalabilidade e o gerenciamento dos microsserviços.
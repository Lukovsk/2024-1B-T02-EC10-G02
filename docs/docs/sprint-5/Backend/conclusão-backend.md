---
title: Conclusão do backend
sidebar_position: 2
---

## Introdução

Este backend consiste em um sistema de gerenciamento de farmácia e requisição de medicamentos para o Pyxis. A arquitetura do backend é baseada em microsserviços, o que permite maior escalabilidade, flexibilidade e facilidade de manutenção. Utilizamos FastAPI como framework web e Prisma como ORM para interação com o banco de dados PostgreSQL no Supabase. Os serviços são implantados na EC2 da AWS, garantindo alta disponibilidade e desempenho.

## Estrutura do Backend

A estrutura do backend do projeto é dividida em diversos microsserviços, cada um responsável por uma parte específica do sistema. Abaixo está uma visão geral da estrutura de pastas e arquivos do backend:


```
backend
│
├── consumer_service
│ ├── controllers
│ │ ├── order.py
│ │ ├── pyxis.py
│ │ └── user.py
│ ├── logs
│ │ └── logger.py
│ ├── routes
│ │ ├── init.py
│ │ ├── consumer.py
│ │ ├── order.py
│ │ ├── pyxis.py
│ │ └── user.py
│ ├── schemas
│ │ ├── init.py
│ │ ├── consumer.py
│ │ ├── order.py
│ │ ├── pyxis.py
│ │ └── user.py
│ ├── services
│ │ ├── init.py
│ │ ├── redis.py
│ │ ├── order.py
│ │ ├── pyxis.py
│ │ └── user.py
│ ├── init.py
│ ├── consumer.py
│ ├── Dockerfile
│ ├── main.py
│ └── requirements.txt
│
├── kubernetes
│ ├── deployments.yaml
│ └── services.yaml
│
├── logs_service
│ ├── app.py
│ ├── Dockerfile
│ ├── docker-compose.yaml
│ └── requirements.txt
│
├── publisher_service
│ ├── controllers
│ │ └── order.py
│ ├── routes
│ │ ├── init.py
│ │ └── order.py
│ ├── schemas
│ │ ├── init.py
│ │ └── order.py
│ ├── services
│ │ ├── init.py
│ │ └── queue.py
│ ├── init.py
│ ├── Dockerfile
│ ├── main.py
│ └── requirements.txt
│
├── storage_service
│ ├── controllers
│ │ ├── item.py
│ │ ├── order.py
│ │ ├── pyxis.py
│ │ └── user.py
│ ├── prisma
│ │ └── schema.prisma
│ ├── routes
│ │ ├── init.py
│ │ ├── item.py
│ │ ├── order.py
│ │ ├── pyxis.py
│ │ └── user.py
│ ├── schemas
│ │ ├── init.py
│ │ ├── item.py
│ │ ├── order.py
│ │ ├── pyxis.py
│ │ └── user.py
│ ├── services
│ │ ├── init.py
│ │ ├── item.py
│ │ ├── order.py
│ │ ├── pyxis.py
│ │ └── user.py
│ ├── init.py
│ ├── .env
│ ├── consumer.py
│ ├── Dockerfile
│ ├── main.py
│ └── requirements.txt
│
└── tests
└── teste_de_carga
└── locust.py
```

### Explicação dos Principais Componentes

#### consumer_service
Este serviço é responsável pelo consumo de mensagens relacionadas aos pedidos de medicamentos. Ele inclui controladores, rotas, esquemas e serviços para gerenciar pedidos, usuários e interações com a máquina Pyxis.

- **controllers**: Contém a lógica dos controladores para os pedidos, Pyxis e usuários.
- **logs**: Gerencia a geração e armazenamento de logs.
- **routes**: Define as rotas da API.
- **schemas**: Define os esquemas de dados utilizados.
- **services**: Contém a lógica de negócio e interação com outros serviços.

#### kubernetes
Contém arquivos de configuração para o Kubernetes, como deployments e services, para facilitar a implantação e gerenciamento dos microsserviços.

#### logs_service
Este serviço é responsável por coletar e armazenar logs gerados pelos outros microsserviços.

#### publisher_service
Este serviço publica mensagens na fila para processamento posterior. Inclui controladores, rotas, esquemas e serviços específicos para a publicação de mensagens relacionadas aos pedidos.

#### storage_service
Este serviço gerencia o armazenamento de dados relacionados aos itens, pedidos, Pyxis e usuários. Utiliza o Prisma como ORM para interagir com o banco de dados PostgreSQL.

#### tests
Contém testes de carga e outros tipos de testes para garantir a robustez e desempenho do sistema.

## Ferramentas e Tecnologias Utilizadas

- **FastAPI**: Framework web moderno e de alta performance para a construção de APIs com Python.
- **Prisma**: ORM que facilita a interação com o banco de dados, fornecendo um tipo seguro e gerenciando as migrações de esquema.
- **AWS EC2**: Serviço de computação em nuvem que fornece capacidade de processamento escalável, onde os microsserviços são implantados para garantir alta disponibilidade e desempenho.
- **Docker**: Utilizado para criar, implantar e gerenciar containers para cada microsserviço.
- **Kubernetes**: Sistema de orquestração de containers utilizado para automatizar a implantação, escalonamento e gerenciamento dos microsserviços.

## Conclusão

O projeto de gerenciamento de farmácia e requisição de medicamentos para o Pyxis no Hospital Sírio Libanês é um exemplo de aplicação de microsserviços, proporcionando escalabilidade e facilidade de manutenção. Cada serviço desempenha um papel crucial no sistema, permitindo uma gestão eficiente e integrada dos medicamentos e recursos da farmácia.



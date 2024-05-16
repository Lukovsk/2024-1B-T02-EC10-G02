---
title: Visões (views)
sidebar_position: 3
---

## O que é

A Visão é responsável por apresentar os dados ao usuário e permitir a interação com eles. Ela representa a interface do usuário e exibe os dados fornecidos pelo Modelo de forma formatada e compreensível. A Visão não contém lógica de negócios, concentrando-se apenas na apresentação dos dados. Em uma aplicação web, a Visão geralmente corresponde a uma resposta formatada que passa para uma página HTML, ou qualquer resposta do servidor que passa para uma interface gráfica de usuário ou qualquer componente de interface que renderiza os dados para o usuário.

## Views (Views)

Aqui estão as views criadas no desenvolvimento inicial do backend, futuramente algumas podem deixar de existir e outros podem vir a existir conforme vamos implementando mais serviços e componentes à arquitetura.

### User Views

- Resposta das funções **get_users()**:
  - Função: Exibe uma visão geral dos usuários cadastrados.
  - Resposta do servidor em formato JSON:

  ```json
      {
       "status": "success",
       "message": "Lista de usuários recuperada com sucesso.",
       "data": [
         {
           "id": "1",
           "name": "João Silva",
           "email": "joao.silva@example.com",
           "password": "hashed_password",
           "role": "Enfermeiro",
           "createdAt": "2024-05-12T12:00:00Z",
           "updatedAt": "2024-05-12T12:30:00Z",
           "deletedAt": null
         },
         {
           "id": "2",
           "name": "Maria Oliveira",
           "email": "maria.oliveira@example.com",
           "password": "hashed_password",
           "role": "Médica",
           "createdAt": "2024-05-11T10:30:00Z",
           "updatedAt": "2024-05-11T11:00:00Z",
           "deletedAt": null
         },
         {
           "id": "3",
           "name": "Carlos Santos",
           "email": "carlos.santos@example.com",
           "password": "hashed_password",
           "role": "Técnico de Laboratório",
           "createdAt": "2024-05-10T15:45:00Z",
           "updatedAt": "2024-05-10T16:00:00Z",
           "deletedAt": "2024-05-11T14:00:00Z"
         }
       ]
     }
     ```

- Respostas da criação de usuário:
  - Função: Permite a criação de um novo usuário.
  - Resposta do servidor em formato JSON:

  ```json
     {
       "status": "success",
       "message": "Usuário criado com sucesso.",
       "data": {
         "id": "4",
         "name": "Ana Lima",
         "email": "ana.lima@example.com",
         "password": "hashed_password"
       }
     }
     ```

- Resposta da edição de usuário:
  - Função: Permite a edição dos dados de um usuário existente.
  - Resposta do servidor em formato JSON:

     ```json
     {
       "status": "success",
       "message": "Usuário atualizado com sucesso.",
       "data": {
         "id": "4",
         "nome": "Ana Lima",
         "email": "ana.lima2@example.com"
       }
     }
     ```

- Resposta da confirmação de exclusão:
  - Função: Confirma a exclusão de um usuário.
  - Resposta do servidor em formato JSON:

     ```json
     {
       "status": "success",
       "message": "Usuário excluído com sucesso.",
       "data": {
         "id": "3"
       }
     }
     ```

### Feedback Views

- Resposta das funções **get_all_feedbacks():**
  - Função: Exibe uma visão geral dos feedbacks cadastrados.
  - Resposta do servidor em formato JSON:

  ``` json
  {
  "status": "success",
  "message": "Lista de feedbacks recuperada com sucesso.",
  "data": [
    {
      "id": "1",
      "message_user": "Ótimo atendimento!",
      "message_app": "App estável e fácil de usar.",
      "rate_user": 5,
      "rate_app": 4,
      "createdAt": "2024-05-12T12:00:00Z",
      "updatedAt": "2024-05-12T12:30:00Z",
      "deletedAt": null,
      "sender_userId": "1",
      "receiver_userId": "2"
    },
    {
      "id": "2",
      "message_user": "Serviço rápido.",
      "message_app": null,
      "rate_user": 4,
      "rate_app": null,
      "createdAt": "2024-05-11T10:30:00Z",
      "updatedAt": "2024-05-11T11:00:00Z",
      "deletedAt": null,
      "sender_userId": "3",
      "receiver_userId": "4"
    }
  ]
  }
  ``

- Respostas da criação de feedback:
  - Função: Permite a criação de um novo feedback.
  - Resposta do servidor em formato JSON:

  ``` json
  {
    "status": "success",
    "message": "Feedback criado com sucesso.",
    "data": {
      "id": "3",
      "message_user": "Excelente!",
      "message_app": "Funcionalidades completas.",
      "rate_user": 5,
      "rate_app": 5,
      "sender_userId": "5",
      "receiver_userId": "6"
    }
  }
  ``

- Resposta da edição de feedback:

  - Função: Permite a edição dos dados de um feedback existente.
  - Resposta do servidor em formato JSON:

  ``` json
  {
    "status": "success",
    "message": "Feedback atualizado com sucesso.",
    "data": {
      "id": "3",
      "message_user": "Excelente atendimento!",
      "message_app": "App excelente.",
      "rate_user": 5,
      "rate_app": 5
    }
  }
  ``

- Resposta da confirmação de exclusão:

  - Função: Confirma a exclusão de um feedback.
  - Resposta do servidor em formato JSON:

```json
  {
    "status": "success",
    "message": "Feedback excluído com sucesso.",
    "data": {
      "id": "2"
    }
  }
```

### Order Views

- **Resposta das funções `get_sender_orders_route(sender_id)`**:
  - Função: Exibe uma visão geral dos pedidos enviados pelo remetente (enfermeiro).
  - Resposta do servidor em formato JSON:

  ```json
  {
    "status": "success",
    "message": "Lista de pedidos do remetente recuperada com sucesso.",
    "data": [
      {
        "id": "1",
        "medicationId": "123",
        "status": "Pendente",
        "senderId": "456",
        "createdAt": "2024-05-12T12:00:00Z",
        "updatedAt": "2024-05-12T12:30:00Z"
      },
      {
        "id": "2",
        "medicationId": "456",
        "status": "Concluído",
        "senderId": "456",
        "createdAt": "2024-05-11T10:30:00Z",
        "updatedAt": "2024-05-11T11:00:00Z"
      }
    ]
  }
  ```

- **Resposta da criação de pedido**:
  - Função: Permite a criação de um novo pedido.
  - Resposta do servidor em formato JSON:

  ```json
  {
    "status": "success",
    "message": "Pedido criado com sucesso.",
    "data": {
      "id": "3",
      "medicationId": "789",
      "status": "Pendente",
      "senderId": "456",
      "createdAt": "2024-05-15T08:00:00Z",
      "updatedAt": "2024-05-15T08:05:00Z"
    }
  }
  ```

- **Resposta da edição de pedido**:
  - Função: Permite a edição dos dados de um pedido existente.
  - Resposta do servidor em formato JSON:

  ```json
  {
    "status": "success",
    "message": "Pedido atualizado com sucesso.",
    "data": {
      "id": "3",
      "medicationId": "789",
      "status": "Concluído",
      "senderId": "456",
      "updatedAt": "2024-05-15T08:10:00Z"
    }
  }
  ```

- **Resposta da exclusão de pedido**:
  - Função: Confirma a exclusão de um pedido.
  - Resposta do servidor em formato JSON:

  ```json
  {
    "status": "success",
    "message": "Pedido excluído com sucesso.",
    "data": {
      "id": "3"
    }
  }
  ```

- **Resposta das funções `get_sender_orders_route(sender_id)`**:
  - Função: Exibe uma visão geral dos pedidos enviados pelo remetente (enfermeiro).
  - Resposta do servidor em formato JSON:

  ```json
  {
    "status": "success",
    "message": "Lista de pedidos do remetente recuperada com sucesso.",
    "data": [
      {
        "id": "1",
        "medicationId": "123",
        "status": "Pendente",
        "senderId": "456",
        "createdAt": "2024-05-12T12:00:00Z",
        "updatedAt": "2024-05-12T12:30:00Z"
      },
      {
        "id": "2",
        "medicationId": "456",
        "status": "Concluído",
        "senderId": "456",
        "createdAt": "2024-05-11T10:30:00Z",
        "updatedAt": "2024-05-11T11:00:00Z"
      }
    ]
  }
  ```

- **Resposta da criação de pedido**:
  - Função: Permite a criação de um novo pedido.
  - Resposta do servidor em formato JSON:

  ```json
  {
    "status": "success",
    "message": "Pedido criado com sucesso.",
    "data": {
      "id": "3",
      "medicationId": "789",
      "status": "Pendente",
      "senderId": "456",
      "createdAt": "2024-05-15T08:00:00Z",
      "updatedAt": "2024-05-15T08:05:00Z"
    }
  }
  ```

- **Resposta da edição de pedido**:
  - Função: Permite a edição dos dados de um pedido existente.
  - Resposta do servidor em formato JSON:

  ```json
  {
    "status": "success",
    "message": "Pedido atualizado com sucesso.",
    "data": {
      "id": "3",
      "medicationId": "789",
      "status": "Concluído",
      "senderId": "456",
      "updatedAt": "2024-05-15T08:10:00Z"
    }
  }
  ```

- **Resposta da exclusão de pedido**:
  - Função: Confirma a exclusão de um pedido.
  - Resposta do servidor em formato JSON:

  ```json
  {
    "status": "success",
    "message": "Pedido excluído com sucesso.",
    "data": {
      "id": "3"
    }
  }
  ```

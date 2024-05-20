---
title: Modelos (models)
sidebar_position: 1
---

## O que é

O Modelo é responsável pela lógica de negócios e pela manipulação dos dados. Ele encapsula as operações relacionadas aos dados, como validação, manipulação e persistência, representando o estado subjacente dos dados sem se preocupar com a exibição ou interação com o usuário. Em uma aplicação web, o Modelo pode ser uma camada que interage com o banco de dados ou serviços externos para recuperar e manipular os dados necessários.

## Implementação

1. **Usuário:**
   - **ID:** Identificador único do usuário (chave primária).
   - **Name:** Nome do usuário.
   - **Email:** Endereço de e-mail do usuário.
   - **Password (criptografada):** Senha criptografada do usuário para autenticação.
   - **Role:** Cargo do usuário no hospital.
   - **createdAt:** Data de criação do usuário.
   - **updatedAt:** Data da última atualização do usuário
   - **deletedAt:** Data de exclusão do usuário (opcional)

2. **Feedback:**
    - **ID:** Identificador único do feedback (chave primária).
    - **message_user:** Mensagem de feedback do usuário.
    - **message_app:** Mensagem de feedback do aplicativo.
    - **rate_user:** Avaliação do usuário (nota).
    - **rate_app:** Avaliação do aplicativo (nota, opcional).
    - **createdAt:** Data de criação do feedback.
    - **updatedAt:** Data da última atualização do feedback.
    - **deletedAt:** Data de exclusão do feedback (opcional).
    - **sender_userId:** Identificador do usuário que enviou o feedback.
    - **receiver_userId:** Identificador do usuário que recebeu o feedback.

3. - **Pedido:**
      - **ID:** Identificador único do pedido (chave primária).
      - **MedicationId:** Identificador do medicamento associado ao pedido.
      - **Status:** Estado atual do pedido.
      - **SenderId:** ID do remetente do pedido.
      - **ReceiverId:** ID do destinatário do pedido.
      - **FeedbackId:** ID do feedback associado ao pedido.
      - **CanceledAt:** Data e hora em que o pedido foi cancelado.
      - **CanceledBy:** ID do usuário que cancelou o pedido.
      - **CanceledReason:** Motivo do cancelamento do pedido.

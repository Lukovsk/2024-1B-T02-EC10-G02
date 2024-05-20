---
title: Controladores (controllers)
sidebar_position: 2
---


## O que é

O Controlador atua como intermediário entre o Modelo e a Visão. Ele responde às ações do usuário, como cliques em botões ou submissão de formulários, e executa as operações necessárias para atualizar o Modelo e selecionar a Visão apropriada para exibir. O Controlador interpreta as interações do usuário, processa os dados necessários e coordena a comunicação entre o Modelo e a Visão. Em uma aplicação web, o Controlador pode ser um script ou uma classe que recebe requisições HTTP, interage com o Modelo para processar os dados e determina qual Visão deve ser enviada ao cliente.

## Implementações

Aqui estão os controladores criados no desenvolvimento inicial do backend, futuramente alguns podem deixar de existir e outros podem vir a existir conforme vamos implementando mais serviços e componentes à arquitetura.

### User Controller

- **controller_get_all_users():** Lista todos os usuários cadastrados.
  - Entrada: Nenhuma
  - Saída: Lista de usuários.
  - Possíveis respostas HTTP:
    - 200 OK: usuários recuperados com sucesso.
    - 404 Not Found: Usuários não encontrados.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_get_user_by_id():** Lista todos os usuários cadastrados pelo id.
  - Entrada: `id`
  - Saída: Usuário com o id especificado.
  - Possíveis respostas HTTP:
    - 200 OK: usuário recuperado com sucesso.
    - 404 Not Found: Usuário não encontrado com o ID fornecido.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_create_user(nome: string, email: string, senha: string):** Cria um novo usuário.
  - Entrada: `nome`, `email`, `senha`
  - Saída: Mensagem de sucesso ou erro, detalhes do usuário registrado.
  - Possíveis respostas HTTP:
    - 200 OK: Usuário registrado com sucesso.
    - 400 Bad Request: Requisição inválida, campos obrigatórios não fornecidos ou formato de dados incorreto.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_update_user(id: int, novosDados: object):** Edita um usuário existente.
  - Entrada: `id`, `novosDados` (objeto contendo os campos editáveis)
  - Saída: Mensagem de sucesso ou erro, detalhes do usuário atualizado.
  - Possíveis respostas HTTP:
    - 200 OK: Perfil do usuário atualizado com sucesso.
    - 400 Bad Request: Requisição inválida, campos obrigatórios não fornecidos ou formato de dados incorreto.
    - 404 Not Found: Usuário não encontrado com o ID fornecido.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_delete_user(id: int):** Exclui um usuário existente.
  - Entrada: `id`
  - Saída: Confirmação de exclusão.
  - Possíveis respostas HTTP:
    - 200 OK: Perfil do usuário excluído com sucesso.
    - 404 Not Found: Usuário não encontrado com o ID fornecido.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

### Feedback Controller

- **controller_get_all_feedbacks():** Lista todos os feedbacks cadastrados.
  - Entrada: Nenhuma
  - Saída: Lista de feedbacks.
  - Possíveis respostas HTTP:
    - 200 OK: Feedbacks recuperados com sucesso.
    - 404 Not Found: Feedbacks não encontrados.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.
  
- **controller_get_feedback_by_id():** Recupera um feedback específico pelo ID.
  - Entrada: id
  - Saída: Feedback com o ID especificado.
  - Possíveis respostas HTTP:
    - 200 OK: Feedback recuperado com sucesso.
    - 404 Not Found: Feedback não encontrado com o ID fornecido.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_create_feedback(rate_user: int, Request: list, sender_userId: int, receiver_userId: int, message_user: str=None, message_app: str=None, rate_app: int=None):** Cria um novo feedback.
  - Entrada: rate_user, Request, sender_userId, receiver_userId, message_user (opcional), message_app (opcional), rate_app (opcional).
  - Saída: Mensagem de sucesso ou erro, detalhes do feedback registrado.
  - Possíveis respostas HTTP:
    - 200 OK: Feedback registrado com sucesso.
    - 400 Bad Request: Requisição inválida, campos obrigatórios não fornecidos ou formato de dados incorreto.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_update_feedback(id: int, rate_user: int, Request: list, sender_userId: int, receiver_userId: int, message_user: str=None, message_app: str=None, rate_app: int=None):** Edita um feedback existente.
  - Entrada: id, rate_user, Request, sender_userId, receiver_userId, message_user (opcional), message_app (opcional), rate_app (opcional).
  - Saída: Mensagem de sucesso ou erro, detalhes do feedback atualizado.
  - Possíveis respostas HTTP:
    - 200 OK: Feedback atualizado com sucesso.
    - 400 Bad Request: Requisição inválida, campos obrigatórios não fornecidos ou formato de dados incorreto.
    - 404 Not Found: Feedback não encontrado com o ID fornecido.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_delete_feedback(id: int):** Exclui um feedback existente.
  - Entrada: id
  - Saída: Confirmação de exclusão.
  - Possíveis respostas HTTP:
    - 200 OK: Feedback excluído com sucesso.
    - 404 Not Found: Feedback não encontrado com o ID fornecido.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

### Order Controller

- **controller_get_sender_orders(senderId):** Lista os pedidos do enfermeiro
  - Entrada: `senderId`
  - Saída: Lista de pedidos.
  - Possíveis repsostas HTTP:
    - 200 OK: Pedidos cancelados recuperados com sucesso.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_get_receiver_orders(receiverId):** Lista os pedidos do auxiliar
  - Entrada: `receiverId`
  - Saída: Lista de pedidos.
  - Possíveis repsostas HTTP:
    - 200 OK: Pedidos cancelados recuperados com sucesso.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_get_all_orders():** Lista todos os pedidos.
  - Entrada: Nenhuma.
  - Saída: Lista de pedidos.
  - Possíveis respostas HTTP:
    - 200 OK: Pedidos recuperados com sucesso.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_get_canceled_orders():** Lista todos os pedidos cancelados.
  - Entrada: Nenhuma.
  - Saída: Lista de pedidos cancelados.
  - Possíveis respostas HTTP:
    - 200 OK: Pedidos cancelados recuperados com sucesso.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_create_order(medicationId: str, status: str, senderId: str):** Cria um novo pedido.
  - Entrada: `medicationId`, `status`, `senderId`.
  - Saída: Mensagem de sucesso ou erro.
  - Possíveis respostas HTTP:
    - 200 OK: Pedido criado com sucesso.
    - 404 Not Found: O pedido já existe.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_update_order(new_data, order_id):** Edita um pedido existente.
  - Entrada: `new_data` (objeto contendo os campos editáveis), `order_id`.
  - Saída: Mensagem de sucesso ou erro.
  - Possíveis respostas HTTP:
    - 200 OK: Pedido atualizado com sucesso.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_cancel_order(order_id, reason, user_id):** Cancela um pedido existente.
  - Entrada: `order_id`, `reason`, `user_id`.
  - Saída: Mensagem de sucesso ou erro.
  - Possíveis respostas HTTP:
    - 200 OK: Pedido cancelado com sucesso.
    - 400 Bad Request: Falha ao cancelar o pedido.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.

- **controller_delete_order(order_id):** Exclui um pedido existente.
  - Entrada: `order_id`.
  - Saída: Mensagem de sucesso ou erro.
  - Possíveis respostas HTTP:
    - 200 OK: Pedido excluído com sucesso.
    - 400 Bad Request: Não foi possível excluir o pedido.
    - 500 Internal Server Error: Erro interno ao processar a solicitação.
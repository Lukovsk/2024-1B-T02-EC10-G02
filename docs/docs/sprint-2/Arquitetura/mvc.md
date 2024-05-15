---
sidebar_position: 3
slug: /mvc
---
# MVC (Model-View-Controller)

O MVC (Model-View-Controller) é uma estrutura de arquitetura de software que divide uma aplicação em três componentes principais: Modelo, Visão e Controlador. Essa divisão permite uma separação clara entre a lógica de negócios, a apresentação de dados e a interação do usuário, facilitando o desenvolvimento e a manutenção de diversos tipos de projetos, como aplicativos web, desktop e mobile.

O Modelo é responsável pela lógica de negócios e pela manipulação dos dados. Ele encapsula as operações relacionadas aos dados, como validação, manipulação e persistência, representando o estado subjacente dos dados sem se preocupar com a exibição ou interação com o usuário. Em uma aplicação web, o Modelo pode ser uma camada que interage com o banco de dados ou serviços externos para recuperar e manipular os dados necessários.

A Visão é responsável por apresentar os dados ao usuário e permitir a interação com eles. Ela representa a interface do usuário e exibe os dados fornecidos pelo Modelo de forma formatada e compreensível. A Visão não contém lógica de negócios, concentrando-se apenas na apresentação dos dados. Em uma aplicação web, a Visão geralmente corresponde a uma resposta formatada que passa para uma página HTML, ou qualquer resposta do servidor que passa para uma interface gráfica de usuário ou qualquer componente de interface que renderiza os dados para o usuário.

O Controlador atua como intermediário entre o Modelo e a Visão. Ele responde às ações do usuário, como cliques em botões ou submissão de formulários, e executa as operações necessárias para atualizar o Modelo e selecionar a Visão apropriada para exibir. O Controlador interpreta as interações do usuário, processa os dados necessários e coordena a comunicação entre o Modelo e a Visão. Em uma aplicação web, o Controlador pode ser um script ou uma classe que recebe requisições HTTP, interage com o Modelo para processar os dados e determina qual Visão deve ser enviada ao cliente.

Ao adotar o padrão MVC, cada componente tem responsabilidades claramente definidas, o que facilita a organização do código, a manutenção, o teste e a escalabilidade do projeto. Além disso, o MVC promove a reutilização de código, já que as diferentes camadas são independentes umas das outras, permitindo que sejam modificadas ou substituídas sem afetar as demais partes do sistema.

## Diagrama MVC 

## MVC no PharmaControl

### Modelos (Models):

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

### Controladores (Controllers):

#### Usuário Controller

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

#### Feedback Controller

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

### Views (Views):

#### User Views

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

#### Feedback Views

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

### Infraestrutura:

- **Banco de Dados PostgreSQL:** Utilizaremos o PostgreSQL como banco de dados principal para armazenar todos os dados relacionados aos usuários, cursos, tarefas, estatísticas e outros elementos essenciais da aplicação.

- **Metabase para Monitoramento e Dashboard:** Faremos uso do Metabase para monitorar o desempenho da aplicação e criar dashboards personalizados com métricas relevantes extraídas do banco de dados PostgreSQL. Isso nos permitirá visualizar dados importantes e tomar decisões informadas.

- **Criação de Logs:** A criação de logs será implementada para registrar atividades e erros relevantes, fornecendo informações valiosas para depuração e análise.

- **API com FastAPI:** Optamos por utilizar FastAPI para construir a API da aplicação devido à sua eficiência, facilidade de uso e suporte para construção rápida de APIs RESTful com Python. FastAPI é conhecido por sua alta performance e é uma escolha excelente para aplicativos que exigem alta velocidade de processamento de solicitações HTTP.

- **ORM com Prisma:** Faremos uso do Prisma como ORM (Object-Relational Mapping) para interagir com o banco de dados PostgreSQL de forma eficiente e segura. Prisma simplifica a comunicação com o banco de dados, oferecendo uma interface intuitiva para realizar operações de CRUD (Create, Read, Update, Delete) e consultas complexas.

- **Frontend em Flutter:** Optamos por desenvolver o frontend da aplicação utilizando o framework Flutter, uma escolha sólida para criar interfaces de usuário bonitas e responsivas para aplicativos Android. Flutter oferece um desenvolvimento ágil e eficiente, permitindo-nos criar uma experiência de usuário fluida e intuitiva para os usuários da aplicação móvel.

- **Microsserviços e Containers:** Considerando a natureza distribuída da aplicação e a necessidade de escalabilidade, planejamos adotar uma arquitetura de microsserviços baseada em containers, utilizando tecnologias como Docker e Kubernetes para gerenciar e orquestrar os serviços da aplicação de forma eficiente e escalável.

- **Sistema de Cache:** Integraremos um sistema de cache para otimizar o desempenho da aplicação, armazenando dados frequentemente acessados em cache para reduzir o tempo de resposta das solicitações. Tecnologias como Redis serão consideradas para implementar o sistema de cache.

- **Serviço de Notificações:** Utilizaremos um serviço de notificações para enviar notificações aos usuários sobre atualizações nos cursos, novas tarefas atribuídas e outras informações relevantes. Serviços como Firebase Cloud Messaging podem ser integrados para fornecer notificações push em dispositivos Android.

- **Ambiente de Desenvolvimento e Implantação:** Configuraremos um ambiente completo de desenvolvimento e implantação para o projeto, incluindo ferramentas de controle de versão como Git, integração contínua e implantação contínua (CI/CD) com Jenkins ou GitLab CI, e automação de infraestrutura com ferramentas como Terraform ou AWS CloudFormation.

#### Justificativa das escolhas:

- **FastAPI com Prisma:**
  - Optamos pelo FastAPI com Prisma devido à sua eficiência, facilidade de uso e capacidade de construir APIs rápidas e seguras em Python. FastAPI oferece uma sintaxe limpa e intuitiva, juntamente com a capacidade de lidar com operações assíncronas, tornando-o uma escolha excelente para aplicativos que exigem alto desempenho e escalabilidade.

  - **Escalabilidade:**
    - FastAPI é conhecido por sua capacidade de lidar com um grande número de solicitações simultâneas de forma eficiente, o que o torna altamente escalável para lidar com picos de tráfego e demanda crescente.

  - **Manutenção:**
    - A sintaxe limpa e a estrutura organizada do FastAPI facilitam a manutenção do código, enquanto o Prisma simplifica a interação com o banco de dados PostgreSQL, proporcionando uma camada de abstração intuitiva para realizar operações de CRUD e consultas complexas.

  - **Testabilidade:**
    - Tanto o FastAPI quanto o Prisma são altamente testáveis, suportando frameworks de teste populares em Python, como Pytest e unittest, para testes unitários e de integração. Isso facilita a escrita e execução de testes para garantir a qualidade do código.

- **PostgreSQL como Banco de Dados:**
  - Escolhemos o PostgreSQL pela sua confiabilidade, robustez e capacidade de escalabilidade, oferecendo recursos avançados como transações ACID e suporte a JSON, que são essenciais para aplicativos complexos.

  - **Escalabilidade:**
    - O PostgreSQL é altamente escalável, permitindo que a aplicação cresça conforme a demanda, com recursos como particionamento de tabelas e replicação para melhorar o desempenho e lidar com cargas de trabalho pesadas.

  - **Manutenção:**
    - Amplamente utilizado e bem documentado, o PostgreSQL facilita a manutenção e o gerenciamento do banco de dados, com uma comunidade ativa que oferece suporte rápido e correções de bugs.

  - **Testabilidade:**
    - O PostgreSQL suporta uma variedade de ferramentas de teste e frameworks em Python, permitindo a criação de bancos de dados de teste para garantir a segurança e integridade dos dados em ambientes de desenvolvimento e produção.

- **Flutter para Frontend:**
  - Optamos pelo Flutter para desenvolver o frontend da aplicação devido à sua capacidade de criar interfaces de usuário bonitas e responsivas para aplicativos móveis Android.

  - **Escalabilidade:**
    - O Flutter é altamente escalável, permitindo a criação de interfaces de usuário ricas em recursos e suaves, mesmo em dispositivos Android com diferentes tamanhos de tela e especificações.

  - **Manutenção:**
    - O Flutter simplifica a manutenção do frontend, permitindo o desenvolvimento de uma base de código única para aplicativos Android e iOS, o que reduz a complexidade e o esforço de manutenção.

  - **Testabilidade:**
    - O Flutter oferece suporte para testes de unidade, integração e widget, permitindo a criação de testes automatizados para garantir a qualidade e o desempenho do frontend da aplicação.
---
title: Levantamento de Requisitos
sidebar_position: 1
slug: /requirements-gathering
---

Para garantir que o projeto atenda às necessidades do cliente, identificadas durante uma entrevista de levantamento de aprimoramento de entendimento do projeto, os requisitos foram divididos em duas categorias principais: funcionais e não funcionais. Essa divisão foi motivada pela complexidade do projeto, que demanda tanto a implementação de funcionalidades específicas conforme os requisitos mínimos estabelecidos quanto o cumprimento de métricas de desempenho. Dentro dessas categorias, os Requisitos Funcionais(RFs) descrevem o que o sistema deve realizar, enquanto os Requisitos Não Funcionais(RNFs) estabelecem as métricas de desempenho a serem alcançadas pelos requisitos funcionais. Cada requisito foi ainda classificado como "obrigatório" ou "desejável", permitindo à equipe de desenvolvimento estabelecer uma ordem de prioridade para sua implementação.

## Requisitos Funcionais


| ID - Título                     |  Descrição    | Categoria  |
| --------------------------------| ------------- | ---------  |
| RF1 - Integração com o Sistema Tasy e Pyxis| O sistema deve permitir a integração com o Sistema Tasy e o sistema interno do Pyxis para acesso e manipulação dos dados relevantes para o gerenciamento de medicamentos, incluindo solicitações, estoque e movimentações.           |       Obrigatório     |
| RF2 - Dashboard de Monitoramento de Urgências |  O sistema deve fornecer um dashboard de monitoramento de urgências, exibindo métricas importantes relacionadas a solicitações de medicamentos, tempo de atendimento e disponibilidade de estoque.         |           Desejável    |            
| RF3 - Funcionalidade de Notificação Automática | O sistema deve fornecer funcionalidades de notificação automática para alertar sobre situações de urgência, como baixo estoque de medicamentos ou solicitações de urgência pendentes. | Obrigatório |
| RF4 - Integração com Dispositivos de Leitura de QR Code |  O sistema deve permitir a integração com dispositivos de leitura de QR Code para facilitar a identificação de pacientes, medicamentos e outros itens relevantes durante o processo de solicitação, dispensação e controle de estoque. | Desejável |
| RF5 - Funcionalidade de Acompanhamento de Movimentações| O sistema deve fornecer funcionalidades de acompanhamento de movimentações de medicamentos, permitindo rastrear e registrar todas as operações realizadas, desde solicitações até dispensações e devoluções. | Obrigatório |

## Requisitos Não Funcionais

| ID - Título                     |  Descrição    | Métrica    | Categoria  |
| --------------------------------| ------------- | ---------  | -----------|
| RNF1 - Desempenho | O sistema deve ser capaz de lidar com um grande volume de solicitações e transações simultâneas de forma eficiente, garantindo tempos de resposta rápidos e desempenho consistente. | Testes de Performance do Sistema | Obrigatório |
| RNF2 - Segurança | O sistema deve garantir a segurança e a confidencialidade dos dados dos usuários, adotando medidas robustas de criptografia, controle de acesso e monitoramento de atividades suspeitas.| Nenhuma violação de segurança detectada durante a avaliação periódica do sistema. | Obrigatório |
| RNF3 - Usabilidade | O sistema deve ser intuitivo e fácil de usar, com uma interface amigável que permita aos usuários realizar suas tarefas de forma eficiente, mesmo sem treinamento prévio. | Taxa de conclusão de tarefas pelos usuários deve ser superior a 90%. | Obrigatório |
| RNF4 - Confiabilidade | O sistema deve ser altamente confiável, minimizando o risco de falhas e garantindo disponibilidade contínua para os usuários.| Tempo médio entre falhas (MTBF) deve ser superior a 30 dias. | Obrigatório |
| RNF5 - Escalabilidade | O sistema deve ser projetado para escalar facilmente, permitindo lidar com o aumento da carga de trabalho e a expansão futura sem comprometer o desempenho ou a disponibilidade. | Capacidade de processamento do sistema deve permitir o crescimento de usuários e transações em pelo menos 50% ao longo de um ano. | Desejável |



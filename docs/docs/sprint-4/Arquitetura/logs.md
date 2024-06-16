---
title: Sistema de monitoramento
sidebar_position: 3
---
# Sistema de Monitoramento de Logs

Essa seção descreve a configuração e o uso do serviço de monitoramento por meio de logs para o projeto. O serviço é implementado usando FastAPI, Elasticsearch e Kibana, com suporte para registro e consulta de logs.

# Como o Sistema Funciona

## FastAPI:

- FastAPI é usado para criar uma API que recebe logs de diferentes serviços.
- A API tem endpoints para registrar logs ``(/log)``, verificar a saúde do serviço ``(/ping)``, e consultar logs armazenados ``(/)``.
- Quando um log é enviado para o endpoint ``/log``, ele é indexado (armazenado) no Elasticsearch.

## Elasticsearch:

- Elasticsearch é um motor de busca e análise de dados distribuído.
- Ele armazena os logs recebidos pela API do FastAPI.
- Os logs são indexados, o que significa que eles são organizados de forma a permitir buscas rápidas e eficientes.
- Os dados podem ser consultados quase em tempo real, o que é crucial para monitoramento de sistemas.

## Kibana:

- Kibana é uma interface de análise e visualização que trabalha com os dados armazenados no Elasticsearch.
- Ele permite criar dashboards interativos para visualizar e analisar os logs.
- Usando Kibana, podemos criar gráficos, tabelas e outras visualizações que ajudam a entender melhor os dados de log.
- Facilita o monitoramento e a análise de logs de forma visual e intuitiva.

# Por que Usar Kibana e Elasticsearch

## Elasticsearch

- Desempenho: Capacidade de buscar e analisar grandes volumes de dados de forma muito rápida.
- Escalabilidade: Pode ser distribuído em vários nós, permitindo lidar com grandes quantidades de dados.
- Flexibilidade: Suporta diversos tipos de dados e permite realizar buscas complexas.

## Kibana

- Visualização: Oferece ferramentas poderosas para criar visualizações que ajudam a entender os dados.
- Interatividade: Dashboards interativos que permitem explorar os dados de diferentes maneiras.
- Facilidade de Uso: Interface amigável que facilita a criação de gráficos e visualizações sem necessidade de código.

# Detalhes da Implementação

## Características Principais

- **Registro de Logs:** Logs podem ser registrados com informações sobre o serviço, usuário, ação, resultado, causa e timestamp.
- **Consulta de Logs:** Logs registrados podem ser consultados através de uma API.
- **Visualização de Logs:** Logs são visualizados e analisados no Kibana.
- **Configuração via Docker Compose:** Serviços são configurados e gerenciados usando Docker Compose.

## API com FastAPI

### Endpoints

**1. Registro de Log:**

- Método: ``POST``
- Rota: /log
- Descrição: Este endpoint recebe uma entrada de log contendo detalhes como o serviço, o ID do usuário, a ação realizada, o resultado, a causa (opcional) e o timestamp (opcional). O log é então indexado no Elasticsearch.
- Corpo da Requisição: Deve conter um objeto JSON com os campos mencionados acima.
- Resposta: Retorna um status de sucesso e o ID do log indexado no Elasticsearch.

**2. Ping:**

- Método: ``POST``
- Rota: /ping
- Descrição: Este endpoint é usado para verificar se o serviço está funcionando corretamente. Ele retorna um status de sucesso.
- Corpo da Requisição: Não é necessário.
- Resposta: Retorna um status de sucesso.

**3. Consulta de Logs:**

- Método: ``GET``
- Rota: /
- Descrição: Este endpoint permite a consulta de todos os logs armazenados no Elasticsearch. Ele realiza uma busca por todos os documentos no índice de logs e retorna os resultados.
- Corpo da Requisição: Não é necessário.
- Resposta: Retorna todos os logs armazenados, organizados por índice.

### Mecanismo de Indexação

Quando um log é enviado para o endpoint de registro ``(/log)``, a API:

- Verifica se o campo timestamp está presente. Se não estiver, atribui o timestamp atual.
- Converte o log para um formato JSON.
- Envia o log para o Elasticsearch, onde é indexado.
- Retorna uma resposta de sucesso com o ID do log indexado.

### Tratamento de Erros
A API possui tratamento de erros para garantir a robustez do sistema:

- Em caso de falha na conexão com o Elasticsearch, é retornado um erro 500 com a mensagem "Elasticsearch connection error".

## Configuração do Docker Compose
A configuração do Docker Compose envolve a definição dos serviços Elasticsearch e Kibana, especificando as imagens Docker a serem usadas, volumes de dados, portas expostas e variáveis de ambiente necessárias. O Elasticsearch é configurado para rodar como um nó único, enquanto o Kibana é configurado para se conectar ao Elasticsearch.

### Passos para Configuração

1. **Instalar Dependências:** Certifique-se de ter o Docker e Docker Compose instalados na sua máquina.

2. **Configurar Variáveis de Ambiente:** Crie um arquivo ``.env`` com as seguintes variáveis:

    ``STACK_VERSION=7.15.0``

    ``ES_PORT=9200``

    ``KIBANA_PORT=5601``

    ``ELASTIC_PASSWORD=your_elastic_password``

    ``KIBANA_PASSWORD=your_kibana_password``

    ``CLUSTER_NAME=docker-cluster``

    ``MEM_LIMIT=1g``

    ``LICENSE=basic``

3. **Iniciar os Serviços:** Execute os seguintes comandos para iniciar os serviços:

    ``docker-compose down``

    ``docker-compose up -d``

4. **Verificar Logs:** Verifique os logs dos serviços para garantir que estão rodando corretamente.


    ``docker-compose logs -f es01``

    ``docker-compose logs -f kibana``

5. **Acessar Kibana:** Acesse Kibana através do navegador na URL ``http://localhost:5601.``

## Verificação e Monitoramento
Para verificar e monitorar os logs indexados:

1. **Acessar Kibana:** Abra Kibana no navegador.
2. **Criar um Padrão de Índice:** Navegue até Stack Management > Index Patterns e crie um novo padrão de índice para log*.
3. **Explorar Dados:** Use a aba Discover para explorar os logs armazenados no Elasticsearch.

![logs Kibana](/img/sprint-4/Kibana.png)

---
title: Sistema de monitoramento
sidebar_position: 3
---
# Sistema de Monitoramento - Logs

Este documento descreve a configuração e o uso do serviço de monitoramento por meio de logs para o projeto. O serviço é implementado usando a biblioteca ``logging`` do Python, com suporte para rotação de arquivos de log e saída para o console.

## Funcionalidade

A função ``setup_logger`` é responsável por configurar e retornar um logger que pode ser usado em diferentes partes do projeto para registrar eventos e mensagens de depuração.

### Características Principais

- **Nível de Log:** Configurado para capturar todos os níveis de log (``DEBUG`` e superiores).
- **Formato de Log:** As mensagens de log seguem o formato: ``timestamp - logger_name - log_level - message.``
- **Rotação de Arquivos de Log:** Logs são gravados em arquivos com rotação configurada para evitar crescimento ilimitado dos arquivos de log.
- **Saída para Console:** Logs são também exibidos no console para facilitar o monitoramento em tempo real.`

## Detalhes da Implementação

### Importações

`import logging`

`from logging.handlers import RotatingFileHandler`

`import os`

### Função ``setup_logger``

### Parâmetros

``name:`` Nome do logger. Este nome é usado para identificar o logger e será incluído nas mensagens de log.

### Funcionalidade

**1. Criação do Logger:**

``logger = logging.getLogger(name):`` Cria ou obtém um logger com o nome especificado.

`logger.setLevel(logging.DEBUG):` Define o nível mínimo de log para DEBUG.

**2. Formato do Log:**

``formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s'):`` Define o formato das mensagens de log.

**3. Handler de Arquivo com Rotação:**

`log_file_path = os.path.join(os.path.dirname(__file__), 'log_files', f'{name}.log'):` Define o caminho do arquivo de log.

`os.makedirs(os.path.dirname(log_file_path), exist_ok=True):` Cria o diretório para os arquivos de log, se não existir.

`file_handler = RotatingFileHandler(log_file_path, maxBytes=10240, backupCount=3):` Configura o handler de arquivo com rotação. Os arquivos de log terão um tamanho máximo de 10 KB e até 3 backups serão mantidos.

`file_handler.setFormatter(formatter):` Define o formato das mensagens de log para o handler de arquivo.

`file_handler.setLevel(logging.DEBUG):` Define o nível mínimo de log para o handler de arquivo.

**4. Handler de Console:**

`console_handler = logging.StreamHandler():` Cria um handler para saída no console.

`console_handler.setFormatter(formatter):` Define o formato das mensagens de log para o handler de console.

`console_handler.setLevel(logging.DEBUG):` Define o nível mínimo de log para o handler de console.

**5. Adição dos Handlers ao Logger:**

`logger.addHandler(file_handler):` Adiciona o handler de arquivo ao logger.

`logger.addHandler(console_handler):` Adiciona o handler de console ao logger.

**6. Retorno**

A função retorna o logger configurado.

## Uso

Para usar o logger em diferentes partes do projeto, basta chamar a função `setup_logger` com um nome apropriado e usar o logger retornado para registrar mensagens de log.

`logger = setup_logger('meu_logger')`

`logger.debug('Esta é uma mensagem de depuração')`

`logger.info('Esta é uma mensagem de informação')`

`logger.warning('Esta é uma mensagem de aviso')`

`logger.error('Esta é uma mensagem de erro')`

`logger.critical('Esta é uma mensagem crítica')`


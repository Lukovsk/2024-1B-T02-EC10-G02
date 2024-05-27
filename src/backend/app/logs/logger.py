import logging
from logging.handlers import RotatingFileHandler
import os

def setup_logger(name):
    # Cria um logger
    logger = logging.getLogger(name)
    logger.setLevel(logging.DEBUG)  # Configura o nível mínimo de log

    # Formato do log
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

    # Handler para escrever logs em arquivo, com rotação de arquivo
    log_file_path = os.path.join(os.path.dirname(__file__), 'log_files', f'{name}.log')
    os.makedirs(os.path.dirname(log_file_path), exist_ok=True)
    file_handler = RotatingFileHandler(log_file_path, maxBytes=10240, backupCount=3)
    file_handler.setFormatter(formatter)
    file_handler.setLevel(logging.DEBUG)

    # Handler para a saída console
    console_handler = logging.StreamHandler()
    console_handler.setFormatter(formatter)
    console_handler.setLevel(logging.DEBUG)  # apenas erros serão logados no console

    # Adiciona os handlers ao logger
    logger.addHandler(file_handler)
    logger.addHandler(console_handler)

    return logger
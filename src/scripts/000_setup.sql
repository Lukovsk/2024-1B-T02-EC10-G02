CREATE DATABASE postgres;

\c postgres;

-- Criar a tabela de Usuário
CREATE TABLE  "User" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    identification_code VARCHAR(20) NOT NULL
);

-- Criar a tabela de Medicamento
CREATE TABLE "Medicine" (
    id SERIAL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    area VARCHAR(50),
    class VARCHAR(50),
    quantity INT NOT NULL,
    max_quantity INT NOT NULL
);

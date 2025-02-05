-- (C) Agência Veritatis 2024
-- Autores: Ana Cerqueira e José Lopes

DROP DATABASE IF EXISTS Veritatis;
CREATE DATABASE Veritatis
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE Veritatis;

CREATE TABLE Funcao(
    Id INT NOT NULL AUTO_INCREMENT,
    Designacao VARCHAR(75) NOT NULL,

    PRIMARY KEY (Id)
);

CREATE TABLE Funcionario(
    Id INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(75) NOT NULL,
    NIF INT NOT NULL UNIQUE CHECK(LENGTH(NIF) = 9),
    Salario DECIMAL(6,2) NOT NULL CHECK(Salario >= 0),
    SeguroVida INT NULL CHECK(LENGTH(SeguroVida) = 9),
    Email VARCHAR(255) UNIQUE NOT NULL,
    Telefone VARCHAR(20) UNIQUE NULL,

    PRIMARY KEY(Id)
);

CREATE TABLE Exerce(
    Funcao INT NOT NULL,
    Funcionario INT NOT NULL,

    PRIMARY KEY(Funcao, Funcionario),
    FOREIGN KEY(Funcao)      REFERENCES Funcao(Id),
    FOREIGN KEY(Funcionario) REFERENCES Funcionario(Id)
);

CREATE TABLE Cliente(
    Id INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(75) NOT NULL,
    Morada VARCHAR(200) NULL,
    NIF INT NOT NULL UNIQUE CHECK(LENGTH(NIF) = 9),
    LocalTrabalho VARCHAR(75) NOT NULL,

    PRIMARY KEY(Id)
);

CREATE TABLE Emails(
    Cliente INT NOT NULL,
    Email VARCHAR(255) NOT NULL,

    PRIMARY KEY (Email),
    FOREIGN KEY (Cliente) REFERENCES Cliente (Id)
);

CREATE TABLE Telefones(
    Cliente INT NOT NULL,
    Telefone VARCHAR(20) NOT NULL,

    PRIMARY KEY (Telefone),
    FOREIGN KEY (Cliente) REFERENCES Cliente (Id)
);

CREATE TABLE Caso(
    Id INT NOT NULL AUTO_INCREMENT,
    Designacao VARCHAR(75) NOT NULL,
    DataInicio DATE NOT NULL,
    DataTermino DATE NULL,
    DataPagamento DATE NULL,
    CustoAbertura DECIMAL(5,2) NOT NULL CHECK (CustoAbertura >= 0),
    Cliente INT NOT NULL,
    Detetive INT NULL,

    PRIMARY KEY (Id),
    FOREIGN KEY (Cliente) REFERENCES Cliente (Id),
    FOREIGN KEY (Detetive) REFERENCES Funcionario (Id),
    CONSTRAINT chk_datas CHECK ((DataInicio <= DataTermino)
        AND (DataTermino <= DataPagamento))
);

CREATE TABLE TipoProcedimento(
    Id INT NOT NULL AUTO_INCREMENT,
    Designacao VARCHAR(75) NOT NULL,
    CustoAgencia DECIMAL(5,2) NOT NULL CHECK (CustoAgencia >= 0),
    CustoCliente DECIMAL(5,2) NOT NULL CHECK (CustoCliente >= 0),

    Descricao TEXT NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE Procedimento(
    Id INT NOT NULL AUTO_INCREMENT,
    Tipo INT NOT NULL,
    Notas TEXT NULL,
    Data DATE NOT NULL,
    CustoAgencia DECIMAL (5,2) NOT NULL DEFAULT 0 CHECK (CustoAgencia >= 0),
    CustoCliente DECIMAL (5,2) NOT NULL DEFAULT 0 CHECK (CustoCliente >= 0),
    Caso INT NOT NULL,

    PRIMARY KEY (Id),
    FOREIGN KEY (Tipo) REFERENCES TipoProcedimento (Id),
    FOREIGN KEY (Caso) REFERENCES Caso (Id)
);

CREATE TABLE Provas(
    Procedimento INT NOT NULL,
    Descricao TEXT NOT NULL,
    Local VARCHAR(200) NOT NULL,

    PRIMARY KEY (Procedimento, Descricao(767)),
    FOREIGN KEY (Procedimento) REFERENCES Procedimento(Id)
);

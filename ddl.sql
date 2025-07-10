-- SIGEPOLI - Script DDL (MySQL)
-- Criação das tabelas principais e relacionamentos

-- =====================
-- TABELAS PRINCIPAIS
-- =====================

CREATE TABLE Departamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    orcamento_anual DECIMAL(12,2) NOT NULL,
    chefe_id INT NULL
);

CREATE TABLE Titulacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Colaborador (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    departamento_id INT NOT NULL,
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
);

CREATE TABLE Professor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    departamento_id INT NOT NULL,
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
);

CREATE TABLE Professor_Titulacao (
    professor_id INT NOT NULL,
    titulacao_id INT NOT NULL,
    PRIMARY KEY (professor_id, titulacao_id),
    FOREIGN KEY (professor_id) REFERENCES Professor(id),
    FOREIGN KEY (titulacao_id) REFERENCES Titulacao(id)
);

CREATE TABLE Curso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    departamento_id INT NOT NULL,
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
);

CREATE TABLE Coordenador (
    id INT AUTO_INCREMENT PRIMARY KEY,
    professor_id INT NOT NULL UNIQUE,
    curso_id INT NOT NULL UNIQUE,
    FOREIGN KEY (professor_id) REFERENCES Professor(id),
    FOREIGN KEY (curso_id) REFERENCES Curso(id)
);

CREATE TABLE Disciplina (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    curso_id INT NOT NULL,
    carga_horaria INT NOT NULL,
    FOREIGN KEY (curso_id) REFERENCES Curso(id)
);

CREATE TABLE Turma (
    id INT AUTO_INCREMENT PRIMARY KEY,
    disciplina_id INT NOT NULL,
    ano INT NOT NULL,
    semestre ENUM('1','2') NOT NULL,
    horario VARCHAR(50) NOT NULL,
    vagas INT NOT NULL,
    FOREIGN KEY (disciplina_id) REFERENCES Disciplina(id)
);

CREATE TABLE Turma_Professor (
    turma_id INT NOT NULL,
    professor_id INT NOT NULL,
    PRIMARY KEY (turma_id, professor_id),
    FOREIGN KEY (turma_id) REFERENCES Turma(id),
    FOREIGN KEY (professor_id) REFERENCES Professor(id)
);

CREATE TABLE Aluno (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL
);

CREATE TABLE Matricula (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aluno_id INT NOT NULL,
    turma_id INT NOT NULL,
    data DATE NOT NULL,
    status ENUM('ativa','cancelada') NOT NULL DEFAULT 'ativa',
    propina_paga BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY (aluno_id) REFERENCES Aluno(id),
    FOREIGN KEY (turma_id) REFERENCES Turma(id),
    UNIQUE (aluno_id, turma_id)
);

CREATE TABLE Avaliacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    matricula_id INT NOT NULL,
    nota DECIMAL(4,2) NOT NULL CHECK (nota >= 0 AND nota <= 20),
    data DATE NOT NULL,
    FOREIGN KEY (matricula_id) REFERENCES Matricula(id)
);

CREATE TABLE Empresa (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    tipo_servico ENUM('limpeza','seguranca','cafeteria') NOT NULL
);

CREATE TABLE Contrato (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa_id INT NOT NULL,
    valor DECIMAL(12,2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    garantia_valida BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY (empresa_id) REFERENCES Empresa(id)
);

CREATE TABLE SLA (
    id INT AUTO_INCREMENT PRIMARY KEY,
    contrato_id INT NOT NULL,
    percentual DECIMAL(5,2) NOT NULL CHECK (percentual >= 0 AND percentual <= 100),
    mes INT NOT NULL CHECK (mes >= 1 AND mes <= 12),
    ano INT NOT NULL,
    FOREIGN KEY (contrato_id) REFERENCES Contrato(id)
);

CREATE TABLE Pagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    contrato_id INT NOT NULL,
    valor DECIMAL(12,2) NOT NULL,
    data DATE NOT NULL,
    multa DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY (contrato_id) REFERENCES Contrato(id)
);

-- =====================
-- ÍNDICES E RESTRIÇÕES ADICIONAIS
-- =====================

CREATE INDEX idx_professor_departamento ON Professor(departamento_id);
CREATE INDEX idx_colaborador_departamento ON Colaborador(departamento_id);
CREATE INDEX idx_disciplina_curso ON Disciplina(curso_id);
CREATE INDEX idx_turma_disciplina ON Turma(disciplina_id);
CREATE INDEX idx_matricula_aluno ON Matricula(aluno_id);
CREATE INDEX idx_matricula_turma ON Matricula(turma_id);
CREATE INDEX idx_avaliacao_matricula ON Avaliacao(matricula_id);
CREATE INDEX idx_contrato_empresa ON Contrato(empresa_id);
CREATE INDEX idx_sla_contrato ON SLA(contrato_id);
CREATE INDEX idx_pagamento_contrato ON Pagamento(contrato_id);

-- =====================
-- RELACIONAMENTOS E REGRAS DE NEGÓCIO (a serem implementadas em triggers/procedures)
-- =====================
-- Exemplo: Um professor não pode ter aulas em turmas com horários sobrepostos (ver triggers)
-- Exemplo: Matrícula só permitida se houver vaga e propina paga (ver procedures/triggers)
-- Exemplo: Notas entre 0-20 (CHECK já implementado)
-- Exemplo: Pagamento só com garantia válida (ver triggers)
-- Exemplo: SLA < 90% gera multa automática (ver procedures/triggers)
-- Exemplo: Coordenador aprova carga horária dos professores (ver procedures) 
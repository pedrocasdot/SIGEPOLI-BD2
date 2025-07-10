-- SIGEPOLI - Triggers principais

-- Tabelas de auditoria
CREATE TABLE AuditoriaMatricula (
    id INT AUTO_INCREMENT PRIMARY KEY,
    matricula_id INT,
    acao VARCHAR(20),
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100)
);

CREATE TABLE AuditoriaPagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pagamento_id INT,
    acao VARCHAR(20),
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100)
);

-- 1. Trigger: Auditoria de matrículas (INSERT, UPDATE, DELETE)
DELIMITER //
CREATE TRIGGER trg_auditoria_matricula
AFTER INSERT ON Matricula
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaMatricula (matricula_id, acao, usuario)
    VALUES (NEW.id, 'INSERT', USER());
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_auditoria_matricula_update
AFTER UPDATE ON Matricula
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaMatricula (matricula_id, acao, usuario)
    VALUES (NEW.id, 'UPDATE', USER());
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_auditoria_matricula_delete
AFTER DELETE ON Matricula
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaMatricula (matricula_id, acao, usuario)
    VALUES (OLD.id, 'DELETE', USER());
END //
DELIMITER ;

-- 2. Trigger: Auditoria de pagamentos (INSERT, UPDATE, DELETE)
DELIMITER //
CREATE TRIGGER trg_auditoria_pagamento
AFTER INSERT ON Pagamento
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaPagamento (pagamento_id, acao, usuario)
    VALUES (NEW.id, 'INSERT', USER());
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_auditoria_pagamento_update
AFTER UPDATE ON Pagamento
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaPagamento (pagamento_id, acao, usuario)
    VALUES (NEW.id, 'UPDATE', USER());
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_auditoria_pagamento_delete
AFTER DELETE ON Pagamento
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaPagamento (pagamento_id, acao, usuario)
    VALUES (OLD.id, 'DELETE', USER());
END //
DELIMITER ;

-- 3. Trigger: Bloqueio automático de pagamento sem garantia (RN04)
DELIMITER //
CREATE TRIGGER trg_bloqueio_pagamento_sem_garantia
BEFORE INSERT ON Pagamento
FOR EACH ROW
BEGIN
    DECLARE v_garantia BOOLEAN;
    SELECT garantia_valida INTO v_garantia FROM Contrato WHERE id = NEW.contrato_id;
    IF v_garantia = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pagamento não permitido: contrato sem garantia válida.';
    END IF;
END //
DELIMITER ; 
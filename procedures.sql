-- SIGEPOLI - Procedures principais

-- 1. Procedure: Matricular aluno (RN02)
-- Só permite matrícula se houver vaga e propina paga
DELIMITER //
CREATE PROCEDURE MatricularAluno(
    IN p_aluno_id INT,
    IN p_turma_id INT,
    IN p_data DATE
)
BEGIN
    DECLARE v_vagas INT;
    DECLARE v_matriculados INT;
    DECLARE v_propina_paga BOOLEAN;

    -- Verifica vagas disponíveis
    SELECT vagas INTO v_vagas FROM Turma WHERE id = p_turma_id;
    SELECT COUNT(*) INTO v_matriculados FROM Matricula WHERE turma_id = p_turma_id AND status = 'ativa';
    IF v_matriculados >= v_vagas THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Turma sem vagas disponíveis.';
    END IF;

    -- Verifica se propina está paga (simulação: parâmetro ou lógica adicional)
    SET v_propina_paga = 1; -- Aqui pode-se adaptar para lógica real
    IF v_propina_paga = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Propina não está paga.';
    END IF;

    -- Realiza matrícula
    INSERT INTO Matricula (aluno_id, turma_id, data, status, propina_paga)
    VALUES (p_aluno_id, p_turma_id, p_data, 'ativa', 1);
END //
DELIMITER ;

-- 2. Procedure: Alocar professor em turma (RN01)
-- Não permite alocação se houver sobreposição de horários
DELIMITER //
CREATE PROCEDURE AlocarProfessorTurma(
    IN p_professor_id INT,
    IN p_turma_id INT
)
BEGIN
    DECLARE v_horario VARCHAR(50);
    DECLARE v_ano INT;
    DECLARE v_semestre ENUM('1','2');
    DECLARE v_count INT;

    SELECT horario, ano, semestre INTO v_horario, v_ano, v_semestre FROM Turma WHERE id = p_turma_id;
    SELECT COUNT(*) INTO v_count
    FROM Turma_Professor tp
    JOIN Turma t ON tp.turma_id = t.id
    WHERE tp.professor_id = p_professor_id
      AND t.ano = v_ano
      AND t.semestre = v_semestre
      AND t.horario = v_horario;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Professor já alocado em turma com horário sobreposto.';
    END IF;
    
    INSERT INTO Turma_Professor (turma_id, professor_id)
    VALUES (p_turma_id, p_professor_id);
END //
DELIMITER ;

-- 3. Procedure: Processar pagamento com cálculo de multa (RN05)
-- Se SLA < 90% no mês, aplica multa automática
DELIMITER //
CREATE PROCEDURE ProcessarPagamento(
    IN p_contrato_id INT,
    IN p_valor DECIMAL(12,2),
    IN p_data DATE,
    IN p_mes INT,
    IN p_ano INT
)
BEGIN
    DECLARE v_percentual DECIMAL(5,2);
    DECLARE v_multa DECIMAL(12,2) DEFAULT 0;
    DECLARE v_valor DECIMAL(12,2);

    -- Busca percentual de SLA do mês
    SELECT percentual INTO v_percentual FROM SLA WHERE contrato_id = p_contrato_id AND mes = p_mes AND ano = p_ano;
    SET v_valor = p_valor;
    IF v_percentual < 90 THEN
        SET v_multa = v_valor * 0.1; -- Multa de 10%
    END IF;
    
    INSERT INTO Pagamento (contrato_id, valor, data, multa)
    VALUES (p_contrato_id, v_valor, p_data, v_multa);
END //
DELIMITER ; 
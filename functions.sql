-- SIGEPOLI - Functions principais

-- 1. Função: Calcular média das avaliações de um aluno em uma turma
DELIMITER //
CREATE FUNCTION MediaAlunoTurma(p_aluno_id INT, p_turma_id INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE v_media DECIMAL(5,2);
    SELECT AVG(a.nota) INTO v_media
    FROM Avaliacao a
    JOIN Matricula m ON a.matricula_id = m.id
    WHERE m.aluno_id = p_aluno_id AND m.turma_id = p_turma_id;
    RETURN v_media;
END //
DELIMITER ;

-- 2. Função: Calcular percentual de SLA mensal de um contrato
DELIMITER //
CREATE FUNCTION PercentualSLA(p_contrato_id INT, p_mes INT, p_ano INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE v_percentual DECIMAL(5,2);
    SELECT percentual INTO v_percentual
    FROM SLA
    WHERE contrato_id = p_contrato_id AND mes = p_mes AND ano = p_ano;
    RETURN v_percentual;
END //
DELIMITER ; 
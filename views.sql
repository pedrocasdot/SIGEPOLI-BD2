-- SIGEPOLI - Views analíticas

-- 1. View: Grade horária por curso
CREATE OR REPLACE VIEW vw_grade_horaria_curso AS
SELECT 
    c.nome AS curso,
    d.nome AS disciplina,
    t.id AS turma_id,
    t.ano,
    t.semestre,
    t.horario
FROM Curso c
JOIN Disciplina d ON d.curso_id = c.id
JOIN Turma t ON t.disciplina_id = d.id;

-- 2. View: Carga horária por professor
CREATE OR REPLACE VIEW vw_carga_horaria_professor AS
SELECT 
    p.id AS professor_id,
    p.nome AS professor,
    SUM(d.carga_horaria) AS carga_total
FROM Professor p
JOIN Turma_Professor tp ON tp.professor_id = p.id
JOIN Turma t ON t.id = tp.turma_id
JOIN Disciplina d ON d.id = t.disciplina_id
GROUP BY p.id, p.nome;

-- 3. View: Resumo de custos de serviços por mês
CREATE OR REPLACE VIEW vw_resumo_custos_servicos AS
SELECT 
    e.tipo_servico,
    YEAR(p.data) AS ano,
    MONTH(p.data) AS mes,
    SUM(p.valor + IFNULL(p.multa,0)) AS total_pago
FROM Pagamento p
JOIN Contrato c ON c.id = p.contrato_id
JOIN Empresa e ON e.id = c.empresa_id
GROUP BY e.tipo_servico, ano, mes; 
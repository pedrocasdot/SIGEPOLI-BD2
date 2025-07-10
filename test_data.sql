-- SIGEPOLI - Dados de teste e consultas ad-hoc

-- ========== INSERTS REALISTAS ========== --
INSERT INTO Departamento (nome, orcamento_anual) VALUES ('Engenharia', 1000000), ('Administração', 500000);
INSERT INTO Titulacao (nome) VALUES ('Doutor'), ('Mestre'), ('Especialista');
INSERT INTO Professor (nome, departamento_id) VALUES ('Ana Silva', 1), ('Carlos Souza', 1), ('Beatriz Lima', 2);
INSERT INTO Professor_Titulacao (professor_id, titulacao_id) VALUES (1,1), (2,2), (3,3);
INSERT INTO Curso (nome, departamento_id) VALUES ('Engenharia Civil', 1), ('Administração de Empresas', 2);
INSERT INTO Coordenador (professor_id, curso_id) VALUES (1,1), (3,2);
INSERT INTO Disciplina (nome, curso_id, carga_horaria) VALUES ('Cálculo', 1, 60), ('Gestão', 2, 40);
INSERT INTO Turma (disciplina_id, ano, semestre, horario, vagas) VALUES (1,2024,'1','08:00-10:00',2), (2,2024,'1','10:00-12:00',2);
INSERT INTO Aluno (nome, data_nascimento) VALUES ('João Pedro', '2000-05-10'), ('Maria Clara', '2001-08-22');
INSERT INTO Empresa (nome, tipo_servico) VALUES ('LimpaFácil', 'limpeza'), ('SeguraBem', 'seguranca');
INSERT INTO Contrato (empresa_id, valor, data_inicio, data_fim, garantia_valida) VALUES (1, 2000, '2024-01-01', '2024-12-31', 1), (2, 3000, '2024-01-01', '2024-12-31', 0);
INSERT INTO SLA (contrato_id, percentual, mes, ano) VALUES (1, 95, 1, 2024), (2, 85, 1, 2024);

-- Matrícula e avaliações
CALL MatricularAluno(1,1,'2024-02-01');
CALL MatricularAluno(2,1,'2024-02-01');
INSERT INTO Avaliacao (matricula_id, nota, data) VALUES (1, 18, '2024-03-01'), (1, 16, '2024-04-01'), (2, 14, '2024-03-01');

-- Alocação de professor
CALL AlocarProfessorTurma(1,1);
CALL AlocarProfessorTurma(2,1);

-- Pagamentos
CALL ProcessarPagamento(1, 2000, '2024-02-05', 1, 2024); -- SLA > 90%, sem multa
CALL ProcessarPagamento(2, 3000, '2024-02-05', 1, 2024); -- SLA < 90%, com multa

-- ========== CONSULTAS AD-HOC ========== --
-- 1. Listar todos os departamentos e seus orçamentos
SELECT * FROM Departamento;
-- 2. Professores e suas titulações
SELECT p.nome, t.nome AS titulacao FROM Professor p JOIN Professor_Titulacao pt ON p.id=pt.professor_id JOIN Titulacao t ON t.id=pt.titulacao_id;
-- 3. Cursos e coordenadores
SELECT c.nome AS curso, p.nome AS coordenador FROM Curso c JOIN Coordenador co ON c.id=co.curso_id JOIN Professor p ON p.id=co.professor_id;
-- 4. Disciplinas de cada curso
SELECT c.nome AS curso, d.nome AS disciplina FROM Curso c JOIN Disciplina d ON d.curso_id=c.id;
-- 5. Turmas e seus horários
SELECT t.id, d.nome AS disciplina, t.ano, t.semestre, t.horario FROM Turma t JOIN Disciplina d ON t.disciplina_id=d.id;
-- 6. Alunos matriculados em cada turma
SELECT t.id AS turma, a.nome AS aluno FROM Matricula m JOIN Aluno a ON m.aluno_id=a.id JOIN Turma t ON m.turma_id=t.id;
-- 7. Notas dos alunos
SELECT a.nome AS aluno, av.nota FROM Aluno a JOIN Matricula m ON a.id=m.aluno_id JOIN Avaliacao av ON av.matricula_id=m.id;
-- 8. Média do aluno João Pedro na turma 1
SELECT MediaAlunoTurma(1,1) AS media_joao;
-- 9. Percentual de SLA do contrato 1 em jan/2024
SELECT PercentualSLA(1,1,2024) AS sla_jan;
-- 10. Pagamentos realizados e multas
SELECT p.id, e.nome AS empresa, p.valor, p.multa FROM Pagamento p JOIN Contrato c ON p.contrato_id=c.id JOIN Empresa e ON e.id=c.empresa_id;
-- 11. Auditoria de matrículas
SELECT * FROM AuditoriaMatricula;
-- 12. Auditoria de pagamentos
SELECT * FROM AuditoriaPagamento;
-- 13. Grade horária do curso de Engenharia Civil
SELECT * FROM vw_grade_horaria_curso WHERE curso='Engenharia Civil';
-- 14. Carga horária por professor
SELECT * FROM vw_carga_horaria_professor;
-- 15. Resumo de custos de serviços por mês
SELECT * FROM vw_resumo_custos_servicos; 
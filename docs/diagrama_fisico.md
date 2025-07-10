# Diagrama Físico - SIGEPOLI

O diagrama físico detalha as tabelas, principais campos e relacionamentos implementados no banco de dados. Para visualização gráfica, consulte o arquivo `er_diagram.md`.

## Tabelas principais
- **Departamento** (id, nome, orcamento_anual, chefe_id)
- **Colaborador** (id, nome, cargo, departamento_id)
- **Professor** (id, nome, departamento_id)
- **Titulacao** (id, nome)
- **Professor_Titulacao** (professor_id, titulacao_id)
- **Curso** (id, nome, departamento_id)
- **Coordenador** (id, professor_id, curso_id)
- **Disciplina** (id, nome, curso_id, carga_horaria)
- **Turma** (id, disciplina_id, ano, semestre, horario, vagas)
- **Turma_Professor** (turma_id, professor_id)
- **Aluno** (id, nome, data_nascimento)
- **Matricula** (id, aluno_id, turma_id, data, status, propina_paga)
- **Avaliacao** (id, matricula_id, nota, data)
- **Empresa** (id, nome, tipo_servico)
- **Contrato** (id, empresa_id, valor, data_inicio, data_fim, garantia_valida)
- **SLA** (id, contrato_id, percentual, mes, ano)
- **Pagamento** (id, contrato_id, valor, data, multa)
- **AuditoriaMatricula** (id, matricula_id, acao, data, usuario)
- **AuditoriaPagamento** (id, pagamento_id, acao, data, usuario)

## Relacionamentos
- Departamento 1:N Colaborador, Professor, Curso
- Professor N:M Titulacao (Professor_Titulacao)
- Curso 1:N Disciplina
- Curso 1:1 Coordenador
- Disciplina 1:N Turma
- Turma N:M Professor (Turma_Professor)
- Turma N:M Aluno (Matricula)
- Matricula 1:N Avaliacao
- Empresa 1:N Contrato
- Contrato 1:N SLA, Pagamento

Para detalhes de chaves primárias e estrangeiras, consulte o script `ddl.sql`. 
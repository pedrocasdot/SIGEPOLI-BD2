# SIGEPOLI - Sistema Integrado de Gestão Acadêmica, Pessoal e Operacional

## Objetivo
Desenhar, modelar e implementar um banco de dados relacional que integre a gestão acadêmica (cursos, turmas, matrículas e avaliações), gestão de pessoas (professores, coordenadores, administrativos) e gestão operacional (contratos com empresas de serviços de limpeza, segurança e cafeteria), garantindo rastreabilidade, controle de custos e relatórios de desempenho.

## Escopo
- Cadastro de departamentos, colaboradores, professores, coordenadores, cursos, disciplinas, turmas, alunos, avaliações, empresas terceirizadas, contratos, SLAs e pagamentos.
- Processos de matrícula, avaliação, pagamentos e auditoria.
- Relatórios analíticos e controle de regras de negócio.

## Estrutura do Projeto
- `er_diagram.md`: Diagrama ER (Mermaid)
- `ddl.sql`: Script de criação das tabelas (DDL)
- `procedures.sql`: Procedures
- `functions.sql`: Functions
- `triggers.sql`: Triggers
- `views.sql`: Views
- `test_data.sql`: Inserts e consultas de teste
- `docs/`: Documentação técnica

## Como usar
1. Execute o script `ddl.sql` para criar as tabelas no MySQL.
2. Execute os scripts de procedures, functions, triggers e views.
3. Popule com `test_data.sql`.

## Diagrama ER
Veja o arquivo `er_diagram.md` para o diagrama entidade-relacionamento.

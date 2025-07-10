# Justificativa de Índices - SIGEPOLI

## Índices criados

- **idx_professor_departamento**: acelera buscas de professores por departamento.
- **idx_colaborador_departamento**: acelera buscas de colaboradores por departamento.
- **idx_disciplina_curso**: acelera buscas de disciplinas por curso.
- **idx_turma_disciplina**: acelera buscas de turmas por disciplina.
- **idx_matricula_aluno**: acelera buscas de matrículas por aluno.
- **idx_matricula_turma**: acelera buscas de matrículas por turma.
- **idx_avaliacao_matricula**: acelera buscas de avaliações por matrícula.
- **idx_contrato_empresa**: acelera buscas de contratos por empresa.
- **idx_sla_contrato**: acelera buscas de SLAs por contrato.
- **idx_pagamento_contrato**: acelera buscas de pagamentos por contrato.

## Justificativa
Esses índices foram criados para otimizar consultas frequentes, especialmente em joins e filtros, melhorando o desempenho do sistema em operações de leitura e geração de relatórios. 
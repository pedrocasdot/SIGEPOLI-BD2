# Relatório de Regras de Negócio - SIGEPOLI

## RN01 – Um professor não pode ter aulas em turmas com horários sobrepostos.
- Implementado na procedure `AlocarProfessorTurma`, que verifica sobreposição antes de alocar.

## RN02 – Só é permitida matrícula se houver vaga e propina paga.
- Implementado na procedure `MatricularAluno`, que verifica vagas e propina antes de inserir matrícula.

## RN03 – Notas devem estar entre 0–20.
- Implementado com restrição `CHECK` na tabela `Avaliacao`.

## RN04 – Empresas precisam apresentar garantia válida antes do pagamento.
- Implementado na trigger `trg_bloqueio_pagamento_sem_garantia`, que bloqueia pagamentos sem garantia.

## RN05 – SLA inferior a 90% gera multa automática.
- Implementado na procedure `ProcessarPagamento`, que calcula multa se SLA < 90%.

## RN06 – Coordenador deve aprovar carga horária dos professores do curso.
- Pode ser implementado via workflow externo ou procedure adicional, mas a estrutura permite o controle via relação entre Coordenador, Curso e Turma_Professor. 
erDiagram
    DEPARTAMENTO ||--o{ COLABORADOR : possui
    DEPARTAMENTO ||--o{ PROFESSOR : possui
    DEPARTAMENTO ||--o{ CURSO : possui
    PROFESSOR }o--o{ TITULACAO : possui
    CURSO ||--o{ DISCIPLINA : possui
    CURSO ||--|| COORDENADOR : tem
    DISCIPLINA ||--o{ TURMA : possui
    TURMA }o--o{ PROFESSOR : leciona
    TURMA }o--o{ ALUNO : matricula
    MATRICULA ||--o{ AVALIACAO : recebe
    EMPRESA ||--o{ CONTRATO : firma
    CONTRATO ||--o{ SLA : possui
    CONTRATO ||--o{ PAGAMENTO : gera 
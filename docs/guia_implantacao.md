# Guia de Implantação - SIGEPOLI

## Pré-requisitos
- MySQL 8.x ou superior
- Cliente MySQL ou ferramenta gráfica (MySQL Workbench, DBeaver, etc)

## Passos para implantação

1. **Crie o banco de dados:**
   ```sql
   CREATE DATABASE sigepoli;
   USE sigepoli;
   ```
2. **Execute o script de criação das tabelas:**
   - `ddl.sql`
3. **Execute o script de triggers:**
   - `triggers.sql`
4. **Execute o script de procedures:**
   - `procedures.sql`
5. **Execute o script de functions:**
   - `functions.sql`
6. **Execute o script de views:**
   - `views.sql`
7. **Popule o banco com dados de teste:**
   - `test_data.sql`

## Observações
- Execute cada script na ordem acima para evitar erros de dependência.
- Para rodar os scripts, use o comando `source` no cliente MySQL ou copie e cole o conteúdo dos arquivos.
- As procedures, triggers e functions usam a sintaxe de `DELIMITER //` para facilitar a criação. 
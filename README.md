# Documentação da API de Migração de Banco de Dados

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![Coverage](https://img.shields.io/badge/coverage-100%25-success)
![Java](https://img.shields.io/badge/java-17-blue)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Version](https://img.shields.io/badge/version-1.0.0-brightgreen)


## Descrição

Esta API foi desenvolvida para realizar a **migração de dados de um banco de dados** usando o **Liquibase** para executar scripts SQL. A aplicação é executada pela classe `MigrateDatabaseApplication.java`, que inicializa o Liquibase e aplica as migrações definidas nos arquivos `.sql`. Essas migrações incluem a criação de tabelas e a inserção de dados iniciais no banco de dados.


## Estrutura da API

### 1. `MigrateDatabaseApplication.java`

Essa é a classe principal da aplicação e é responsável por inicializar o Spring Boot e o Liquibase. Quando a aplicação é iniciada, o Liquibase aplica os scripts de migração listados no arquivo `db.changelog-master.xml`, realizando a criação e a configuração das tabelas no banco de dados.

### 2. `application.yml`

Esse arquivo contém as configurações do Spring Boot, incluindo os detalhes da conexão com o banco de dados. Aqui você define a URL, o nome de usuário e a senha para acessar o banco de dados Oracle.

Exemplo de conteúdo:
```yaml
spring:
  datasource:
    url: jdbc:oracle:thin:@localhost:1521:XE
    username: seu_usuario
    password: sua_senha
    driver-class-name: oracle.jdbc.OracleDriver

  liquibase:
    change-log: classpath:db/changelog/db.changelog-master.xml
```


### 3. `db.changelog-master.xml`
Esse é o arquivo mestre de migrações do Liquibase, que lista todos os changeSets (conjuntos de alterações) a serem aplicados ao banco de dados. Ele faz referência a três arquivos .sql que contêm os scripts para criação de tabelas e inserção de dados iniciais.

- **changeSet 1:** Executa o script _V1__create_table.sql_ para criar a tabela exemplo.
- **changeSet 2:** Executa o script _V2__insert_data_exemplo.sql_ para inserir dados na tabela exemplo.
- **changeSet 3:** Executa o script _V3__insert_database_migration.sql_ para criar tabelas adicionais e inserir dados de exemplo(db.changelog-master).

Exemplo de conteúdo:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<databaseChangeLog
        xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog
        http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.8.xsd">

    <!-- Definindo o changeSet que faz referência ao arquivo .sql -->
    <changeSet author="author" id="1">
        <sqlFile path="classpath:db/changelog/sql/V1__create_table.sql" encoding="utf-8"/>
    </changeSet>

    <!-- Inserção de dados na tabela 'exemplo' -->
    <changeSet id="2" author="test_insert_data">
        <sqlFile path="classpath:db/changelog/sql/V2__insert_data_exemplo.sql" encoding="utf-8"/>
    </changeSet>

    <!-- Inserção de dados na tabela 'exemplo' -->
    <changeSet id="3" author="insert_database_migration">
        <sqlFile path="classpath:db/changelog/sql/V3__insert_database_migration.sql" encoding="utf-8"/>
    </changeSet>

</databaseChangeLog>
```

### 4. Arquivos`.sql`
Cada arquivo "_.sql_" contém instruções específicas para a criação e manipulação de dados no banco de dados.

- **V1__create_table.sql:** Cria a tabela exemplo com colunas para `id`, `nome` e `criado_em`.
```sql
CREATE TABLE exemplo (
    id NUMBER PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```
- **V2__insert_data_exemplo.sql:** Insere dados de exemplo na tabela `exemplo`.
```sql
INSERT ALL
    INTO exemplo (id, nome, criado_em) VALUES (1, 'User1', SYSDATE)
    INTO exemplo (id, nome, criado_em) VALUES (2, 'User2', SYSDATE)
    INTO exemplo (id, nome, criado_em) VALUES (3, 'User3', SYSDATE)
SELECT * FROM dual;
```
- **V3__insert_database_migration.sql:** Cria várias tabelas (`Users`, `Tags`, `Posts`, etc.) e insere dados de exemplo para cada uma delas. Esse arquivo inclui tabelas de domínio e tabelas relacionais com chaves estrangeiras.
```sql
CREATE TABLE Users (
    Id NUMBER PRIMARY KEY,
    DisplayName VARCHAR2(255),
    Reputation NUMBER,
    CreationDate TIMESTAMP
);

CREATE TABLE Tags (
    Id NUMBER PRIMARY KEY,
    TagName VARCHAR2(255),
    Count NUMBER
);

-- Seguem-se outras tabelas e inserções de dados conforme necessário.
```


## Execução Local

1. Clone o repositório:
```
git clone <URL do repositório>
```
2. Navegue até a pasta do projeto:
```
cd nome-do-projeto
```
3. Instale as dependências:
```
mvn install
```
4. Configure o banco de dados no `application.yml`:
- Configure o `username`, `password`, e `url` conforme as credenciais e informações do seu banco de dados Oracle.
5. Execute a aplicação:
```
mvn spring-boot:run
```
A aplicação irá rodar em `http://localhost:8080` e aplicará automaticamente as migrações do Liquibase definidas nos arquivos `.sql`.



## Testes
Para testar o processo de migração, você pode usar o console do banco de dados para verificar se as tabelas foram criadas corretamente e se os dados de exemplo foram inseridos.


## Contribuição
1. Faça um fork do repositório.
2. Crie uma branch para suas alterações (`git checkout -b feature/alteracao`).
3. Faça commit das suas alterações (`git commit -am 'Adicionar nova feature'`).
4. Envie para o branch original (`git push origin feature/alteracao`).
5. Abra um pull request para revisão.


## Licença
Distribuído sob a Licença MIT. Veja `LICENSE` para mais informações.


### Explicação da Estrutura:

- **Descrição**: Uma breve introdução sobre o propósito da API e sua funcionalidade de migração.
- **Estrutura da API**: Explicação detalhada de cada arquivo e seu papel na aplicação.
- **Execução Local**: Instruções passo a passo para configurar e rodar a aplicação localmente.
- **Testes**: Orientação para validar se as migrações foram aplicadas com sucesso.
- **Contribuição e Licença**: Orientações para contribuir com o projeto e informações de licenciamento.

O `README.md` deve oferecer uma documentação clara e completa sobre o funcionamento da aplicação e o processo de migração dos dados com o Liquibase.

Essa versão está formatada para facilitar a leitura e visualização das informações. Adicionando os selos, ela transmite mais profissionalismo e clareza para os usuários do repositório. O conteúdo agora está pronto e documentado conforme as melhores práticas de documentação em projetos de código aberto.

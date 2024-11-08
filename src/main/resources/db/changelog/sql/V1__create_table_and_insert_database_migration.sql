-- Criar changeSets das tabelas independentes (primeiro as tabelas de dominio)

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

CREATE TABLE Posts (
    Id NUMBER PRIMARY KEY,
    Title VARCHAR2(255),
    Body VARCHAR2(255),
    OwnerUserId NUMBER,
    CreationDate TIMESTAMP,
    FOREIGN KEY (OwnerUserId) REFERENCES Users(Id)
);

CREATE TABLE Badges (
    Id NUMBER PRIMARY KEY,
    UserId NUMBER,
    Name VARCHAR2(255),
    BadgeDate TIMESTAMP,
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);

-- Criar changeSets para as tabelas dependentes (relacionais)

CREATE TABLE PostTags (
    PostId NUMBER,
    TagId NUMBER,
    PRIMARY KEY (PostId, TagId),
    FOREIGN KEY (PostId) REFERENCES Posts(Id),
    FOREIGN KEY (TagId) REFERENCES Tags(Id)
);

CREATE TABLE Comments (
    Id NUMBER PRIMARY KEY,
    PostId NUMBER,
    UserId NUMBER,
    Text VARCHAR2(255),
    CreationDate TIMESTAMP,
    FOREIGN KEY (PostId) REFERENCES Posts(Id),
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);

CREATE TABLE Votes (
    Id NUMBER PRIMARY KEY,
    PostId NUMBER,
    UserId NUMBER,
    VoteTypeId NUMBER,
    CreationDate TIMESTAMP,
    FOREIGN KEY (PostId) REFERENCES Posts(Id),
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);

CREATE TABLE PostHistory (
    Id NUMBER PRIMARY KEY,
    PostId NUMBER,
    UserId NUMBER,
    Text VARCHAR2(255),
    CreationDate TIMESTAMP,
    FOREIGN KEY (PostId) REFERENCES Posts(Id),
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);

CREATE TABLE ReviewTasks (
    Id NUMBER PRIMARY KEY,
    PostId NUMBER,
    State NUMBER,
    CreationDate TIMESTAMP,
    FOREIGN KEY (PostId) REFERENCES Posts(Id)
);

-- Exemplo para inserir Dados
-- ChangeSets para inserir dados iniciais (exemplos)

INSERT ALL
	INTO Users (Id, DisplayName, Reputation, CreationDate) VALUES (1, 'User1', 100, SYSDATE)
	INTO Users (Id, DisplayName, Reputation, CreationDate) VALUES (2, 'User2', 150, SYSDATE)
SELECT * FROM dual;

INSERT ALL
	INTO Tags (Id, TagName, Count) VALUES (1, 'Java', 10)
	INTO Tags (Id, TagName, Count) VALUES (2, 'Spring', 20)
SELECT * FROM dual;

INSERT ALL
	INTO Posts (Id, Title, Body, OwnerUserId, CreationDate) VALUES (1, 'First Post', 'Content of the first post', 1, SYSDATE)
	INTO Posts (Id, Title, Body, OwnerUserId, CreationDate) VALUES (2, 'Second Post', 'Content of the second post', 2, SYSDATE)
SELECT * FROM dual;

INSERT ALL
    INTO Badges (Id, UserId, Name, BadgeDate) VALUES (1, 1, 'Contributor', SYSTIMESTAMP)
    INTO Badges (Id, UserId, Name, BadgeDate) VALUES (2, 2, 'Expert', SYSTIMESTAMP)
SELECT * FROM dual;

INSERT ALL
	INTO PostTags (PostId, TagId) VALUES (1, 1)
	INTO PostTags (PostId, TagId) VALUES (1, 2)
	INTO PostTags (PostId, TagId) VALUES (2, 1)
SELECT * FROM dual;

INSERT INTO Comments (Id, PostId, UserId, Text, CreationDate) VALUES (1, 1, 2, 'This is a comment', SYSDATE);

INSERT ALL
	INTO Votes (Id, PostId, UserId, VoteTypeId, CreationDate) VALUES (1, 1, 2, 1, SYSDATE)
	INTO Votes (Id, PostId, UserId, VoteTypeId, CreationDate) VALUES (2, 2, 1, 1, SYSDATE)
SELECT * FROM dual;

INSERT INTO PostHistory (Id, PostId, UserId, Text, CreationDate) VALUES (1, 1, 1, 'First edit', SYSDATE);

INSERT INTO ReviewTasks (Id, PostId, State, CreationDate) VALUES (1, 1, 0, SYSDATE);

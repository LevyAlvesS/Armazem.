-- Remove tabelas existentes para começar do zero (cuidado em produção!)
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS areas_armazem;
DROP TABLE IF EXISTS produtos_catalogo;
DROP TABLE IF EXISTS produtos_areas;
-- Tabela de Usuários
CREATE TABLE users (
id INTEGER PRIMARY KEY AUTOINCREMENT, -- Identificador único, auto-incrementado
 username TEXT UNIQUE NOT NULL, -- Nome de usuário, deve ser único e não pode ser vazio
 password_hash TEXT NOT NULL, -- Senha (armazenada como hash seguro, não texto puro!)
role TEXT NOT NULL DEFAULT 'user' -- Cargo/Permissão (ex: 'user', 'admin', 'manager')
);
-- Tabela de Áreas de Armazenamento
CREATE TABLE areas_armazem (
id INTEGER PRIMARY KEY AUTOINCREMENT,
 nome TEXT NOT NULL UNIQUE, -- Nome da área, deve ser único
 descricao TEXT
);
-- Tabela de Produtos do Catálogo
CREATE TABLE produtos_catalogo (
id INTEGER PRIMARY KEY AUTOINCREMENT,
 nome TEXT NOT NULL UNIQUE, -- Nome do produto no catálogo, deve ser único
 tipo TEXT, -- Tipo ou categoria do produto
 descricao TEXT
);
-- Tabela de Produtos nas Áreas (relaciona áreas com produtos do catálogo)
CREATE TABLE produtos_areas (
id INTEGER PRIMARY KEY AUTOINCREMENT,
Entendendo o SQL:
DROP TABLE IF EXISTS ...; : Remove a tabela se ela já existir. Útil para recriar o
banco do zero durante o desenvolvimento.
CREATE TABLE ... (...) : Cria uma nova tabela.
id INTEGER PRIMARY KEY AUTOINCREMENT : Define uma coluna id como um número
inteiro, que é a chave primária (identificador único de cada linha) e se autoincrementa (1, 2, 3…) para cada novo item.
TEXT NOT NULL : Define uma coluna de texto que não pode ficar vazia.
UNIQUE : Garante que os valores nesta coluna sejam únicos (ex: não podemos ter
dois usuários com o mesmo username ).
FOREIGN KEY (area_id) REFERENCES areas_armazem (id) : Cria uma relação. Diz que 
area_id na tabela produtos_areas deve corresponder a um id válido na tabela 
areas_armazem .
INSERT INTO ... VALUES ... : Adiciona dados iniciais às tabelas.
Senha: Note o password_hash . Nunca guardamos senhas como texto puro!
Guardamos um “hash”, que é uma versão embaralhada da senha. Quando o
usuário tenta logar, embaralhamos a senha que ele digitou e comparamos os
hashes. O pbkdf2:sha256:... é só um placeholder; usaremos uma biblioteca
Python para gerar hashes seguros de verdade.
 area_id INTEGER NOT NULL, -- Chave estrangeira para a tabela areas_armazem
 produto_catalogo_id INTEGER NOT NULL, -- Chave estrangeira para a tabela produtos_catalogo
 quantidade INTEGER NOT NULL DEFAULT 0,
 data_validade DATE, -- Formato: YYYY-MM-DD
 lote TEXT,
FOREIGN KEY (area_id) REFERENCES areas_armazem (id),
FOREIGN KEY (produto_catalogo_id) REFERENCES produtos_catalogo (id)
);
-- Dados iniciais (opcional, para teste)
-- Inserindo um usuário administrador (senha 'admin' - NUNCA FAÇA ISSO EM PRODUÇÃO REAL)
-- Para gerar um hash seguro, usaríamos bibliotecas Python, aqui é só um exemplo de placeholder
INSERT INTO users (username, password_hash, role) VALUES ('admin', 'pbkdf2:sha256:...', 'admin');
INSERT INTO users (username, password_hash, role) VALUES ('gerente', 'pbkdf2:sha256:...', 
'manager');
-- Inserindo algumas áreas de exemplo
INSERT INTO areas_armazem (nome, descricao) VALUES ('Câmara Fria 01', 
'Produtos que necessitam de refrigeração intensa.');
INSERT INTO areas_armazem (nome, descricao) VALUES ('Prateleira Secos A', 'Produtos não 
perecíveis.');
-- Inserindo alguns produtos no catálogo de exemplo
INSERT INTO produtos_catalogo (nome, tipo, descricao) VALUES ('Iogurte Natural Copo', 'Iogurte', 
'Iogurte natural integral em copo de 170g.');
INSERT INTO produtos_catalogo (nome, tipo, descricao) VALUES ('Queijo Minas Frescal', 'Queijo', 
'Queijo minas frescal artesanal, peça de aproximadamente 500g.');
INSERT INTO produtos_catalogo (nome, tipo, descricao) VALUES ('Leite Integral UHT', 'Leite', 
'Leite longa vida integral, caixa de 1L.');
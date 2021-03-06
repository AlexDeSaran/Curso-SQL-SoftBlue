USE curso_sql;

INSERT INTO funcionarios(nome, salario, departamento)VALUES('Alex', 10000, 'Software Engineer');
INSERT INTO funcionarios(nome, salario, departamento)VALUES('Luisa', 50000, 'Recursos Humanos');
INSERT INTO funcionarios(nome, salario, departamento)VALUES('Inbar Lavi', 30000, 'Administração');
INSERT INTO funcionarios(nome, salario, departamento)VALUES('André Pichebes', 70000, 'Instrutor');
INSERT INTO funcionarios(nome, salario, departamento)VALUES('Leonardo', 15000, 'Web Developer');

SELECT * FROM funcionarios;

SET SQL_SAFE_UPDATES = 0;

UPDATE funcionarios SET salario = salario * 1.1;
UPDATE funcionarios SET departamento = 'Software Engineer' WHERE id = 5;
UPDATE funcionarios SET salario = ROUND(salario * 1.1, 2);

INSERT INTO veiculos(funcionario_id, veiculo, placa)VALUES(1, 'Carro', 'ABC-0001');
INSERT INTO veiculos(funcionario_id, veiculo, placa)VALUES(2, 'MiniVan', 'ABC-0002');
INSERT INTO veiculos(funcionario_id, veiculo, placa)VALUES(1, 'Motocicleta', 'ABC-0003');
INSERT INTO veiculos(funcionario_id, veiculo, placa)VALUES(NULL, 'Van', 'ABC-0004');

UPDATE veiculos SET funcionario_id = 5 WHERE id = 2;
SELECT * FROM veiculos;

INSERT INTO salarios(faixa, inicio, fim)VALUES('Software Engineer',10000, 20000);
INSERT INTO salarios(faixa, inicio, fim)VALUES('Recursos Humanos',1000, 2000);
INSERT INTO salarios(faixa, inicio, fim)VALUES('Instrutor',2000, 3000);

SELECT nome, salario FROM funcionarios;
SELECT nome AS 'Funcionario', salario FROM funcionarios f WHERE f.salario > 20000;
SELECT * FROM funcionarios WHERE nome = 'Alex'
UNION 
SELECT * FROM funcionarios WHERE id =5;
/*5.1*/

SELECT * FROM funcionarios f INNER JOIN veiculos ON funcionario_id = f.id;
SELECT * FROM funcionarios f LEFT JOIN veiculos ON funcionario_id = f.id;
SELECT * FROM funcionarios f RIGHT JOIN veiculos ON funcionario_id = f.id;
SELECT * FROM funcionarios f LEFT JOIN veiculos ON funcionario_id = f.id
UNION
SELECT * FROM funcionarios f RIGHT JOIN veiculos ON funcionario_id = f.id;

INSERT INTO cpfs(id,cpf)VALUES(1,'111.111.111-11');
INSERT INTO cpfs(id,cpf)VALUES(2,'222.222.222-22');
INSERT INTO cpfs(id,cpf)VALUES(3,'333.333.333-33');
INSERT INTO cpfs(id,cpf)VALUES(4,'444.444.444-44');
INSERT INTO cpfs(id,cpf)VALUES(5,'555.555.555-55');

SELECT * FROM cpfs;

SELECT * FROM funcionarios INNER JOIN cpfs ON funcionarios.id = cpfs.id;
SELECT * FROM funcionarios INNER JOIN cpfs USING(id);

INSERT INTO clientes(nome,quem_indicou)VALUES('André', NULL);
INSERT INTO clientes(nome,quem_indicou)VALUES('Mariana', 1);
INSERT INTO clientes(nome,quem_indicou)VALUES('Felipe', 2);
INSERT INTO clientes(nome,quem_indicou)VALUES('Isabela', 3);

SELECT * FROM clientes;

SELECT a.nome AS CLIENTE, b.nome AS INDICADO FROM clientes a JOIN clientes b ON a.quem_indicou = b.id;
SELECT * FROM funcionarios INNER JOIN veiculos ON funcionario_id = funcionarios.id
INNER JOIN cpfs ON cpfs.id = funcionarios.id;

/*CRIAÇÃO DE VISÃO*/
CREATE VIEW funcionarios_salario AS SELECT * FROM funcionarios WHERE salario >= 20000;
SELECT * FROM funcionarios_salario;

SELECT COUNT(*) FROM funcionarios;
SELECT COUNT(*) FROM funcionarios WHERE salario > 20000;
SELECT COUNT(*) FROM funcionarios WHERE salario > 10000 AND departamento ='Software Engineer';

SELECT SUM(salario) FROM funcionarios;
SELECT SUM(salario) FROM funcionarios WHERE departamento = 'Software Engineer';

SELECT AVG(salario) FROM funcionarios;
SELECT AVG(salario) FROM funcionarios WHERE departamento = 'Software Engineer';

SELECT MAX(salario) FROM funcionarios;
SELECT MAX(salario) FROM funcionarios WHERE departamento = 'Software Engineer';

SELECT MIN(salario) FROM funcionarios;
SELECT MIN(salario) FROM funcionarios WHERE departamento = 'Software Engineer';

SELECT departamento FROM funcionarios;
SELECT DISTINCT (departamento) FROM funcionarios;
SELECT * FROM funcionarios ORDER BY nome;
SELECT * FROM funcionarios ORDER BY salario DESC;

SELECT * FROM funcionarios LIMIT 2 OFFSET 1;
SELECT * FROM funcionarios LIMIT 1, 2;

SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento;
SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento HAVING AVG(salario) > 20000;
SELECT departamento, COUNT(*)AS QUANTIDADE FROM funcionarios GROUP BY departamento;

INSERT INTO contas_bancarias(titular,saldo)VALUES ('Alex',10000);
INSERT INTO contas_bancarias(titular,saldo)VALUES ('Luis',20000);

SELECT * FROM contas_bancarias;

/*ASSEGURA QUE A TRANSAÇÃO ESTA PROTEGIDA, O COMMIT CONFIRMA A AÇÃO*/
START TRANSACTION;
UPDATE contas_bancarias SET saldo = saldo - 200 WHERE id = 1;
UPDATE contas_bancarias SET saldo = saldo + 200 WHERE id = 2;
COMMIT;


/*REVERTE A TRANSAÇÃO EM CASO DE ALGUM IMPREVISTO*/
START TRANSACTION;
UPDATE contas_bancarias SET saldo = saldo - 200 WHERE id = 1;
UPDATE contas_bancarias SET saldo = saldo + 200 WHERE id = 2;
ROLLBACK;

INSERT INTO pedidos(descricao,valor)VALUES ('Notebook',4500);
INSERT INTO pedidos(descricao,valor)VALUES ('Console',3500);
INSERT INTO pedidos(descricao,valor)VALUES ('Máquina de Lavar',2500);

SELECT * FROM pedidos;

/*CHAMADA DA STORED PROCEDURES*/
CALL Limpa_Pedidos();

/*CRIAÇAO DE TRIGGER*/
CREATE TRIGGER limpa_pedidos BEFORE INSERT ON estoque FOR EACH ROW
CALL Limpa_Pedidos();

INSERT INTO estoque(descricao,quantidade)VALUES('TV',10);
UPDATE pedidos SET pago = 'Sim' WHERE id = 4;
SELECT * FROM estoque;

/*
Você está desenvolvendo o banco de dados para uma plataforma de cursos online. Um curso
pode ter vários alunos e um aluno pode se matricular em vários cursos. Para representar
esse relacionamento muitos-para-muitos, você deve criar três tabelas:

1. Criação das Tabelas

CREATE TABLE aluno (
  aluno_id INTEGER PRIMARY KEY,
  nome VARCHAR2(50),
  email VARCHAR2(100)
);

CREATE TABLE curso (
  curso_id INTEGER PRIMARY KEY,
  titulo VARCHAR2(100),
  carga_horaria INTEGER
);

CREATE TABLE matricula (
  aluno_id INTEGER,
  curso_id INTEGER,
  data_matricula DATE,
  nota NUMBER(5,2),
  CONSTRAINT pk_matricula PRIMARY KEY (aluno_id, curso_id),
  CONSTRAINT fk_aluno FOREIGN KEY (aluno_id) REFERENCES
  aluno(aluno_id),
  CONSTRAINT fk_curso FOREIGN KEY (curso_id) REFERENCES
  curso(curso_id)
);

2. Inserção de Dados
  Insira os seguintes dados nas tabelas:

Tabela aluno:

INSERT INTO aluno VALUES (1, 'João Silva', 'joao@gmail.com');
INSERT INTO aluno VALUES (2, 'Maria Oliveira', 'maria@yahoo.com');
INSERT INTO aluno VALUES (3, 'Carlos Souza', 'carlos@gmail.com');
INSERT INTO aluno VALUES (4, 'Ana Lima', 'ana@hotmail.com');
INSERT INTO aluno VALUES (5, 'Lucas Pereira', 'lucas@gmail.com');

Tabela curso:

INSERT INTO curso VALUES (101, 'Banco de Dados', 60);
INSERT INTO curso VALUES (102, 'Lógica de Programação', 40);
INSERT INTO curso VALUES (103, 'Estrutura de Dados', 50);

Tabela matricula:

INSERT INTO matricula VALUES (1, 101, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 9.0);
INSERT INTO matricula VALUES (2, 101, TO_DATE('2024-02-12', 'YYYY-MM-DD'), 8.5);
INSERT INTO matricula VALUES (3, 101, TO_DATE('2024-02-14', 'YYYY-MM-DD'), NULL);
INSERT INTO matricula VALUES (3, 102, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 7.0);
INSERT INTO matricula VALUES (4, 102, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 8.0);
INSERT INTO matricula VALUES (4, 103, TO_DATE('2024-03-07', 'YYYY-MM-DD'), 9.5);
INSERT INTO matricula VALUES (5, 103, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 7.8);
INSERT INTO matricula VALUES (1, 103, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 6.5);

3. Questões
*/

-- 1. Liste todos os alunos matriculados no curso de "Banco de Dados".

-- Primeira Escrita, ela é ruim pq depende de saber o id dos cursos.
SELECT a.aluno_id, a.nome, a.email
FROM aluno a
JOIN matricula m ON m.aluno_id = a.aluno_id
WHERE m.curso_id = 101
  
-- Resolução em sala
SELECT a.aluno_id, a.nome, a.email
FROM aluno a
JOIN matricula m ON m.aluno_id = a.aluno_id
JOIN curso c ON m.curso_id = c.curso_id 
WHERE c.titulo = 'Banco de Dados'

-- Junções Proprietárias da ORACLE
SELECT a.aluno_id, a.nome, a.email
FROM aluno a, matricula m, curso c
WHERE m.aluno_id = a.aluno_id AND m.curso_id = c.curso_id  AND c.titulo = 'Banco de Dados'

-- 2. Liste todos os cursos com carga horária maior que 40 horas.

SELECT c.curso_id, c.titulo, c.carga_horaria
FROM curso c
WHERE c.carga_horaria > 40

-- 3. Liste os alunos que ainda não receberam nota.

SELECT a.aluno_id, a.nome, a.email
FROM aluno a
JOIN matricula m ON m.aluno_id = a.aluno_id
WHERE m.nota IS NULL

-- Junções Proprietárias da ORACLE
  
SELECT a.aluno_id, a.nome, a.email
FROM aluno a, matricula m
WHERE m.aluno_id = a.aluno_id AND m.nota IS NULL

-- 4. Liste as matrículas realizadas depois do dia 01/01/2024.
  
SELECT m.aluno_id, m.curso_id, m.data_matricula, m.nota
FROM matricula m
WHERE m.data_matricula > TO_DATE('2024/01/01', 'YYYY-MM-DD')

-- 5. Mostre os cursos com carga horária entre 30 e 60 horas.
  
SELECT c.curso_id, c.titulo, c.carga_horaria
FROM curso c
WHERE c.carga_horaria BETWEEN 30 AND 60

-- 6. Liste os alunos com e-mails do domínio @gmail.com.

SELECT a.aluno_id, a.nome, a.email
FROM aluno a
WHERE email LIKE '%@gmail.com'

-- 7. Liste o nome do aluno, título do curso e data da matrícula.

SELECT a.nome, c.titulo, m.data_matricula
FROM aluno a
JOIN matricula m ON m.aluno_id = a.aluno_id
JOIN curso c ON m.curso_id = c.curso_id

-- Junções Proprietárias da ORACLE

SELECT a.nome, c.titulo, m.data_matricula
FROM aluno a, curso c, matricula m
WHERE m.aluno_id = a.aluno_id AND m.curso_id = c.curso_id

-- 8. Liste os alunos e as notas que receberam em cada curso.

SELECT a.nome, c.titulo, m.nota
FROM aluno a
JOIN matricula m ON m.aluno_id = a.aluno_id
JOIN curso c ON m.curso_id = c.curso_id

-- Junções Proprietárias da ORACLE

SELECT a.nome, c.titulo AS curso , m.nota
FROM aluno a, matricula m, curso c
WHERE m.aluno_id = a.aluno_id AND m.curso_id = c.curso_id

-- 9. Mostre os cursos que o aluno chamado "João Silva" está matriculado.

SELECT c.titulo, m.data_matricula
FROM matricula m
JOIN aluno a ON m.aluno_id = a.aluno_id
JOIN curso c ON m.curso_id = c.curso_id
WHERE a.nome = 'João Silva'

-- Junções Proprietárias da ORACLE
  
SELECT c.titulo, m.data_matricula
FROM matricula m, aluno a, curso c
WHERE m.aluno_id = a.aluno_id AND m.curso_id = c.curso_id AND a.nome = 'João Silva'

-- 10. Liste os títulos dos cursos que possuem mais de um aluno matriculado.

SELECT c.titulo, COUNT(*) AS qtd
FROM curso c
JOIN matricula m ON c.curso_id = m.curso_id
GROUP BY c.titulo HAVING COUNT(*) > 1

-- Junções Proprietárias da ORACLE
  
SELECT c.titulo, COUNT(*) AS qtd
FROM curso c, matricula m
WHERE c.curso_id = m.curso_id
GROUP BY c.titulo HAVING COUNT(*) > 1

-- 11. Mostre todos os alunos sem matrícula em nenhum curso.

SELECT a.aluno_id, a.nome, a.email
FROM aluno a
WHERE aluno_id NOT IN (SELECT DISTINCT aluno_id FROM matricula)

-- 12. Mostre os cursos sem nenhum aluno matriculado.

SELECT c.curso_id, c.titulo, c.carga_horaria
FROM curso c
WHERE c.curso_id NOT IN (SELECT DISTINCT curso_id FROM matricula)

-- 13. Liste os nomes dos alunos e a quantidade de cursos em que estão matriculados.

SELECT a.nome, COUNT(m.curso_id) AS cursos_matriculados 
FROM aluno a 
LEFT JOIN matricula m ON a.aluno_id = m.aluno_id 
GROUP BY a.nome;

-- Junções Proprietárias da ORACLE

SELECT a.nome, COUNT(m.curso_id) AS cursos_matriculados 
FROM aluno a, matricula m
WHERE a.aluno_id = m.aluno_id 
GROUP BY a.nome;

-- 14. Calcule a nota média de todos os alunos.

SELECT AVG(nota) AS media_geral 
FROM matricula 
WHERE nota IS NOT NULL;

-- 15. Calcule a média da nota por curso.

SELECT c.titulo, AVG(m.nota) AS media 
FROM curso c 
JOIN matricula m ON c.curso_id = m.curso_id 
WHERE m.nota IS NOT NULL 
GROUP BY c.titulo;

-- Junções Proprietárias da ORACLE

SELECT c.titulo, AVG(m.nota) AS media 
FROM curso c, matricula m
WHERE c.curso_id = m.curso_id AND m.nota IS NOT NULL 
GROUP BY c.titulo;

-- 16. Encontre a maior nota registrada.

SELECT MAX(nota) AS maior_nota 
FROM matricula;

-- 17. Mostre o aluno com a menor nota.

SELECT a.nome, m.nota 
FROM aluno a 
JOIN matricula m ON a.aluno_id = m.aluno_id 
WHERE m.nota = (SELECT MIN(nota) FROM matricula WHERE nota IS NOT NULL);

-- Junções Proprietárias da ORACLE

SELECT a.nome, m.nota 
FROM aluno a, matricula m
WHERE a.aluno_id = m.aluno_id AND m.nota = (SELECT MIN(nota) FROM matricula WHERE nota IS NOT NULL);

-- 18. Mostre a quantidade total de matrículas por curso.

SELECT c.titulo, COUNT(m.aluno_id) AS total_matriculas 
FROM curso c 
LEFT JOIN matricula m ON c.curso_id = m.curso_id 
GROUP BY c.titulo;

-- Junções Proprietárias da ORACLE

SELECT c.titulo, COUNT(m.aluno_id) AS total_matriculas 
FROM curso c, matricula m
WHERE c.curso_id = m.curso_id 
GROUP BY c.titulo;

-- 19. Liste os alunos com média de nota maior ou igual a 8.0.

SELECT a.nome, AVG(m.nota) AS media 
FROM aluno a 
JOIN matricula m ON a.aluno_id = m.aluno_id 
WHERE m.nota IS NOT NULL 
GROUP BY a.nome HAVING AVG(m.nota) >= 8.0;

-- Junções Proprietárias da ORACLE

SELECT a.nome, AVG(m.nota) AS media 
FROM aluno a, matricula m
WHERE a.aluno_id = m.aluno_id AND m.nota IS NOT NULL 
GROUP BY a.nome HAVING AVG(m.nota) >= 8.0;

-- 20. Mostre a média, menor e maior nota por curso.

SELECT c.titulo, AVG(m.nota) AS media, MIN(m.nota) AS menor, MAX(m.nota) AS maior
FROM matricula m
JOIN curso c ON m.curso_id = c.curso_id
WHERE m.nota IS NOT NULL
GROUP BY c.titulo

-- Junções Proprietárias da ORACLE

SELECT c.titulo, AVG(m.nota) AS media, MIN(m.nota) AS menor, MAX(m.nota) AS maior
FROM matricula m, curso c  
WHERE m.curso_id = c.curso_id AND m.nota IS NOT NULL
GROUP BY c.titulo

-- Parte 1 – Recuperando Dados (Seção 1)
-- Objetivo: Utilizar comandos SELECT para exibir dados completos ou parciais de uma tabela.

-- 1. Exiba todos os dados cadastrados na tabela de clientes.

SELECT *
FROM cliente

-- 2. Exiba apenas os nomes e as cidades dos clientes.
  
SELECT cliente_nome, cidade
FROM cliente

-- 3. Liste todas as contas registradas, exibindo o número da conta e o saldo.

SELECT conta_numero, saldo
FROM conta

-- Parte 2 – Filtros, Projeções e Concatenação (Seção 2)
-- Objetivo: Trabalhar com cláusula WHERE, operadores BETWEEN, LIKE, IN, operadores de concatenação (||) e alias.

-- 4. Liste os nomes dos clientes da cidade de Macaé.

SELECT cliente_nome
FROM cliente
WHERE cidade = 'Macaé'

-- 5. Exiba o código e o nome de todos os clientes com código entre 5 e 15.

SELECT cliente_cod, cliente_nome
FROM cliente
WHERE cliente_cod BETWEEN 5 AND 15

-- 6. Exiba os clientes que moram em Niterói, Volta Redonda ou Itaboraí.
  
-- utilizando OR
SELECT cliente_nome
FROM cliente
WHERE cidade = 'Niterói' OR cidade = 'Volta Redonda' OR cidade = 'Itaboraí'

-- utilizando IN
SELECT cliente_nome
FROM cliente
WHERE cidade IN ('Niterói', 'Volta Redonda', 'Itaboraí');

-- 7. Exiba os nomes dos clientes que começam com a letra "F".

SELECT cliente_nome
FROM cliente
WHERE cliente_nome LIKE 'F%'

-- 8. Exiba uma frase com a seguinte estrutura para todos os clientes: 'João Santos mora em Nova Iguaçu.'
-- Utilize concatenação e alias para nomear a coluna como "Frase".

SELECT cliente_nome || ' mora em '  || cidade As Frase
FROM cliente

-- Parte 3 – Ordenações, Operadores Lógicos e Funções (Seção 3)
-- Objetivo: Utilizar ORDER BY, operadores lógicos (AND, OR, NOT) e funções de linha única (ROUND, UPPER, etc.).

-- 9. Exiba os dados de todas as contas com saldo superior a R$ 9.000, ordenados do maior para o menor saldo.
  
SELECT *
FROM conta 
WHERE Saldo > 9000
ORDER BY saldo

-- 10. Liste os clientes que moram em Nova Iguaçu ou que tenham "Silva" no nome.

SELECT *
FROM cliente
WHERE cidade = 'Nova Iguaçu' OR cliente_nome LIKE '%Silva%'

-- 11. Exiba o saldo das contas com arredondamento para o inteiro mais próximo.

SELECT conta_numero, ROUND(saldo, 0) AS saldo
FROM conta

-- 12. Exiba o nome de todos os clientes em letras maiúsculas.

SELECT UPPER(cliente_nome)
FROM cliente

-- 13. Exiba os nomes dos clientes que não são das cidades de Teresópolis nem Campos dos Goytacazes.

SELECT cliente_nome, cidade
FROM cliente
WHERE cidade != 'Teresópolis' or cidade != 'Campos dos Goytacazes'

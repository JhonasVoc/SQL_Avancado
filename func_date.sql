-- funções de data são muito importante para realizar consultas

SELECT curdate();

SELECT current_time();

SELECT DAY("2017-06-15");

SELECT MONTH("2017-06-15");

SELECT YEAR(CURRENT_TIMESTAMP());

SELECT MONTH(CURRENT_TIMESTAMP());

SELECT DAY(CURRENT_TIMESTAMP());

SELECT DATEDIFF(CURRENT_TIMESTAMP(), '2019-01-01') AS RESULTADO;


SELECT DATEDIFF(CURRENT_TIMESTAMP(), '1999-07-13') AS RESULTADO;


SELECT DISTINCT DATA_VENDA FROM NOTAS_FISCAIS;

SELECT DISTINCT DATA_VENDA,
DAYNAME(DATA_VENDA) AS DIA, MONTHNAME(DATA_VENDA) AS MES, YEAR(DATA_VENDA) AS ANO FROM NOTAS_FISCAIS;

-- Crie uma consulta que mostre o nome e a idade atual dos clientes.
SELECT NOME, TIMESTAMPDIFF (YEAR, DATA_DE_NASCIMENTO, CURDATE()) AS    IDADE
FROM  tabela_de_clientes;
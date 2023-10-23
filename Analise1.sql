-- Vamos avaliar vendas válidas
-- VOLUME(QUANTIDADE) DE COMPRAR É O MAXIMO QUE UM CLIENTE PODE COMPRAR ( EM L )
-- precisamos encontrar a quantidade de comprada por cliente em um mes, 
SELECT * FROM itens_notas_fiscais;

SELECT * FROM NOTAS_FISCAIS;

SELECT
	NF.CPF, date_format(NF.DATA_VENDA,'%Y-%m'),
    (I.QUANTIDADE) AS QUANTIDADE_VENDAS
FROM
	NOTAS_FISCAIS NF
JOIN	
	ITENS_NOTAS_FISCAIS I ON I.NUMERO = NF.NUMERO;
-- COM GROUP BY E SUMANDO QUANTIDADE
-- 
SELECT
	CPF, date_format(NF.DATA_VENDA,'%Y-%m') AS MES_ANO
    , SUM(I.QUANTIDADE) AS QUANTIDADE_VENDAS
FROM
	NOTAS_FISCAIS NF
JOIN	
	ITENS_NOTAS_FISCAIS I ON I.NUMERO = NF.NUMERO
GROUP BY
	NF.CPF, date_format(NF.DATA_VENDA,'%Y-%m');
    
/* LIMITE DE COMPRA POR CLIENTE */
SELECT * FROM tabela_de_clientes tc;
SELECT TC.CPF, TC.NOME,TC.VOLUME_DE_COMPRA AS QUANTIDADE_LIMITE
FROM tabela_de_clientes TC;

/* PRECISAMOS COMPARA ESSA TABELA COM A TABELA DE VENDS REALIZADA*/
/* NECESSARIO COLCOAR FUNÇÃO NO CAMPO, PARA AGRUPAR CERTO*/
SELECT
	NF.CPF,TC.NOME, date_format(NF.DATA_VENDA,'%Y-%m') AS MES_ANO
    , SUM(I.QUANTIDADE) AS QUANTIDADE_VENDAS,
    MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_LIMITE
FROM
	NOTAS_FISCAIS NF
JOIN	
	ITENS_NOTAS_FISCAIS I ON I.NUMERO = NF.NUMERO
JOIN 
	tabela_de_clientes TC ON TC.CPF = NF.CPF
GROUP BY
	NF.CPF, TC.NOME,
    date_format(NF.DATA_VENDA,'%Y-%m');

/* precisamos formatar ou calcular essa consulta apra dizer se a compara foi ou não válida*/
SELECT
	X.CPF,X.NOME,X.MES_ANO, X.QUANTIDADE_VENDAS, X.QUANTIDADE_LIMITE,
    X.QUANTIDADE_LIMITE - X.QUANTIDADE_VENDAS AS DIFERENCA,
    CASE WHEN (X.QUANTIDADE_LIMITE - X.QUANTIDADE_VENDAS) < 0 THEN 'INVÁLIDA'
    ELSE 'VÁLIDA' END AS STATUS_VENDA
FROM
	(SELECT 
		NF.CPF,TC.NOME, date_format(NF.DATA_VENDA,'%Y-%m') AS MES_ANO
		, SUM(I.QUANTIDADE) AS QUANTIDADE_VENDAS,
		MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_LIMITE
	FROM
		NOTAS_FISCAIS NF
	JOIN	
		ITENS_NOTAS_FISCAIS I ON I.NUMERO = NF.NUMERO
	JOIN 
		tabela_de_clientes TC ON TC.CPF = NF.CPF
	GROUP BY
		NF.CPF, TC.NOME,
		date_format(NF.DATA_VENDA,'%Y-%m')) X;

	
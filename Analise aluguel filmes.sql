/* -------------- ANALISE DOS DADOS  ------------------*/

-- Quantidade de filmes por genero
CREATE VIEW filmes_por_genero AS
SELECT
	genero,
	COUNT(id_filme) AS qtd_filmes,
	ROUND(AVG(preco_aluguel),2) AS preco_medio-- comando para pesquisar a media dos precos
    
FROM filmes -- comando para informar a tabela a ser analisada
GROUP BY 1 -- comando para agrupar os dados (neste caso ele ira agrupar por genero)
ORDER BY 3 DESC -- Ordernar a tabela do maior preco medio ao menor, podemos informar tanto pela ordem ou o nome da coluna
LIMIT 1000; -- o comando LIMIT, limita a busca tornando-a mais performatica.


-- Qual o genero de filmes mais alugado no ano de 2019
CREATE VIEW filmes_alugados AS
SELECT
	
    filmes.genero,
    COUNT(id_aluguel) AS qtd_filmes_alugados
    
FROM alugueis INNER JOIN filmes
ON alugueis.id_filme = filmes.id_filme
WHERE (data_aluguel BETWEEN'2019/01/01'AND '2019/12/31')
GROUP BY 1
ORDER BY 2 DESC;

SELECT * FROM filmes_alugados;

-- Quais os 5 filmes tiveram nota acima da media no ano de 2019
CREATE VIEW filmes_acima_media AS
SELECT
	filmes.titulo,
	filmes.genero,
    nota

FROM alugueis INNER JOIN filmes
ON alugueis.id_filme = filmes.id_filme
WHERE (data_aluguel BETWEEN'2019/01/01'AND '2019/12/31') AND nota > (SELECT AVG(nota) FROM alugueis)-- Subconsulta para buscar somente os filmes acima da média 
ORDER BY nota DESC
LIMIT 5;


/*--------- Analise de faturamento --------*/
-- Quanto faturou no ano de 2019 por genero
CREATE VIEW faturamento_2019 AS
SELECT
    filmes.genero,
    COUNT(id_aluguel) AS qtd_filmes_alugados,
	ROUND(SUM(filmes.preco_aluguel),2) AS soma
    
FROM 
	alugueis INNER JOIN filmes
	ON alugueis.id_filme = filmes.id_filme
WHERE data_aluguel BETWEEN '2019/01/01'AND '2019/12/31'
GROUP BY 1
ORDER BY 2 DESC;

SELECT
    genero,
    qtd_filmes_alugados,
    (qtd_filmes_alugados*soma) AS faturamento

FROM faturamento_2019;
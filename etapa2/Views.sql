-- Quais e quantos veículos foram locados por mês?

CREATE VIEW qtd_veic_mes AS
SELECT v.modelo AS Modelo, 
date_part('month', l.datalocacao) AS Mes, date_part('year', datalocacao) AS Ano, COUNT(l.*) AS Total FROM Relacional.veiculos v
JOIN Relacional.locacao l ON (l.idveiculo = v.idveiculo)
GROUP BY v.modelo, date_part('month', l.datalocacao), date_part('year', datalocacao)
ORDER BY Mes desc;



-- Quais despachantes locaram quais veículos por mês?

CREATE VIEW desp_veic_mes AS
SELECT v.modelo AS Modelo, date_part('month', l.datalocacao) AS Mes, date_part('year', datalocacao) AS Ano, COUNT(l.*) AS Total, d.nome AS Nome FROM Relacional.veiculos v
JOIN Relacional.locacao l ON (l.idveiculo = v.idveiculo)
JOIN Relacional.despachantes d ON (l.iddespachante = d.iddespachante)
GROUP BY v.modelo, date_part('month', l.datalocacao), date_part('year', datalocacao), d.nome
ORDER BY Mes desc;



--Qual o faturamento por veículo por mês?

CREATE VIEW fatura_veic_mes AS
SELECT v.modelo AS Modelo, SUM(l.valortotal) AS ValorTotal, date_part('month', l.datalocacao) AS Mes, date_part('year', datalocacao) AS Ano FROM Relacional.veiculos v
JOIN Relacional.locacao l ON (l.idveiculo = v.idveiculo)
GROUP BY v.modelo, date_part('month', l.datalocacao), date_part('year', datalocacao)
ORDER BY ValorTotal desc;




-- Qual o faturamento por despachante por mês?

CREATE VIEW fatura_desp_mes AS
SELECT d.nome AS Nome, SUM(l.valortotal) AS ValorTotal, date_part('month', l.datalocacao) AS Mes, date_part('year', datalocacao) AS Ano FROM Relacional.despachantes d
JOIN relacional.locacao l ON (l.iddespachante = d.iddespachante)
GROUP BY d.nome, date_part('month', l.datalocacao), date_part('year', datalocacao)
ORDER BY Valortotal desc;

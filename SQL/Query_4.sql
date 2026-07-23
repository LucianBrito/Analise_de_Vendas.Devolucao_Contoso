USE CONTOSORETAILDW;
-- Query 2: Análise de devoluções por canal
SELECT 
    c.ChannelName,
    SUM(fs.SalesAmount) AS FaturamentoTotal,
    SUM(fs.ReturnAmount) AS TotalDevolucoes,
    ROUND(
        (SUM(fs.ReturnAmount) / NULLIF(SUM(fs.SalesAmount), 0)) * 100, 
        2
    ) AS TaxaDevolucaoPct
FROM dbo.FactSales fs
INNER JOIN dbo.DimChannel c 
    ON fs.channelKey = c.ChannelKey
GROUP BY c.ChannelName
HAVING SUM(fs.SalesAmount) > 0
ORDER BY TaxaDevolucaoPct DESC;

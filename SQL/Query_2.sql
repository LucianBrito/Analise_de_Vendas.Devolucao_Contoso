USE ContosoRetailDW

-- Com ranking (Usando Window Function)

SELECT
    dc.ChannelName                              AS Canal,
    SUM(fs.SalesAmount)                         AS FaturamentoTotal,
    SUM(fs.ReturnAmount)                        AS DevolucaoTotal,
    (SUM(fs.ReturnAmount) * 100.0) / NULLIF(SUM(fs.SalesAmount), 0) AS PercDevolucao,
    RANK() OVER (ORDER BY SUM(fs.SalesAmount) DESC) AS Ranking
FROM
    FactSales       AS fs
    INNER JOIN DimChannel   AS dc ON fs.channelKey = dc.ChannelKey
    INNER JOIN DimDate      AS dd ON fs.DateKey    = dd.DateKey
WHERE
    dd.CalendarYear BETWEEN 2007 AND 2009
GROUP BY
    dc.ChannelName
ORDER BY
    Ranking;

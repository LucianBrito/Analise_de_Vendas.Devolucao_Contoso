-- Query 6: Faturamento por país e canal
SELECT 
    g.RegionCountryName AS Pais,
    c.ChannelName,
    COUNT(DISTINCT fs.SalesOrderNumber) AS TotalPedidos,
    SUM(fs.SalesAmount) AS FaturamentoTotal,
    ROUND(
        SUM(fs.SalesAmount) / NULLIF(
            SUM(SUM(fs.SalesAmount)) OVER (PARTITION BY c.ChannelName), 0
        ) * 100, 
        2
    ) AS ParticipacaoNoCanal
FROM dbo.FactSales fs
INNER JOIN dbo.DimStore s 
    ON fs.StoreKey = s.StoreKey
INNER JOIN dbo.DimGeography g 
    ON s.GeographyKey = g.GeographyKey
INNER JOIN dbo.DimChannel c 
    ON fs.channelKey = c.ChannelKey
GROUP BY 
    g.RegionCountryName,
    c.ChannelName
ORDER BY 
    c.ChannelName,
    FaturamentoTotal DESC;

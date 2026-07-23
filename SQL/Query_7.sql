-- Query 5: Ticket médio por canal ao longo dos anos
SELECT 
    d.CalendarYear,
    c.ChannelName,
    SUM(fs.SalesAmount) AS FaturamentoTotal,
    SUM(fs.SalesQuantity) AS TotalItens,
    ROUND(
        SUM(fs.SalesAmount) / NULLIF(SUM(fs.SalesQuantity), 0), 
        2
    ) AS TicketMedio
FROM dbo.FactSales fs
INNER JOIN dbo.DimDate d 
    ON fs.DateKey = d.Datekey
INNER JOIN dbo.DimChannel c 
    ON fs.channelKey = c.ChannelKey
GROUP BY 
    d.CalendarYear,
    c.ChannelName
ORDER BY 
    d.CalendarYear,
    TicketMedio DESC;

USE ContosoRetailDW
-- Query 3: Série temporal mensal por canal
SELECT 
    d.CalendarYear,
    d.CalendarMonth,
    d.CalendarMonthLabel AS MonthName,
    c.ChannelName,
    SUM(fs.SalesAmount) AS FaturamentoMensal
FROM dbo.FactSales fs
INNER JOIN dbo.DimDate d 
    ON fs.DateKey = d.Datekey
INNER JOIN dbo.DimChannel c 
    ON fs.channelKey = c.ChannelKey
WHERE d.CalendarYear IN (2007, 2008, 2009)
GROUP BY 
    d.CalendarYear,
    d.CalendarMonth,
    d.CalendarMonthLabel,
    c.ChannelName
ORDER BY 
    d.CalendarYear,
    d.CalendarMonth,
    FaturamentoMensal DESC;

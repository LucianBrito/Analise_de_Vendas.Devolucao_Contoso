-- Query 7: Ranking dos meses com maior taxa de devolução
SELECT TOP 12
    d.CalendarYear,
    d.MonthName,
    SUM(fs.SalesAmount) AS FaturamentoMensal,
    SUM(fs.ReturnAmount) AS DevolucoesMensais,
    ROUND(
        (SUM(fs.ReturnAmount) / NULLIF(SUM(fs.SalesAmount), 0)) * 100, 
        2
    ) AS TaxaDevolucaoPct
FROM dbo.FactSales fs
INNER JOIN dbo.DimDate d 
    ON fs.DateKey = d.Datekey
GROUP BY 
    d.CalendarYear,
    d.CalendarMonth,
    d.MonthName
HAVING SUM(fs.SalesAmount) > 0
ORDER BY TaxaDevolucaoPct DESC;

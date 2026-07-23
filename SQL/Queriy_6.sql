-- Query 4: Top categorias com maior taxa de devolução
SELECT TOP 10
    pc.ProductCategoryName,
    SUM(fs.SalesAmount) AS FaturamentoCategoria,
    SUM(fs.ReturnAmount) AS DevolucoesCategoria,
    ROUND(
        (SUM(fs.ReturnAmount) / NULLIF(SUM(fs.SalesAmount), 0)) * 100, 
        2
    ) AS TaxaDevolucaoPct,
    SUM(fs.ReturnQuantity) AS QtdItensDevolvidos
FROM dbo.FactSales fs
INNER JOIN dbo.DimProduct p 
    ON fs.ProductKey = p.ProductKey
INNER JOIN dbo.DimProductSubcategory psc 
    ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey
INNER JOIN dbo.DimProductCategory pc 
    ON psc.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY pc.ProductCategoryName
HAVING SUM(fs.SalesAmount) > 0
ORDER BY TaxaDevolucaoPct DESC;

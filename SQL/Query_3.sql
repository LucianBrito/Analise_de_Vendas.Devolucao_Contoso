USE ContosoRetailDW

-- Top 10 produtos mais vendidos em cada canal
-- INSIGHT: Identificar campeões de venda e vilões de devolução
--          "Será que o produto mais vendido é também o mais devolvido?"


WITH VendasPorProduto AS (
    SELECT
        dc.ChannelName                              AS Canal,
        dp.ProductName                              AS Produto,
        SUM(fs.SalesAmount)                         AS Faturamento,
        SUM(fs.ReturnAmount)                        AS Devolucao,
        (SUM(fs.ReturnAmount) * 100.0) / NULLIF(SUM(fs.SalesAmount), 0) AS PercDevolucao,
        -- Numera cada produto dentro do seu canal por faturamento
        ROW_NUMBER() OVER (
            PARTITION BY dc.ChannelName
            ORDER BY SUM(fs.SalesAmount) DESC
        )                                           AS PosicaoRanking
    FROM
        FactSales               AS fs
        INNER JOIN DimChannel   AS dc  ON fs.channelKey  = dc.ChannelKey
        INNER JOIN DimDate      AS dd  ON fs.DateKey     = dd.DateKey
        INNER JOIN DimProduct   AS dp  ON fs.ProductKey  = dp.ProductKey
    WHERE
        dd.CalendarYear BETWEEN 2007 AND 2009
    GROUP BY
        dc.ChannelName,
        dp.ProductName
)
SELECT
    Canal,
    Produto,
    Faturamento,
    Devolucao,
    PercDevolucao,
    PosicaoRanking
FROM
    VendasPorProduto
WHERE
    PosicaoRanking <= 10                -- Apenas os 10 primeiros de cada canal
ORDER BY
    Canal,
    PosicaoRanking;

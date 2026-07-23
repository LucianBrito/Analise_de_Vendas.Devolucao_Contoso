USE CONTOSORETAILDW;
SELECT
    -- Nome do canal vindo da dimensão
    dc.ChannelName                              AS Canal,

    -- Faturamento total (soma das vendas brutas)
    SUM(fs.SalesAmount)                         AS FaturamentoTotal,

    -- Total de devoluções (soma dos valores devolvidos)
    SUM(fs.ReturnAmount)                        AS DevolucaoTotal,

    -- Percentual de devolução sobre o faturamento
    -- Multiplica por 100.0 (com decimal) para evitar divisão inteira
    (SUM(fs.ReturnAmount) * 100.0) / NULLIF(SUM(fs.SalesAmount), 0) AS PercDevolucao

FROM
    FactSales       AS fs
    INNER JOIN DimChannel   AS dc ON fs.channelKey = dc.ChannelKey   -- Traz o nome do canal
    INNER JOIN DimDate      AS dd ON fs.DateKey    = dd.DateKey      -- Para filtrar por ano

WHERE
    dd.CalendarYear BETWEEN 2007 AND 2009         -- Somente o período solicitado

GROUP BY
    dc.ChannelName                                -- Agrupa os dados por canal

ORDER BY
    FaturamentoTotal DESC;                        -- Do maior para o menor faturamento

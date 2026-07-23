
-- 1. Faturamento
Faturamento Total = SUM(FactSales[SalesAmount])
Faturamento Liquido = SUMX(FactSales, FactSales[SalesAmount] - FactSales[ReturnAmount])

-- 2. Devoluções
Total Devolucoes = SUM(FactSales[ReturnAmount])
Devolucoes YTD = TOTALYTD(SUM(FactSales[ReturnAmount]), DimDate[DateKey])

-- 3. Percentual
% Devolucao = DIVIDE(SUM(FactSales[ReturnAmount]), SUM(FactSales[SalesAmount]), 0)

-- 4. Ticket Médio
Ticket Medio = DIVIDE(SUM(FactSales[SalesAmount]), DISTINCTCOUNT(FactSales[SalesKey]), 0)
Ticket Medio vs Media Geral = 
VAR TicketCanal = DIVIDE(SUM(FactSales[SalesAmount]), DISTINCTCOUNT(FactSales[SalesKey]), 0)
VAR TicketGeral = CALCULATE(
    DIVIDE(SUM(FactSales[SalesAmount]), DISTINCTCOUNT(FactSales[SalesKey]), 0),
    ALL(FactSales)
)
RETURN DIVIDE(TicketCanal, TicketGeral, 0) - 1

# 📊 Análise de Performance por Canal de Vendas — Contoso Retail

![SQL Server](https://img.shields.io/badge/SQL%20Server-2019-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=power-bi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-FFB900?style=for-the-badge&logo=power-bi&logoColor=black)
![Star Schema](https://img.shields.io/badge/Modelagem-Star%20Schema-6C5CE7?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Concluído-27AE60?style=for-the-badge)

---

## 🧩 Descrição do Problema de Negócio

> *"Preciso entender por qual canal a empresa vende mais e onde estamos perdendo com devoluções. Quero ver Store, Online, Reseller e Catalog. Você consegue montar um painel com isso até sexta?"*

A **Contoso Retail** opera em múltiplos canais de venda, mas a diretoria comercial não tinha visibilidade consolidada sobre:

- Qual canal gera mais receita
- Qual canal apresenta maior taxa de devolução
- Como esses indicadores evoluem ao longo do tempo

Sem essa clareza, decisões estratégicas — como alocação de verba de marketing, expansão de canais e políticas de logística reversa — eram tomadas com base em percepções, não em dados.

---

## 🎯 Objetivo da Análise

Identificar o canal de maior faturamento e a categoria com maior taxa de devolução para embasar a estratégia comercial da Contoso Retail, entregando um dashboard executivo em **3 páginas** voltado ao diretor comercial.

---

## 🛠️ Ferramentas e Tecnologias

| Ferramenta | Versão | Finalidade |
|------------|--------|------------|
| **SQL Server** | 2019 | Consulta e extração dos dados transacionais |
| **Power BI** | 2023 (Desktop) | Modelagem, visualização e publicação do dashboard |
| **DAX** | — | Criação de medidas analíticas e indicadores de negócio |
| **GitHub** | — | Versionamento e documentação do projeto |

---

## 🗄️ Estrutura do Banco de Dados

A base utilizada foi a **ContosoRetailDW**, um data warehouse de varejo da Microsoft, hospedada em `2.24.101.13,1433`.

### 1. Tabelas Utilizadas

#### 📦 Tabelas Fato

| Tabela | Descrição | Colunas Principais | Significado |
|--------|-----------|--------------------|-------------|
| `dbo.FactSales` | Registro de cada transação de venda realizada | `SalesAmount` | Valor bruto da venda (R$) |
| | | `SalesQuantity` | Quantidade de itens vendidos |
| | | `ReturnAmount` | Valor devolvido na transação (R$) |
| | | `ReturnQuantity` | Quantidade de itens devolvidos |
| | | `TotalCost` | Custo total da mercadoria vendida |
| | | `DateKey` | Chave estrangeira para a dimensão de data |
| | | `channelKey` | Chave estrangeira para a dimensão de canal |
| | | `ProductKey` | Chave estrangeira para a dimensão de produto |
| | | `StoreKey` | Chave estrangeira para a dimensão de loja |

| Tabela | Descrição | Colunas Principais | Significado |
|--------|-----------|--------------------|-------------|
| `dbo.FactOnlineSales` | Transações do canal de vendas online | (Estrutura similar a FactSales) | Vendas exclusivas do canal online |

#### 🏷️ Tabelas Dimensão

| Tabela | Descrição | Colunas Principais | Significado |
|--------|-----------|--------------------|-------------|
| `dbo.DimChannel` | Canais de venda disponíveis | `ChannelKey` | Identificador único do canal (PK) |
| | | `ChannelName` | Nome do canal (Store, Online, Reseller, Catalog) |
| | | `ChannelCategory` | Categoria agregadora do canal |
| | **Tipo:** Dimensão | | |
| `dbo.DimDate` | Calendário completo para análise temporal | `DateKey` | Identificador único da data (PK) |
| | | `FullDateLabel` | Data no formato `dd/mm/aaaa` |
| | | `CalendarYear` | Ano calendário (2007, 2008, 2009) |
| | | `CalendarMonth` | Número do mês (1 a 12) |
| | | `MonthName` | Nome do mês (Janeiro, Fevereiro...) |
| | | `CalendarQuarter` | Trimestre (Q1, Q2, Q3, Q4) |
| | | `DayOfWeek` | Dia da semana em português |
| | **Tipo:** Dimensão | | |
| `dbo.DimProduct` | Catálogo de produtos | `ProductKey` | Identificador único do produto (PK) |
| | | `ProductName` | Nome do produto |
| | | `ProductSubcategoryKey` | Chave para a subcategoria |
| | **Tipo:** Dimensão | | |
| `dbo.DimProductSubcategory` | Subcategorias de produtos | `ProductSubcategoryKey` | Identificador único da subcategoria (PK) |
| | | `ProductSubcategoryName` | Nome da subcategoria |
| | | `ProductCategoryKey` | Chave para a categoria |
| | **Tipo:** Dimensão | | |
| `dbo.DimProductCategory` | Categorias de produto | `ProductCategoryKey` | Identificador único da categoria (PK) |
| | | `ProductCategoryName` | Nome da categoria (Audio, TV, PCs, etc.) |
| | **Tipo:** Dimensão | | |
| `dbo.DimStore` | Lojas físicas | `StoreKey` | Identificador único da loja (PK) |
| | | `StoreName` | Nome fantasia da loja |
| | | `StoreType` | Tipo de loja (Flagship, Regular, Outlet) |
| | | `GeographyKey` | Chave para localização geográfica |
| | **Tipo:** Dimensão | | |
| `dbo.DimGeography` | Localização geográfica | `GeographyKey` | Identificador único (PK) |
| | | `RegionCountryName` | País (Brasil, EUA, etc.) |
| | | `StateProvinceName` | Estado/Província |
| | | `CityName` | Cidade |
| | **Tipo:** Dimensão | | |

### 2. Relacionamentos

 Tabela de Relacionamentos

| Tabela Fato | Chave Estrangeira | Tabela Dimensão | Chave Primária | Cardinalidade |
|-------------|-------------------|-----------------|----------------|:---:|
| `FactSales` | `DateKey` | `DimDate` | `DateKey` | N:1 |
| `FactSales` | `channelKey` | `DimChannel` | `ChannelKey` | N:1 |
| `FactSales` | `ProductKey` | `DimProduct` | `ProductKey` | N:1 |
| `FactSales` | `StoreKey` | `DimStore` | `StoreKey` | N:1 |
| `DimProduct` | `ProductSubcategoryKey` | `DimProductSubcategory` | `ProductSubcategoryKey` | N:1 |
| `DimProductSubcategory` | `ProductCategoryKey` | `DimProductCategory` | `ProductCategoryKey` | N:1 |
| `DimStore` | `GeographyKey` | `DimGeography` | `GeographyKey` | N:1 |

### 3. Modelo no Power BI

O modelo adotado segue o padrão **Star Schema** (Esquema Estrela), com `FactSales` no centro e as dimensões ao redor.

<img src="https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Modelo_de_Dados.png?raw=true">

#### Decisões de Modelagem

| Decisão | Justificativa |
|---------|---------------|
| **Star Schema** em vez de tabela única (flat) | Performance de consulta superior, clareza semântica e manutenção mais simples no DAX |
| `FactSales` e `FactOnlineSales` **não unificadas** | O modelo original separa as tabelas. Para o dashboard, as medidas DAX somam os valores de ambas quando necessário |
| Dimensão de produto com **hierarquia em floco de neve (snowflake)** | Categoria → Subcategoria → Produto permite drill-down natural nos gráficos. O Power BI gerencia bem esse nível de normalização |
| **Desabilitação de Auto Date/Time** | `DimDate` foi usada como dimensão de data personalizada, e a opção "Data/Hora Automática" foi desativada para evitar tabelas de data ocultas que poluem o modelo |
| Relacionamentos com **direção de filtro única** (Dim → Fact) | Evita filtragem acidental reversa; todas as medidas usam `CALCULATE` + `FILTER` quando necessário |

---

## 🔍 Consultas SQL Utilizadas

As queries abaixo foram executadas no **SQL Server Management Studio** para validar os dados antes da importação para o Power BI e para análises exploratórias.

### 1. Faturamento Total por Canal

# Propósito: Identificar qual canal gera mais receita e quantificar a participação de cada um.
<img src="https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Query_1.png?raw=true">

<img src="https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Resultado_Query_1.png?raw=true">

### 2. Taxa de Devolução por Canal

Propósito: Identificar qual canal tem maior taxa de devolução em relação ao faturamento.

<img src="https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Devolu%C3%A7%C3%A3o%20por%20Canal.png?raw=true">

### 3. Evolução Mensal do Faturamento por Canal

Propósito: Analisar a sazonalidade e tendências de crescimento de cada canal ao longo do tempo.

<image src="https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Serie%20temporal%20mensal%20por%20ano.png?raw=true">

### 4. Ranking de Categorias com Maior Taxa de Devolução

Propósito: Identificar quais categorias de produto têm maior taxa de devolução para direcionar ações de qualidade ou melhoria de descrição.

<image src="https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Categoria%20com%20a%20maior%20taxa%20de%20devolu%C3%A7%C3%A3o.png?raw=true">

### 5. Ticket Médio por Canal e Ano

Propósito: Comparar o valor médio por item entre canais e identificar tendências de crescimento ou queda.

<image src="https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Ticket%20medio%20por%20ano%20e%20canal.png?raw=true">

### 6. Análise Geográfica por Canal

Propósito: Entender a distribuição geográfica das vendas por canal para identificar mercados prioritários.

<image src="https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Analise%20Geografica%20por%20Canal.png?raw=true">

### 7. Piores Meses em Taxa de Devolução

 Propósito: Identificar meses críticos de devolução para planejamento de estoque e logística reversa.

 <image src="https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Piores%20meses%20em%20taxa%20de%20devolu%C3%A7%C3%A3o.png?raw=true">

 ### 📐 Medidas DAX

# Faturamento Total

Soma o valor bruto de todas as vendas registradas na tabela fato.
Onde foi usado: Card principal (Página 1), Eixo de valor nos gráficos de barras e colunas.
Comportamento com filtros: Responde a qualquer segmentação ativa (canal, ano, mês, categoria) — é a medida mais reutilizada do projeto.

<image src="https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Faturamento%20Total.png?raw=true">

# Total Devoluções

Soma o valor financeiro de todas as devoluções.
Onde foi usado: Card de alerta (Páginas 1 e 3), barras de devolução por canal e por categoria.
Comportamento com filtros: Filtrada por canal, revela onde o prejuízo com devoluções é mais concentrado.

<image src= "https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Total%20Devolu%C3%A7%C3%B5es.png?raw=true">

# % Devolução

Calcula a taxa de devolução como proporção do faturamento. Resultado entre 0 e 1 (formatado como %).
Onde foi usado: Card de taxa (Páginas 1 e 3), rótulos de dados nas barras de devolução, matriz de calor (Página 3), formatação condicional (cor dinâmica dos cards).
Nota técnica: DIVIDE com terceiro parâmetro 0 evita erro de divisão por zero quando não há faturamento no contexto filtrado. Essencial para que os visuais não quebrem com filtros específicos.

<image src= "https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/%25%20Devolu%C3%A7%C3%A3o.png?raw=true">

# Ticket Médio

Valor médio gasto por item em cada transação.
Onde foi usado: Card (Páginas 1 e 2), gráfico de colunas agrupadas por canal (Página 2).
Nota técnica: Usar SUM na quantidade (e não COUNT) considera corretamente transações com múltiplos itens. O DIVIDE previne Infinity em cenários sem vendas.

<image src="https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Ticket%20Medio.png?raw=true">

# Crescimento YoY %

Calcula a variação percentual do faturamento em relação ao mesmo período do ano anterior.
Onde foi usado: Tabela de ranking (Página 2) com ícones de tendência (▲ verde para positivo, ▼ vermelho para negativo).
Comportamento com filtros: Exige um contexto de data definido. Se o usuário filtrar um mês específico, compara com o mesmo mês do ano anterior. SAMEPERIODLASTYEAR garante essa correspondência inteligente.

<image src="https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Crescimento%20YoY.png?raw=true">

# Ranking Canal

Atribui a posição de cada canal no ranking de faturamento (1º, 2º, 3º...).
Onde foi usado: Cards de destaque Top 1/2/3 e Pior Canal (Página 2), ordenação da tabela de ranking.
Nota técnica: ALL(DimChannel[ChannelName]) é essencial — sem ele, o RANKX consideraria apenas o canal no contexto atual (sempre rank 1). SKIP evita empates "pulando" posições (ex: se dois canais empatam em 2º, o próximo é 4º).

<image src="https://github.com/LucianBrito/ContosoRetailDW/blob/main/Prints/Rankink%20Canal.png?raw=true">

### 📋 Reprodução do Projeto

Pré-requisitos
SQL Server Management Studio (SSMS) ou Azure Data Studio
Power BI Desktop (versão 2023 ou superior)
Acesso ao servidor 2.24.101.13,1433
Base ContosoRetailDW restaurada no servidor

Passo a Passo
1. Conectar ao banco de dados
2. Extrair os dados para o Power BI
3. Modelar os relacionamentos
4. Criar as medidas DAX
5. Construir o dashboard

### 💡 Principais Insights

1. Insights de Negócio
Store domina com folga: O canal Store representa 60% do faturamento total, com R$ 6,9 bilhões em vendas. É o motor do negócio — nenhum outro canal chega perto.
Online é o segundo colocado, mas distante: Com R$ 2,6 bilhões, o canal Online tem 22,6% de participação. Se fosse uma empresa independente, já seria um negócio bilionário.
Reseller é relevante mas complementar: O canal Reseller contribui com R$ 1,7 bilhão, representando 14,8% do total. É um canal de volume intermediário que merece atenção para não perder participação.
Catalog é residual: Representa cerca de 2,6% do faturamento. Pode indicar um canal em declínio ou com baixo investimento — merece uma decisão estratégica (revitalizar ou descontinuar).
2. Insight Surpreendente
⚡ 60% do faturamento está concentrado em um único canal (Store).
Isso é uma faca de dois gumes: significa que a operação física é extremamente forte e gera fidelidade, mas também expõe a empresa a um risco de concentração.
Se uma crise de mobilidade ou mudança de hábito de consumo afetar o varejo físico, 60% da receita está em jogo. A diversificação de canais não é apenas oportunidade — é proteção.

4. Conclusão
A Contoso Retail é, essencialmente, uma empresa de varejo físico com um braço digital em crescimento. O Store não é apenas o maior canal — ele é o responsável pela solidez financeira da operação.
No entanto, depender 60% de um único canal é um risco estratégico relevante. O Online, com R$ 2,6 bilhões, já é grande o suficiente para justificar investimento dedicado, mas ainda não atingiu escala para compensar uma eventual retração do físico.
A decisão de negócio que se impõe é: acelerar o digital sem descuidar do físico, buscando reduzir a dependência do Store para algo próximo de 50% nos próximos 2-3 anos.

#	Recomendação	Impacto Esperado
1	Estabelecer meta de participação do Online: Definir meta de 30% de share em 2 anos, com investimento proporcional em marketing digital, UX e logística de entrega	Redução da dependência do Store; crescimento de receita em canal de margem potencialmente maior
2	Investigar a lucratividade real de cada canal: Cruzar faturamento com custos operacionais (aluguel, frete, logística reversa, equipe) para calcular margem de contribuição por canal	Decisão de investimento baseada em rentabilidade, não apenas em receita bruta
3	Criar estratégia omnicanal: Mapear a sobreposição de clientes entre canais. Clientes que compram em Store + O

Próximos Passos Analíticos

#	Análise Complementar	Pergunta que Responde
1	Margem de contribuição por canal: Cruzar FactSales[TotalCost] com custos operacionais estimados (frete, aluguel, equipe) para calcular lucro real de cada canal	"Store fatura mais, mas entrega mais lucro?"
2	Análise de sobreposição de clientes: Usar CustomerKey para identificar quantos clientes compram em mais de um canal	"Cliente omnicanal vale mais que cliente de canal único?"
3	Sazonalidade das devoluções por categoria: Cruzar DimDate[CalendarMonth] × DimProductCategory[ProductCategoryName] para identificar padrões sazonais de devolução	"Eletrônicos têm mais devolução em janeiro (pós-Natal)? Como nos preparamos?"
4	Previsão de faturamento com série temporal: Usar o recurso de previsão do Power BI (ou Python) para projetar o crescimen


👤 Autor
Luciano — Projeto desenvolvido como parte do portfólio de Business Intelligence e Análise de Dados.

📝 Licença
Este projeto é parte de um portfólio pessoal baseado na base de dados pública ContosoRetailDW da Microsoft. Os dados são fictícios e utilizados exclusivamente para fins educacionais e demonstrativos.

"Sem dados, você é apenas mais uma pessoa com uma opinião." — W. Edwards Deming



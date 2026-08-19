# 🛒 Contoso Retail — Vendas, Canais e Devoluções

![SQL Server](https://img.shields.io/badge/SQL%20Server-2019-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=power-bi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-FFB900?style=for-the-badge&logo=power-bi&logoColor=black)
![Star Schema](https://img.shields.io/badge/Modelagem-Star%20Schema-6C5CE7?style=for-the-badge)

## 📌 Visão geral

Este case analisa a performance comercial da **Contoso Retail**, uma empresa fictícia de varejo com múltiplos canais de venda.

O objetivo é demonstrar como **SQL + modelagem dimensional + Power Query + DAX + Power BI** podem ser utilizados para entender faturamento, performance por canal e impacto das devoluções.

---

## 🎯 Problema de negócio

A diretoria comercial precisa responder três perguntas:

1. **Qual canal gera mais receita?**
2. **Onde a empresa apresenta maior impacto de devoluções?**
3. **Como vendas, devoluções e indicadores comerciais evoluem ao longo do tempo?**

A análise transforma essas perguntas em indicadores executivos para apoiar decisões comerciais e operacionais.

---

## 🔎 Perguntas analisadas

- Qual canal apresenta maior faturamento?
- Qual canal apresenta maior taxa de devolução?
- Como o faturamento evolui mensalmente?
- Quais categorias possuem maior taxa de devolução?
- Como o ticket médio varia entre canais e períodos?
- Quais meses apresentam comportamento crítico de devoluções?
- Como os canais se posicionam em ranking de faturamento?
- Existem diferenças relevantes entre Store, Online, Reseller e Catalog?

---

## 🗃️ Dados e modelo

A análise utiliza o **ContosoRetailDW**, um Data Warehouse de varejo utilizado em estudos de Business Intelligence.

### Principais tabelas

- `FactSales`;
- `FactOnlineSales`;
- `DimChannel`;
- `DimDate`;
- `DimProduct`;
- `DimProductSubcategory`;
- `DimProductCategory`;
- `DimStore`;
- `DimGeography`.

A modelagem utiliza **Star Schema**, com tabelas fato relacionadas às dimensões de negócio.

### Hierarquia de produto

```text
Categoria
   ↓
Subcategoria
   ↓
Produto
```

---

# 🧠 Metodologia

```text
Data Warehouse
      ↓
Exploração com SQL
      ↓
Validação dos dados
      ↓
Modelagem dimensional
      ↓
Power Query
      ↓
Medidas DAX
      ↓
Dashboard Power BI
      ↓
Insights e recomendações
```

---

# 1️⃣ SQL — Análise exploratória

As consultas SQL foram utilizadas para validar os dados antes da construção do dashboard e responder às principais perguntas de negócio.

### Análises realizadas

- faturamento total por canal;
- taxa de devolução por canal;
- evolução mensal do faturamento;
- ranking de categorias por devolução;
- ticket médio por canal e ano;
- análise geográfica;
- identificação dos meses críticos de devolução;
- ranking de canais.

### Recursos utilizados

- `JOIN`;
- `GROUP BY`;
- `CASE WHEN`;
- funções de agregação;
- funções de data;
- cálculos de percentual;
- ranking;
- filtros e contexto analítico.

---

# 2️⃣ Qualidade e preparação dos dados

Antes da criação dos indicadores, foram realizadas validações para reduzir inconsistências no modelo.

No Power Query foram aplicados procedimentos como:

- remoção de colunas sem relevância analítica;
- ajuste de tipos de dados;
- tratamento de valores nulos;
- seleção das tabelas necessárias;
- preparação das dimensões para o modelo.

---

# 3️⃣ Modelagem dimensional

O modelo segue o padrão **Star Schema**, com `FactSales` e `FactOnlineSales` como tabelas centrais e dimensões relacionadas a:

- data;
- canal;
- produto;
- loja;
- geografia.

Foi utilizada direção de filtro **Dimensão → Fato**, reduzindo ambiguidades no relacionamento e facilitando a manutenção das medidas DAX.

---

# 4️⃣ DAX — Indicadores

Foram criadas medidas para acompanhar os principais KPIs do negócio.

### 💰 Indicadores financeiros

- Faturamento Total;
- Total de Devoluções;
- Percentual de Devolução;
- Ticket Médio.

### 📈 Indicadores temporais

- crescimento YoY;
- evolução mensal;
- comparação entre períodos.

### 🏆 Performance

- ranking de canais;
- Top canais;
- pior canal;
- comparação entre canais.

Entre os recursos DAX utilizados estão `CALCULATE`, `DIVIDE`, `SAMEPERIODLASTYEAR` e `RANKX`.

---

# 📊 Dashboard

O dashboard foi organizado em três perspectivas principais:

### 1. Comercial

Apresenta faturamento, ticket médio, devoluções, percentual de devolução, faturamento por canal e evolução temporal.

### 2. Performance por Canal

Permite comparar **Store, Online, Reseller e Catalog**, com ranking, evolução e indicadores de desempenho.

### 3. Devoluções

Concentra a análise de valor devolvido, taxa de devolução, comportamento por canal, categoria e períodos críticos.

---

# 💡 Insights de negócio

O case foi construído para permitir que a gestão identifique:

- canais responsáveis pela maior parcela da receita;
- canais com maior impacto de devoluções;
- categorias que exigem investigação;
- períodos com aumento de devoluções;
- diferenças de ticket médio entre canais;
- oportunidades de melhoria comercial e operacional.

O objetivo é ir além da visualização e utilizar os indicadores para **orientar decisões**.

---

# 🛠️ Tecnologias

| Tecnologia | Aplicação |
|---|---|
| **SQL Server / SQL** | Consulta e análise |
| **Power Query** | Tratamento e transformação |
| **Power BI** | Dashboard e visualização |
| **DAX** | KPIs e métricas |
| **Star Schema** | Modelagem dimensional |
| **GitHub** | Versionamento e documentação |

---

# 🎯 Competências demonstradas

Este projeto demonstra competências relevantes para **Analista de Dados Júnior / Analista de BI**:

- interpretação de problema de negócio;
- SQL analítico;
- qualidade e preparação de dados;
- modelagem dimensional;
- Power Query;
- DAX;
- KPIs;
- análise temporal;
- análise de canais;
- análise de devoluções;
- Power BI;
- comunicação de insights.

---

## 👤 Autor

**Luciano Conceição de Brito**  
Analista de Dados | Business Intelligence

[LinkedIn](https://www.linkedin.com/in/luciano-concei%C3%A7%C3%A3o-de-brito/) · [GitHub](https://github.com/LucianBrito)

> **Transformar dados em insights para apoiar decisões melhores.**

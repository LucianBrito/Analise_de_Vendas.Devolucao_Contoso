# 🛒 Contoso Retail — Análise de Vendas e Devoluções

![SQL Server](https://img.shields.io/badge/SQL%20Server-2019-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=power-bi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-FFB900?style=for-the-badge&logo=power-bi&logoColor=black)
![Star Schema](https://img.shields.io/badge/Modelagem-Star%20Schema-6C5CE7?style=for-the-badge)

## 📌 Visão geral

Case de **Business Intelligence para varejo** desenvolvido com dados do ContosoRetailDW.

O objetivo é analisar **vendas, canais, ticket médio e devoluções**, transformando dados de um Data Warehouse em indicadores para apoiar decisões comerciais e operacionais.

**Stack:** SQL Server + SQL + Power Query + DAX + Power BI.

---

## 🎯 Problema de negócio

A gestão precisa responder:

1. **Qual canal gera maior receita?**
2. **Qual canal apresenta maior impacto de devoluções?**
3. **Como vendas, ticket médio e devoluções evoluem ao longo do tempo?**
4. **Quais categorias ou períodos precisam de investigação?**

A análise foi estruturada para transformar essas perguntas em KPIs e visualizações executivas.

---

## 🔎 Perguntas de negócio

- Qual canal apresenta maior faturamento?
- Qual canal apresenta maior taxa de devolução?
- Como o faturamento evolui mensalmente?
- Quais categorias apresentam maior impacto de devoluções?
- Como o ticket médio varia entre canais?
- Quais períodos apresentam aumento de devoluções?
- Como os canais se posicionam no ranking de faturamento?
- Existem diferenças relevantes entre Store, Online, Reseller e Catalog?

---

## 🗃️ Dados e modelo

O projeto utiliza o **ContosoRetailDW**, um Data Warehouse de varejo utilizado em estudos de Business Intelligence.

### Principais tabelas

- `FactSales`
- `FactOnlineSales`
- `DimChannel`
- `DimDate`
- `DimProduct`
- `DimProductSubcategory`
- `DimProductCategory`
- `DimStore`
- `DimGeography`

### Hierarquia de produto

```text
Categoria
   ↓
Subcategoria
   ↓
Produto
```

O modelo utiliza conceitos de **Star Schema**, com tabelas fato relacionadas às dimensões de negócio.

---

# 🧠 Metodologia

```text
Data Warehouse
      ↓
Exploração e validação com SQL
      ↓
Tratamento dos dados
      ↓
Modelagem dimensional
      ↓
Power Query
      ↓
Medidas DAX
      ↓
Dashboard Power BI
      ↓
Insights de negócio
```

---

# 1️⃣ SQL — Exploração e análise

As consultas SQL foram utilizadas para explorar os dados, validar informações e responder às perguntas de negócio.

### Análises realizadas

- faturamento por canal;
- taxa de devolução por canal;
- evolução mensal;
- ranking de categorias;
- ticket médio por canal e período;
- análise geográfica;
- identificação de períodos críticos;
- ranking de canais.

### Recursos SQL

- `JOIN`
- `GROUP BY`
- `CASE WHEN`
- funções de agregação
- funções de data
- cálculos percentuais
- ranking
- filtros e agregações analíticas

---

# 2️⃣ Qualidade e preparação dos dados

Antes da criação dos indicadores, foram realizadas etapas de preparação para reduzir inconsistências no modelo.

### Power Query

- seleção das tabelas necessárias;
- remoção de colunas sem relevância analítica;
- ajuste de tipos de dados;
- tratamento de valores nulos;
- preparação das dimensões;
- organização dos dados para o modelo.

---

# 3️⃣ Modelagem dimensional

O modelo segue o padrão **Star Schema**, utilizando fatos e dimensões para organizar a análise.

### Fatos principais

- `FactSales`
- `FactOnlineSales`

### Dimensões

- Data
- Canal
- Produto
- Loja
- Geografia

A separação entre fatos e dimensões facilita a construção das medidas e a navegação entre diferentes perspectivas do negócio.

---

# 4️⃣ DAX — KPIs

Foram criadas medidas para acompanhar os principais indicadores.

### 💰 Financeiro

- Faturamento Total
- Total de Devoluções
- Percentual de Devolução
- Ticket Médio

### 📈 Temporal

- crescimento YoY
- evolução mensal
- comparação entre períodos

### 🏆 Performance

- ranking de canais
- comparação entre canais
- melhor canal
- canal com maior impacto de devoluções

### Recursos DAX utilizados

`CALCULATE` · `DIVIDE` · `SAMEPERIODLASTYEAR` · `RANKX`

---

# 📊 Dashboard

O dashboard foi estruturado em três perspectivas:

### Comercial

- faturamento;
- ticket médio;
- devoluções;
- percentual de devolução;
- faturamento por canal;
- evolução temporal.

### Performance por canal

Comparação entre:

- Store;
- Online;
- Reseller;
- Catalog.

### Devoluções

Análise de:

- valor devolvido;
- taxa de devolução;
- canal;
- categoria;
- período.

---

# 💡 Insights de negócio

O projeto foi desenvolvido para identificar:

- canais responsáveis pela maior parcela da receita;
- canais com maior impacto de devoluções;
- categorias que merecem investigação;
- períodos com aumento de devoluções;
- diferenças de ticket médio;
- oportunidades de melhoria comercial e operacional.

> O objetivo do dashboard não é apenas mostrar números, mas transformar indicadores em perguntas e decisões de negócio.

---

# 🛠️ Tecnologias

| Tecnologia | Aplicação |
|---|---|
| **SQL Server / SQL** | Exploração e análise |
| **Power Query** | Tratamento e transformação |
| **Power BI** | Dashboard e visualização |
| **DAX** | KPIs e métricas |
| **Star Schema** | Modelagem dimensional |
| **GitHub** | Versionamento e documentação |

---

# 🎯 Competências demonstradas

- interpretação de problemas de negócio;
- SQL analítico;
- preparação e qualidade de dados;
- modelagem dimensional;
- Power Query;
- DAX;
- criação de KPIs;
- análise temporal;
- análise de canais;
- análise de devoluções;
- Power BI;
- comunicação de insights.

**Posicionamento:** case desenvolvido para demonstrar competências de **Analista de Dados Júnior / Analista de BI**.

---

## 👤 Autor

**Luciano Conceição de Brito**  
Analista de Dados | Business Intelligence

[LinkedIn](https://www.linkedin.com/in/luciano-concei%C3%A7%C3%A3o-de-brito/) · [GitHub](https://github.com/LucianBrito)

> **Transformar dados em insights para apoiar decisões melhores.**

# Supply Chain Analytics Dashboard

An end-to-end supply chain analytics project using **SQL and Power BI** to analyze approximately **90K supply-chain records** covering **2M units sold**, **33.43M revenue**, and **11.09M gross profit**.

The project focuses on revenue and profitability, inventory and reorder risk, supplier performance, demand forecasting, and promotion effectiveness.

---

## 📌 Project Overview

The objective of this project is to transform raw supply-chain data into actionable business insights using SQL for analytical querying and Power BI for data modeling, DAX calculations, and interactive dashboarding.

### Key Business Questions

- How are revenue and profitability performing?
- Which regions and warehouses generate the most revenue?
- Which SKUs have higher inventory/reorder risk?
- Which suppliers have the longest lead times?
- How accurate is demand forecasting?
- How does demand differ across regions and SKUs?
- Are promotional periods associated with higher unit sales?

---

## 🛠️ Tools & Technologies

- **SQL / MySQL** — Data analysis and business queries
- **Power BI** — Data modeling, DAX, visualization and dashboarding
- **Power Query** — Data preparation and transformation
- **Python** — Used separately for personal EDA and analysis

---

## 📂 Project Structure

```text
Supply-Chain-Analytics/
│
├── data/
│   └── supply_chain_dataset.csv
│
├── sql/
│   └── supply.sql
│
├── powerbi/
│   └── Supply Chain.pbix
│
├── screenshots/
│   ├── executive_overview.png
│   ├── inventory_supplier_analysis.png
│   └── demand_forecast_analysis.png
│
└── README.md
```

---

## 🗃️ Data Model

The Power BI report uses a simple **star-schema data model**.

### Fact Table

**FactSupplyChain**

Contains the main supply-chain observations, including:

- Date
- SKU_ID
- Supplier_ID
- Warehouse_ID
- Region
- Units_Sold
- Unit_Price
- Unit_Cost
- Demand_Forecast
- Inventory_Level
- Reorder_Point
- Supplier_Lead_Time_Days
- Promotion_Flag
- Stockout_Flag

### Dimension Tables

- **DimDate**
- **DimProduct**
- **DimSupplier**
- **DimWarehouse**
- **DimRegion**

---

# 📊 Power BI Dashboard

The dashboard consists of **3 analytical pages**.

## 1. Executive Overview

Provides a high-level view of supply-chain performance.

### KPIs

- Total Revenue
- Total Units Sold
- Gross Profit
- Gross Margin
- Average Inventory Value
- Average Inventory
- Average Lead Time
- Reorder Risk
- Forecast Error

### Visual Analysis

- Revenue by Month
- Revenue by Region
- Revenue by Warehouse

### Key Observations

- Total revenue is approximately **33.43M**.
- Total units sold are approximately **2M**.
- Gross profit is approximately **11.09M**.
- Gross margin is approximately **33.2%**.
- Revenue peaks around **March** and declines toward **September**, followed by a recovery toward the end of the year.

---

## 2. Inventory & Supplier Analysis

This page focuses on inventory health and supplier performance.

### KPIs

- Reorder Risk %
- Average Inventory Value
- Average Inventory
- Average Lead Time

### Visual Analysis

- SKU-level inventory and reorder-point comparison
- Supplier lead-time comparison
- Warehouse inventory comparison

### Key Observations

- Overall reorder risk is approximately **5.52%**.
- Average inventory is approximately **471.52 units**.
- Average supplier lead time is approximately **7.98 days**.
- Supplier lead times vary across suppliers and can be considered when planning replenishment and inventory buffers.

---

## 3. Demand & Forecast Analysis

This page evaluates demand behavior, forecasting performance and promotion-related demand.

### KPIs

- Total Units Sold
- Forecast Error %
- Forecast Accuracy %
- Promotion Lift %

### Visual Analysis

- Actual vs Forecast Demand by Month
- Monthly Forecast Error
- Demand by Region
- Top SKUs by Demand

### Key Observations

- Total units sold are approximately **2M**.
- Forecast error is approximately **16.32%**.
- Forecast accuracy is approximately **83.68%**.
- Forecast error increases substantially around **September/October**, indicating an area for further investigation.
- Promotional observations show approximately **28% higher average unit sales** compared with non-promotional observations.

---

# 📈 KPI Definitions

### Total Revenue

`SUM(Units_Sold × Unit_Price)`

### Total Cost

`SUM(Units_Sold × Unit_Cost)`

### Gross Profit

`Total Revenue - Total Cost`

### Gross Margin %

`Gross Profit / Total Revenue × 100`

### Reorder Risk %

Percentage of observations where:

`Inventory_Level <= Reorder_Point`

### Forecast Error %

Average absolute percentage error:

`AVG(ABS(Units_Sold - Demand_Forecast) / Units_Sold) × 100`

Records where `Units_Sold = 0` are excluded.

### Forecast Accuracy %

`100% - Forecast Error %`

### Promotion Lift %

`(Average Promo Units - Average Non-Promo Units) / Average Non-Promo Units × 100`

A **28% promotion lift** means promotional observations had approximately 28% higher average unit sales than non-promotional observations. This represents an association, not proof that promotions caused the increase.

---

# 💻 SQL Analysis

The SQL analysis covers:

- Total units sold
- Total revenue
- Total cost
- Gross profit
- Gross margin
- Revenue by region
- Revenue by warehouse
- Top 10 SKUs
- Supplier performance
- Reorder risk
- Forecast error
- Forecast error by month
- Promotion lift
- Monthly demand analysis

### SQL Concepts Used

- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `SUM()`
- `AVG()`
- `COUNT()`
- `ROUND()`
- `CASE`
- `ABS()`
- Date functions
- CTEs
- Window functions

### Example: Revenue by Region

```sql
SELECT
    Region,
    SUM(Units_Sold * Unit_Price) AS revenue
FROM supply_table
GROUP BY Region
ORDER BY revenue DESC;
```

### Example: Supplier Performance

```sql
SELECT
    Supplier_ID,
    ROUND(AVG(Supplier_Lead_Time_Days), 2) AS avg_lead_time
FROM supply_table
GROUP BY Supplier_ID
ORDER BY avg_lead_time DESC;
```

### Example: Monthly Demand with CTE

```sql
WITH monthly_demand AS (
    SELECT
        YEAR(Date) AS year,
        MONTH(Date) AS month_number,
        MONTHNAME(Date) AS month_name,
        SUM(Units_Sold) AS total_units
    FROM supply_table
    GROUP BY
        YEAR(Date),
        MONTH(Date),
        MONTHNAME(Date)
)

SELECT *
FROM monthly_demand
ORDER BY year, month_number;
```

---

# 🔍 Key Business Insights

1. **Revenue and profitability:** Approximately **33.43M revenue** and **11.09M gross profit** are generated in the dataset, with an overall gross margin of approximately **33.2%**.

2. **Demand seasonality:** Revenue peaks around March, declines toward September, and recovers toward the end of the year.

3. **Inventory risk:** Approximately **5.52%** of observations are at or below their reorder point, highlighting inventory positions that require monitoring.

4. **Supplier performance:** Average supplier lead time is approximately **7.98 days**, with differences between suppliers that may influence replenishment planning.

5. **Forecasting:** Forecast accuracy is approximately **83.68%**, while forecast error rises noticeably around September/October.

6. **Promotions:** Promotional observations have approximately **28% higher average unit sales** than non-promotional observations. Further analysis by SKU, region and period would be useful before making promotional decisions.

---

# 🎯 Business Recommendations

- Investigate months with unusually high forecast error and review seasonal or demand-related forecasting assumptions.
- Monitor SKUs where inventory frequently falls at or below reorder points.
- Review suppliers with relatively high lead times when setting inventory buffers and replenishment plans.
- Analyze promotional performance by SKU and region rather than relying only on overall promotion lift.
- Investigate the causes of the observed revenue decline between the peak and lower-demand periods.

These recommendations are based on descriptive analysis and should be validated against operational and business context before implementation.

---

# 📸 Dashboard Screenshots

Add screenshots of the three Power BI pages to the repository:

```markdown
![Executive Overview](screenshots/executive_overview.png)

![Inventory & Supplier Analysis](screenshots/inventory_supplier_analysis.png)

![Demand & Forecast Analysis](screenshots/demand_forecast_analysis.png)
```

---

# 💼 Resume Project Description

### Supply Chain Analytics | SQL, Power BI

- Analyzed **~90K supply-chain records** covering **2M units sold, 33.43M revenue, and 11.09M gross profit** to evaluate regional, warehouse, SKU, supplier, inventory, and demand performance.
- Developed SQL analysis using **aggregations, CASE statements, CTEs, date functions, and window functions** to identify operational trends, inventory risks, supplier lead-time differences, and forecast performance.
- Built a **3-page interactive Power BI dashboard** using a star-schema data model and DAX measures for executive performance, inventory & supplier analysis, and demand & forecast analysis.
- Identified **16.32% forecast error, 83.68% forecast accuracy, 5.52% reorder risk, and 28% positive promotion lift** from the analyzed data.

---

## ⚠️ Project Notes

- The dataset contains approximately **90K records**.
- KPI values are based on the supplied dataset and calculations implemented in SQL/Power BI.
- Promotion lift is treated as a descriptive comparison between promotional and non-promotional observations and should not be interpreted as causal evidence.
- Forecast error excludes observations where `Units_Sold = 0`.

---

## 👤 Author

**Anshpreet Singh**

BCA Graduate | Aspiring Data Analyst

**Skills:** SQL | Power BI | Python | Excel | Data Analytics

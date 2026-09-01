#Total Units Sold

SELECT
    SUM(Units_Sold) AS total_units_sold
FROM supply_table;

#Total revenue
SELECT 
    SUM(units_sold * unit_price) AS total_revenue
FROM
    supply_table;
    
#Total Cost
SELECT 
    SUM(units_sold * unit_cost) AS total_cost
FROM
    supply_table;
    
#Gross Margin
SELECT
    SUM(Units_Sold * Unit_Price)
    - SUM(Units_Sold * Unit_Cost) AS gross_profit
FROM supply_table;

#Gross Margin %

SELECT
    ROUND(
        (
            SUM(Units_Sold * Unit_Price)
            - SUM(Units_Sold * Unit_Cost)
        )
        / SUM(Units_Sold * Unit_Price) * 100,
        2
    ) AS gross_margin_pct
FROM supply_table;

#Revenue By Region
SELECT
    Region,
    SUM(Units_Sold * Unit_Price) AS revenue
FROM supply_table
GROUP BY Region
ORDER BY revenue DESC;

#Revenue By Warehouse
SELECT
    Warehouse_ID,
    SUM(Units_Sold * Unit_Price) AS revenue
FROM supply_table
GROUP BY Warehouse_ID
ORDER BY revenue DESC;

#Top 10 SKUs
SELECT
    SKU_ID,
    SUM(Units_Sold) AS total_units_sold
FROM supply_table
GROUP BY SKU_ID
ORDER BY total_units_sold DESC
LIMIT 10;


#Supplier Performance
SELECT
    Supplier_ID,
    ROUND(AVG(Supplier_Lead_Time_Days), 2) AS avg_lead_time
FROM supply_table
GROUP BY Warehouse_ID
ORDER BY avg_inventory DESC;

#Inventory Analysis

SELECT
    ROUND(
        SUM(
            CASE
                WHEN Inventory_Level <= Reorder_Point THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS reorder_risk_pct
FROM supply_table;

#Forecast Error
SELECT
    ROUND(
        AVG(
            ABS(Units_Sold - Demand_Forecast)
            / Units_Sold
        ) * 100,
        2
    ) AS forecast_error_pct
FROM supply_table
WHERE Units_Sold <> 0;

#Forecast Error by Month
SELECT
    MONTH(Date) AS month_number,
    MONTHNAME(Date) AS month_name,
    ROUND(
        AVG(
            ABS(Units_Sold - Demand_Forecast)
            / Units_Sold
        ) * 100,
        2
    ) AS forecast_error_pct
FROM supply_table
WHERE Units_Sold <> 0
GROUP BY
    MONTH(Date),
    MONTHNAME(Date)
ORDER BY month_number;

#Promotion Analysis

SELECT
    ROUND(
        (
            AVG(
                CASE
                    WHEN Promotion_Flag = 1
                    THEN Units_Sold
                END
            )
            -
            AVG(
                CASE
                    WHEN Promotion_Flag = 0
                    THEN Units_Sold
                END
            )
        )
        /
        AVG(
            CASE
                WHEN Promotion_Flag = 0
                THEN Units_Sold
            END
        ) * 100,
        2
    ) AS promotion_lift_pct
FROM supply_table;

#Monthly Demand Analysis
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

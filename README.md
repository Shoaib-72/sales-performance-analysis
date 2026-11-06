# Sales Performance Analysis
 
An end-to-end analysis of a retail sales dataset (January 2016 to February 2021), covering data cleaning in Python, business analysis in SQL, and an interactive Power BI dashboard.
 
**Business question:** Revenue fell by about half in 2020. Why did it happen, and where should the business act to recover?
 
## Project workflow
 
1. **Data cleaning (Python / Jupyter Notebook)**: cleaned the raw files and exported them as the datasets in `Cleaned-data/`.
2. **Business analysis (SQL)**: loaded the cleaned tables into PostgreSQL and answered the business question with queries in `SQL-script/`.
3. **Dashboard (Power BI)**: built an interactive report from the same data, with a custom theme, in `PowerBi/`.
## Folder structure
 
| Folder | Contents |
|---|---|
| `orginal-data/` | Raw source files, before cleaning |
| `Cleaned-data/` | Cleaned tables used for analysis: sales, customers, products, stores, exchange rates |
| `Python-script/` | Jupyter Notebook with the data cleaning steps |
| `SQL-script/` | SQL queries for the business analysis and practice questions |
| `Dashboard/` | Interactive HTML version of the dashboard |
| `PowerBi/` | Power BI theme files (JSON) and the setup guide |
 
## Step 1: Data cleaning (Python)
 
The raw data was loaded into a Jupyter Notebook (`Python-script/`) and cleaned before analysis. The steps included:
 
- Checking data types, missing values, and duplicate rows
- Standardising column names and date formats
- Checking that every foreign key (customer, store, and product) matched a row in its lookup table
The cleaned tables are saved in `Cleaned-data/`.
 
## Step 2: Business analysis (SQL)
 
The cleaned tables were loaded into PostgreSQL. `SQL-script/` contains:
 
- **Business queries:** answers to the business question, covering yearly performance, the monthly trend, the 2019 to 2020 decline by category, region, and store, channel mix, customer retention, and category profitability.
- **Practice queries (Q1–Q10):** overall sales, monthly trend, best sellers, country performance, store performance, customer analysis, category performance, customer segmentation, and year-over-year growth.
Revenue = quantity × unit price (USD). Gross profit = quantity × (unit price − unit cost).
 
## Key findings
 
- Revenue peaked at **$18.3M in 2019**, fell to **$9.3M in 2020 (−49%)**, and was still down **76%** in January–February 2021.
- The decline began in **March 2020** and affected every category, region, and store at a similar rate. This suggests a company-wide demand shock rather than a single product problem.
- **Repeat customers generate 82% of revenue**, so retention matters more than acquisition.
- **22% of customers (3,379) have never placed an order**, a clear reactivation opportunity.
- **Computers** is the largest profit pool, at about 34% of gross profit.
- Margins are tightly clustered (about 55–61%), so **pricing is not the main lever**. Volume is.
## Step 3: Dashboard (Power BI)
 
The Power BI report has one overview page with KPI cards, the monthly revenue trend, year-over-year growth, top products, category profitability, and channel mix. A second page covers stores and customers.
 
![Power BI dashboard](PowerBi/dashboard.png)
 
The `PowerBi/` folder includes:
 
- `sales_dashboard_theme.json` and `revenue_channel_theme.json`, which can be imported via **View > Themes > Browse for themes**
- The setup guide, with the data model and DAX measures
The `Dashboard/` folder contains an interactive HTML version of the sales dashboard. Open `sales_dashboard.html` in a browser to view it.
 
## Data notes
 
- 2021 covers only January to 20 February, so year-over-year comparisons for 2021 are not meaningful.
- Revenue is at list price. Discounts and returns are not included.
- Delivery dates are 79% blank and were excluded from the analysis.
- Online sales (store 0) have no matching store record, so they are excluded from store-level views.
## Tools
 
Python (Jupyter Notebook) · PostgreSQL · SQL (window functions, CTEs) · Power BI · DAX · Chart.js

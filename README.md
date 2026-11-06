# Global Electronics Retailer -- Sales Data Analysis

An end-to-end data analytics project exploring sales performance for a
global electronics retailer using **Python, PostgreSQL, SQL, and Power
BI**.

The project follows a practical analytics workflow: inspect and clean
raw data, load the cleaned datasets into PostgreSQL, answer business
questions with SQL, and present key findings in an interactive Power BI
dashboard.

------------------------------------------------------------------------

## Project Overview

The goal of this project is to turn raw retail data into useful business
insights. The analysis focuses on four core datasets:

-   **Sales** -- transaction-level information, order dates, quantities,
    and product/customer/store keys.
-   **Customers** -- customer details and geographic information.
-   **Products** -- product names, brands, categories, costs, and
    selling prices.
-   **Stores** -- store locations and store details.

Two additional datasets support the analysis:

-   **Exchange Rates** -- supports currency conversion where required.
-   **Data Dictionary** -- explains the fields in the source datasets.

## Tools & Technologies

  Tool               Purpose
  ------------------ -------------------------------------------
  Python             Data preparation and exploratory analysis
  Jupyter Notebook   Running and documenting Python work
  Pandas and NumPy   Data cleaning and transformation
  PostgreSQL         Storing and querying the cleaned datasets
  SQL                Answering business questions
  Power BI           Building interactive dashboards
  Git and GitHub     Version control and project sharing

------------------------------------------------------------------------

## Project Workflow

### 1. Data Loading and Understanding -- Python

The six CSV files were loaded into Jupyter Notebook using Pandas.

Initial inspection included:

-   Reviewing dataset dimensions (rows and columns).
-   Checking column names and data types.
-   Identifying missing values.
-   Checking duplicate records.
-   Reviewing sample records and understanding field meanings using the
    data dictionary.

### 2. Data Cleaning and Preparation -- Python

Each dataset was cleaned separately to preserve its structure and
relationships.

**Customers** - Removed completely empty rows and exact duplicate
rows. - Trimmed extra spaces from text fields. - Converted the birthday
field to a date type. - Investigated missing state codes rather than
deleting customer records.

**Data Dictionary** - Removed completely empty rows and columns. -
Removed exact duplicates. - Trimmed extra spaces from text fields.

**Exchange Rates** - Removed empty and exact duplicate rows. -
Standardized currency codes. - Converted dates and exchange-rate values
to appropriate data types. - Checked for invalid non-positive exchange
rates.

**Products** - Removed empty and exact duplicate rows. - Trimmed text
fields. - Converted product and category keys to numeric types. -
Cleaned currency symbols and thousands separators before converting cost
and price fields to numeric values. - Investigated invalid or missing
price values rather than replacing them with invented values.

**Sales** - Removed empty and exact duplicate rows. - Trimmed text
fields. - Converted order dates and numeric fields to appropriate
types. - Removed rows missing essential transaction identifiers or
required fields, and checked transaction-line duplicates. - Kept missing
delivery dates as NULL because a missing date should not be replaced
with an assumed delivery date.

**Stores** - Removed empty and exact duplicate rows. - Trimmed text
fields. - Converted store keys, square metres, and opening dates to
appropriate data types. - Investigated missing store-area information
rather than filling it with an arbitrary value.

> **Data quality note:** Missing values are not automatically errors.
> Their meaning should be investigated before deciding whether to
> retain, correct, or exclude them. The cleaning notebook and final
> data-quality report should be treated as the record of the actual
> decisions made.

### 3. PostgreSQL Database Integration

The cleaned Pandas DataFrames were loaded from Jupyter Notebook into
PostgreSQL using SQLAlchemy and the Psycopg2 driver.

**Database:** `global_electronics`

**Tables loaded:**

-   `customers`
-   `data_dictionary`
-   `exchange_rates`
-   `products`
-   `sales`
-   `stores`

The loaded tables were checked by inspecting the available table names
and comparing database row counts with the cleaned DataFrames.

### 4. SQL Business Analysis

SQL queries were written to answer retail business questions, including:

1.  **Overall Sales Performance** -- count orders, total quantity sold,
    unique customers, and distinct products sold.
2.  **Monthly Sales Trend** -- analyse order volume and quantity sold by
    month.
3.  **Top 10 Best-Selling Products** -- identify products with the
    highest quantity sold.
4.  **Country-Wise Sales Performance** -- compare sales activity and
    customers across countries.
5.  **Top 10 Highest-Revenue Products** -- estimate product revenue
    using selling price and quantity.
6.  **Store Performance Analysis** -- compare transaction activity
    across stores.
7.  **Customer Purchase Analysis** -- identify customers with high
    purchase activity.
8.  **Product Category Performance** -- compare categories using
    quantity and revenue measures.
9.  **Customer Segmentation** -- group customers using purchase activity
    and defined thresholds.
10. **Year-over-Year Sales Trend** -- compare yearly sales activity and
    calculate growth.

SQL concepts used include:

-   `SELECT`, `WHERE`, `ORDER BY`, and `LIMIT`
-   Aggregate functions such as `SUM()` and `COUNT()`
-   `GROUP BY` and `HAVING`
-   `INNER JOIN` and other joins where appropriate
-   Common Table Expressions (CTEs)
-   Date functions such as `DATE_TRUNC()`
-   Window functions such as `LAG()`

**Revenue and currency consideration:** A basic revenue calculation is
selling price multiplied by quantity. Before presenting a consolidated
revenue figure, confirm that the transaction currency and product price
currency are aligned. Use the exchange-rate table where conversion is
required, and document the chosen conversion direction and date logic.

### 5. Power BI Dashboard

The cleaned and analysed data was used to build an interactive Power BI
dashboard.

The dashboard can be used to explore the business measures and trends
developed during the analysis, such as:

-   Overall sales and order activity
-   Monthly and yearly trends
-   Product and category performance
-   Customer purchasing patterns
-   Country and store performance

Add your actual dashboard screenshot to the `Screenshots` folder and
update the image path below.

### 📊 Page 1 – Sales Overview
![Sales Overview](Dashboard/page#1.png)

### 📦 Page 2 – Product Performance
![Product Performance](Dashboard/page2.png)

### 👥 Page 3 – Customer Analysis
![Customer Analysis](Dashboard/page3.png)

**Power BI file:** `PowerBI/Sales_Dashboard.pbix`

> Replace the screenshot path and Power BI filename above if your files
> use different names. Only include visuals and KPIs that are present in
> your actual dashboard.

------------------------------------------------------------------------

## Repository Structure

A suggested GitHub repository structure is:

``` text
Global-Electronics-Sales-Analysis/
│
├── Dataset/
│   ├── raw/
│   │   ├── Customers.csv
│   │   ├── Data_Dictionary.csv
│   │   ├── Exchange_Rates.csv
│   │   ├── Products.csv
│   │   ├── Sales.csv
│   │   └── Stores.csv
│   │
│   └── cleaned/
│       ├── Customers_Cleaned.csv
│       ├── Data_Dictionary_Cleaned.csv
│       ├── Exchange_Rates_Cleaned.csv
│       ├── Products_Cleaned.csv
│       ├── Sales_Cleaned.csv
│       └── Stores_Cleaned.csv
│
├── Python/
│   └── Global-retailer.ipynb
│
├── SQL/
│   ├── Q1_Overall_Sales_Performance.sql
│   ├── Q2_Monthly_Sales_Trend.sql
│   └── Global-Retailer.sql
│
├── PowerBI/
│   └── Sales_Dashboard.pbix
│
├── Screenshots/
│   └── dashboard.png
│
└── README.md
```

The structure is a guide. Adjust the paths and filenames to match the
files actually included in your repository.

------------------------------------------------------------------------

## How to Reproduce the Project

### Requirements

-   Python 3
-   Jupyter Notebook
-   PostgreSQL
-   pgAdmin (optional, for database administration)
-   Power BI Desktop

### Python setup

Install the required packages:

``` bash
pip install pandas numpy sqlalchemy psycopg2-binary jupyter
```

### Run the notebook

1.  Clone or download this repository.
2.  Place the raw CSV files in the expected `Dataset/raw/` folder, or
    update the notebook paths.
3.  Open the notebook in Jupyter.
4.  Run the inspection and cleaning cells.
5.  Review the data-quality checks and export the cleaned CSV files.

### Load data into PostgreSQL

1.  Start your PostgreSQL server.
2.  Create or connect to the `global_electronics` database.
3.  Update the database connection settings in the notebook.
4.  Run the database-loading cells to create and populate the tables.
5.  Verify table names and row counts in PostgreSQL.

**Security:** Do not commit database passwords, API keys, or other
credentials to GitHub. Use environment variables or a local
configuration file excluded through `.gitignore`.

### Run SQL analysis

Open the `.sql` files in pgAdmin or another PostgreSQL client. Run the
queries against the loaded `global_electronics` database.

### Open the Power BI report

Open the `.pbix` file in Power BI Desktop. If the report uses a local
PostgreSQL connection, update the data-source settings to match your own
PostgreSQL host, database, and authentication details, then refresh the
data.

------------------------------------------------------------------------

## Key Data Considerations

-   Keep the raw source files unchanged and store cleaned outputs
    separately.
-   Preserve key columns used to connect sales to customers, products,
    and stores.
-   Do not invent missing delivery dates, customer keys, product keys,
    or store keys.
-   Review missing and invalid values and document the decisions made.
-   Confirm the currency basis before comparing or summing revenue
    across currencies.
-   Avoid publishing sensitive credentials or personal information in
    the repository.
-   Check dataset licensing and redistribution terms before uploading
    source or cleaned CSV files publicly. If redistribution is not
    permitted, provide the official source link and instructions instead
    of committing the data.

## Skills Demonstrated

-   Data understanding and quality assessment
-   Data cleaning and transformation with Python
-   Exploratory data analysis
-   Relational database loading and validation
-   SQL querying, joins, aggregations, CTEs, and window functions
-   Business-focused analysis
-   Power BI dashboard development
-   Technical documentation and GitHub project organisation

## Conclusion

This project demonstrates an end-to-end retail analytics workflow, from
raw data preparation through SQL-based business analysis to Power BI
reporting. It provides practice in using multiple analytics tools
together to investigate business performance and communicate findings.

------------------------------------------------------------------------

**Author:** Muhammad Shoaib Chiplunkar\
**Project:** Global Electronics Retailer -- Sales Data Analysis\
**Tools:** Python \| PostgreSQL \| SQL \| Power BI

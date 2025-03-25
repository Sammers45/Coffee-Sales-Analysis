# Coffee Sales Analysis

A Power BI project that provides insights into coffee shop sales trends, product performance, and peak purchasing times.

## Table of Contents
1. [Overview](#overview)
2. [Data Sources](#data-sources)
3. [Project Structure](#project-structure)
4. [Technologies Used](#technologies-used)
5. [Getting Started](#getting-started)
6. [Data Transformation & Modeling](#data-transformation--modeling)
7. [Dashboard & Key Insights](#dashboard--key-insights)
8. [How to Use the Dashboard](#how-to-use-the-dashboard)
9. [Contributing](#contributing)
10. [License](#license)
11. [Contact](#contact)

---

## Overview
This project analyzes coffee shop sales data (e.g., from May 2023). It highlights:
- **Total Sales, Orders, and Quantity Sold**  
- **Sales Trends Over Time**  
- **Sales by Product Category**  
- **Peak Days and Hours**  
- **Store‐by‐Store Comparisons**

By understanding these metrics, businesses can optimize product offerings, staffing, and marketing strategies.

---

## Data Sources
1. **Coffee Shop Sales (CSV/XLSX)** – Raw transactional sales data  
2. **Coffee_Shop_Sales_Analysis.sql** – SQL script for data cleaning and exploratory queries  
3. **Coffee_Sales_Analysis.pbix** – Power BI file containing the final dashboard  

---

## Project Structure
- **CSV/XLSX** – Original raw data files  
- **.pbix** – Power BI report  
- **.sql** – SQL scripts for data preparation  
- **README.md** – You are reading it now  

---

## Technologies Used
- **Power BI** – For dashboard creation and data visualization  
- **SQL** – For queries, data cleaning, and aggregations  
- **CSV/XLSX** – Data input and storage  

---

## Getting Started
1. **Clone or Download** this repository.  
2. **Open `Coffee_Sales_Analysis.pbix`** with Power BI Desktop.  
3. **Refresh the Data** source connections if needed.  
4. **(Optional)** Run `Coffee_Shop_Sales_Analysis.sql` in a SQL environment to preprocess or explore the data.  

---

## Data Transformation & Modeling
1. **Data Cleaning**  
   - Remove duplicates, handle missing values, unify date formats.  
2. **Data Modeling**  
   - **Fact Table** (Sales) – Contains date/time, product, price, quantity, location.  
   - **Dimension Tables** (Products, Locations, Calendar).  
3. **Calculated Measures**  
   - **Total Sales**, **Total Orders**, **Total Quantity**.  
   - **Comparison** metrics for month‐over‐month or year‐over‐year.  

---

## Dashboard & Key Insights
1. **KPIs** – Display top‐level metrics (Revenue, Orders, Quantity Sold).  
2. **Sales Trend** – Daily or weekly bars/lines showing how sales evolve.  
3. **Product Categories & Types** – Identify best‐selling product categories (e.g., coffee vs. tea vs. bakery).  
4. **Location Comparison** – Compare performance across multiple stores or regions.  
5. **Hourly/Day Heatmap** – Uncover peak sales hours and days of the week.  

**Example Observations**:
- Busy mornings between 8 AM and 11 AM.  
- Weekends can have fewer transactions but higher average order value.  
- Certain specialty drinks (e.g., espresso) are popular on weekdays.  

---

## How to Use the Dashboard
- **Filters** – Select a month or date range.  
- **Hover** – Reveal tooltips for more detailed data points.  
- **Drill Through** – (If enabled) Right‐click on visuals to drill into products, stores, or dates.  
- **Compare Periods** – Quickly check last month vs. current month.  

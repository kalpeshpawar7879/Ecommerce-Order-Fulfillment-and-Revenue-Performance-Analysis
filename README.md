📦 E-Commerce Order Fulfillment & Revenue Performance Analysis

📌 Project Overview
This project analyzes e-commerce order, revenue, and fulfillment performance using MySQL and Python.
The goal is to evaluate business KPIs, identify revenue drivers, assess operational efficiency, and generate actionable insights to support data-driven decision-making.

This project follows a real-world data analyst workflow:

SQL → KPI extraction → Python analysis → visualization → business insights

🏢 Business Problem
  An e-commerce company wants to:
  Track revenue growth and customer spending behavior
  Measure order fulfillment efficiency
  Identify top products, categories, and customers
  Understand cancellation and delivery delay patterns

🛠 Technologies Used
  Database: MySQL
  Programming Language: Python
  Python Libraries: Pandas, NumPy, Matplotlib, Seaborn
  Tools: Jupyter Notebook, SQL Workbench

🗂 Database Schema

The analysis is based on 5 relational tables:
  customers
  products
  orders
  order_items
  deliveries
These tables are connected using primary and foreign keys, enabling multi-table joins and KPI analysis.

📊 Key KPIs Analyzed (10 KPIs)
  Total Revenue
  Monthly Revenue Trend
  Average Order Value (AOV)
  Order Fulfillment Rate
  Cancellation Rate
  Delivery Successful Rate
  Category-wise Revenue
  Top Revenue-Generating Products
  Repeat Customer Count
  Top Customers by Revenue

🔍 SQL Analysis

Designed and executed business-oriented SQL queries
Used:
  JOINs across multiple tables
  Aggregate functions (SUM, COUNT, AVG)
  Conditional logic (CASE WHEN)
  Date-based analysis for trends
  Extracted KPI-level outputs for further analysis in Python

📈 Python Analysis & Visualization
Imported SQL outputs into Python
Performed:
  KPI validation
  Trend analysis
  Customer and product performance analysis
  Created visualizations:
  Bar charts
  Line charts
  Distribution plots

💡 Key Business Insights
A small number of products contribute to a large portion of revenue.
Repeat customers generate significantly higher revenue.
Cancellation and delivery delays directly impact fulfillment efficiency.
Certain product categories consistently outperform others.

# decodelabs_task

Favour Patani


## Overview

This project analyzes an e-commerce order dataset end-to-end, covering data cleaning, exploratory data analysis (EDA), SQL-based reporting, and an interactive dashboard.

The dataset includes order-level details — status, payment method, product, quantity, pricing, and referral source — used to answer a central business question: **where is revenue succeeding, where is it being lost, and what patterns explain it?**

**Workflow:**
1. **Data Cleaning** — raw order data was cleaned and validated (missing values, invalid entries, and outliers identified and resolved)
2. **Exploratory Data Analysis** — descriptive statistics, correlation analysis, and category breakdowns to understand the shape of the data
3. **SQL Analysis** — a full set of queries against SQL Server to calculate revenue metrics, order status trends, and payment/loss-rate breakdowns at scale
4. **Interactive Dashboard** — a live, filterable dashboard (Excel and web-based) visualizing revenue health, order status, payment methods, and top products

**Key finding:** a significant share of gross revenue is currently unrealized — split between orders that are Cancelled/Returned (lost) and orders still Pending (unresolved) — highlighting where operational attention would have the biggest revenue impact.

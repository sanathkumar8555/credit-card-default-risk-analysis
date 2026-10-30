# Credit Card Default & Risk Analysis

## Project Overview
This project analyses credit card customer data to identify patterns associated with payment defaults and understand customer credit risk.

The analysis focuses on repayment behaviour, customer demographics, credit limits, billing and payment patterns, and risk segmentation using SQL.

## Dataset
- **Source:** [UCI Machine Learning Repository – Default of Credit Card Clients](https://archive.ics.uci.edu/dataset/350/default+payment+of+credit+card+clients)
- **Total Records:** 30,000 customers
- **Target Variable:** Default payment next month
- **Target Values:**
  - 0 – No default
  - 1 – Default

## Tools & Technologies
- MySQL
- SQL
- GitHub

## Business Questions
1. What percentage of customers defaulted?
2. Does repayment behaviour relate to default risk?
3. Which education groups have higher default rates?
4. Which age groups have higher default rates?
5. How do credit limits relate to customer risk?
6. Can customers be segmented into high-, medium-, and low-risk groups?
7. How are consecutive repayment delays associated with defaults?
8. How do monthly payment patterns change over time?

## Key Findings

### 1. Overall Default Rate
- Total customers: 30,000
- Defaulted customers: 6,636
- Overall default rate: **22.12%**

### 2. Repayment Behaviour
- Customers with longer repayment delays showed substantially higher default rates.
- Customers with a two-month payment delay had a 69.14% default rate.
- Customers with longer delays had a 71.92% default rate.

### 3. Education
- High School: 25.16% default rate
- University: 23.73%
- Graduate School: 19.23%

### 4. Age Groups
- Below 25: 27.19% default rate
- Above 55: 26.54%
- Age 25–35: 20.30%

### 5. Risk Segmentation
Using project-defined repayment-status rules:
- High Risk: 57.80% default rate
- Medium Risk: 25.59%
- Low Risk: 13.36%

### 6. Consecutive Repayment Delays
- 5,227 customers met the consecutive-delay condition used in the analysis.
- 53.53% of these customers defaulted.

*Note: These findings show associations in the dataset, not proof of causation. Risk categories are defined for this project and are not official credit classifications.*

## SQL Concepts Used
- SELECT, WHERE, ORDER BY
- Aggregate functions
- GROUP BY and HAVING
- CASE statements
- Common Table Expressions (CTEs)
- JOINs and subqueries
- UNION ALL
- Window functions
- RANK()
- LAG()

## Project Structure
```text
credit-card-default-risk-analysis/
│
├── SQL/
│   └── Credit_card.sql
│
├── Results/
│   └── sql_analysis_results/
│
├── Presentation/
│   └── Credit_Card_Default_Risk_Analysis.pdf
│
└── README.md
```

## Future Improvements
- Perform exploratory data analysis using Python.
- Build an interactive Tableau dashboard.
- Explore additional customer risk patterns and visualizations.

## Author
Sanath Kumar

B.Tech – Computer Science and Engineering

Interested in Data Analytics, Risk Analysis, and Business Intelligence.

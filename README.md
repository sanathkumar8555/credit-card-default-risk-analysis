# Credit Card Default Risk Analysis

## Project Overview

This project analyzes credit card customer data to understand repayment behaviour, identify patterns associated with payment defaults, and evaluate customer credit risk.

Using Python, SQL, and Tableau, the project explores customer demographics, repayment status, payment delays, credit limits, and default behaviour. An interactive Tableau dashboard presents the key findings and allows users to explore different customer segments.

## Project Objectives

- Analyze credit card customer repayment behaviour.
- Identify patterns associated with payment defaults.
- Understand the relationship between repayment delays and default risk.
- Examine customer default behaviour across different age groups.
- Explore credit limits and repayment risk segments.
- Build an interactive dashboard to communicate business insights.

## Dataset Information

- **Dataset:** Default of Credit Card Clients
- **Source:** UCI Machine Learning Repository
- **Total Records:** 30,000 customers
- **Target Variable:** Default Payment Next Month
- **Target Values:**
  - 0 – Non-Default
  - 1 – Default

The dataset contains customer demographic information, credit limits, repayment status, bill amounts, payment amounts, and default information.

## Tools & Technologies

| Tool | Purpose |
|---|---|
| Python | Data cleaning, preprocessing, and exploratory data analysis |
| Pandas | Data manipulation and analysis |
| SQL (MySQL) | Data querying and analysis |
| Jupyter Notebook | Python analysis environment |
| Tableau Public | Interactive dashboard and data visualization |

## Project Workflow

1. **Data Loading:** Imported the credit card default dataset.
2. **Data Cleaning:** Inspected the dataset, checked missing values, and prepared the data for analysis.
3. **Exploratory Data Analysis:** Examined customer demographics, repayment behaviour, credit limits, and default patterns using Python.
4. **SQL Analysis:** Used MySQL queries to analyze customer records, repayment delays, and risk segments.
5. **Data Visualization:** Created charts and an interactive dashboard using Tableau Public.
6. **Insights:** Identified patterns related to customer repayment behaviour and default risk.

## Key Performance Indicators (KPIs)

| Metric | Result |
|---|---:|
| Total Customers | 30,000 |
| Defaulted Customers | 6,636 |
| Non-Defaulted Customers | 23,364 |
| Default Rate | 22.12% |
| Non-Default Rate | 77.88% |

## Key Analysis & Findings

### 1. Customer Default Distribution

Out of 30,000 customers, 6,636 customers defaulted on their payments, representing approximately 22.12% of the dataset.

### 2. Repayment Status Analysis

Customers with higher repayment delays showed higher default rates.

### 3. Repayment Delay Analysis

Default rates increased as the number of delayed repayment months increased.

### 4. Credit Limit vs Repayment Risk

Analyzed customer credit limits against repayment risk categories to explore differences in default behaviour.

### 5. Age Group Analysis

Compared default and non-default distributions across different customer age groups.

### 6. Risk Segmentation

Customers were grouped based on repayment delays:

| Risk Segment | Repayment Delay |
|---|---|
| No Delay | 0 months |
| Low Risk | 1 month |
| Medium Risk | 2–3 months |
| High Risk | 4–6 months |

The analysis showed that customers in higher repayment-risk segments had higher default rates.

## SQL Analysis

SQL was used to perform customer-level and segment-level analysis, including:

- Overall customer default rate.
- Default rate by repayment status.
- Default rate by repayment delay.
- Customer repayment risk segmentation.
- Credit limit and repayment risk analysis.
- Customer default patterns across different groups.

## Tableau Dashboard

An interactive Tableau dashboard was created to present the analysis.

**Dashboard:** Credit Card Default Risk Analysis

[View Interactive Tableau Dashboard](https://public.tableau.com/app/profile/sanath.kumar5850/viz/Credit_Card_Default_Risk_Analysis/Dashboard1)

### Dashboard Features

- Total Customers KPI
- Defaulted Customers KPI
- Default Rate KPI
- Non-Default Rate KPI
- Customer default distribution
- Default rate by September repayment status
- Default rate by number of delayed months
- Credit limit versus repayment risk heatmap
- Default versus non-default by age group

### Interactive Filters

- Age Group
- Education
- Gender
- Repayment Risk Segment

## Business Insights

- Repayment delays are strongly associated with higher customer default rates.
- Customers with multiple delayed payments represent higher repayment risk.
- Customer segmentation helps identify groups with different repayment behaviours.
- Monitoring repayment patterns can support better credit risk assessment and customer risk management.

## Conclusion

This project demonstrates an end-to-end data analytics workflow using Python, SQL, and Tableau.

The analysis highlights customer repayment patterns, identifies higher-risk customer segments, and presents important findings through an interactive dashboard.

The project helped develop practical skills in data cleaning, exploratory data analysis, SQL querying, data visualization, and business insight generation.

## Project Links

- **Tableau Public Dashboard:** [View Dashboard](https://public.tableau.com/app/profile/sanath.kumar5850/viz/Credit_Card_Default_Risk_Analysis/Dashboard1)
- **GitHub Repository:** Credit Card Default Risk Analysis

## Author

**Sanath Kumar**

B.Tech – Computer Science and Engineering

Interests: Data Analytics | SQL | Python | Tableau

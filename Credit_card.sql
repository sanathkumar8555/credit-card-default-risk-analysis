CREATE DATABASE credit_card_risk_analysis;

USE credit_card_risk_analysis;
SELECT COUNT(*) AS total_customers
FROM credit_card_default;

DESCRIBE credit_card_default;

SELECT *
FROM credit_card_default
LIMIT 10;

-- Overall default rate
SELECT
    COUNT(ID) AS total_customers,
    SUM(`default payment next month`) AS defaulted_customers,
    COUNT(ID) - SUM(`default payment next month`) AS non_defaulted_customers,
    ROUND(
        SUM(`default payment next month`) * 100.0 / COUNT(ID),
        2
    ) AS default_percentage
FROM credit_card_default;

 -- Default vs non-default customer counts
 
 SELECT
    `default payment next month` AS default_status,
    COUNT(ID) AS customer_count
FROM credit_card_default
GROUP BY `default payment next month`;

-- Default rate by gender

SELECT
    CASE
        WHEN SEX = 1 THEN 'Male'
        WHEN SEX = 2 THEN 'Female'
    END AS gender,
    COUNT(ID) AS total_customers,
    SUM(`default payment next month`) AS defaulted_customers,
    ROUND(
        SUM(`default payment next month`) * 100.0 / COUNT(ID),
        2
    ) AS default_percentage
FROM credit_card_default
GROUP BY SEX;

-- Default rate by education
SELECT
    education,
    COUNT(id) AS total_customer,
    SUM(`default payment next month`) AS defaulted_customers,
    ROUND(
        SUM(`default payment next month`) * 100.0 / COUNT(id),
        2
    ) AS default_percentage
FROM credit_card_default
GROUP BY education;

-- Default rate by age group
SELECT
    CASE
        WHEN AGE < 25 THEN 'Below 25'
        WHEN AGE <= 35 THEN '25-35'
        WHEN AGE <= 45 THEN '36-45'
        WHEN AGE <= 55 THEN '46-55'
        ELSE 'Above 55'
    END AS age_group,

    COUNT(ID) AS total_customers,

    SUM(`default payment next month`) AS defaulted_customers,

    ROUND(
        SUM(`default payment next month`) * 100.0 / COUNT(ID),
        2
    ) AS default_percentage

FROM credit_card_default

GROUP BY age_group
ORDER BY default_percentage DESC;

-- Default rate by credit limit

SELECT
    CASE
        WHEN LIMIT_BAL < 50000 THEN 'Below 50K'
        WHEN LIMIT_BAL <= 100000 THEN '50K-1 Lakh'
        WHEN LIMIT_BAL <= 200000 THEN '1-2 Lakhs'
        WHEN LIMIT_BAL <= 300000 THEN '2-3 Lakhs'
        ELSE 'Above 3 Lakhs'
    END AS credit_limit_group,

    COUNT(ID) AS total_customers,

    SUM(`default payment next month`) AS defaulted_customers,

    ROUND(
        SUM(`default payment next month`) * 100.0 / COUNT(ID),
        2
    ) AS default_percentage

FROM credit_card_default

GROUP BY
    credit_limit_group
ORDER BY default_percentage DESC;

-- Repayment behaviour and default

SELECT
    CASE
        WHEN PAY_0 = -2 THEN 'No consumption'
        WHEN PAY_0 = -1 THEN 'Paid duly'
        WHEN PAY_0 = 0 THEN 'Revolving credit'
        WHEN PAY_0 = 1 THEN 'Payment delay for one month'
        WHEN PAY_0 = 2 THEN 'Payment delay for two months'
        ELSE 'Higher positive values - longer delays'
    END AS repayment_status,

    COUNT(ID) AS total_customers,
    SUM(`default payment next month`) AS defaulted_customers,

    ROUND(
        SUM(`default payment next month`) * 100.0 / COUNT(ID),
        2
    ) AS default_percentage

FROM credit_card_default
GROUP BY repayment_status
ORDER BY default_percentage DESC;

-- Bill amount vs payment amount
SELECT
    CASE
        WHEN BILL_AMT1 <= 0 THEN 'No Bill'
        WHEN PAY_AMT1 = 0 THEN 'No Payment'
        WHEN PAY_AMT1 < BILL_AMT1 THEN 'Partial Payment'
        ELSE 'Full or Excess Payment'
    END AS payment_category,

    COUNT(ID) AS total_customers,

    SUM(`default payment next month`) AS defaulted_customers,

    ROUND(
        SUM(`default payment next month`) * 100.0 / COUNT(ID),
        2
    ) AS default_percentage

FROM credit_card_default

GROUP BY payment_category
ORDER BY default_percentage DESC;

-- Customer Risk Segmentation

WITH customer_risk AS (
    SELECT
        ID,
        LIMIT_BAL,
        `default payment next month` AS default_status,

        CASE
            WHEN PAY_0 >= 2 OR PAY_2 >= 2 THEN 'High Risk'
            WHEN PAY_0 = 1 OR PAY_2 = 1 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS risk_category

    FROM credit_card_default
),

risk_summary AS (
    SELECT
        risk_category,
        COUNT(ID) AS total_customers,
        SUM(default_status) AS defaulted_customers,

        ROUND(
            SUM(default_status) * 100.0 / COUNT(ID),
            2
        ) AS default_percentage,

        ROUND(AVG(LIMIT_BAL), 2) AS average_credit_limit

    FROM customer_risk
    GROUP BY risk_category
)

SELECT
    risk_category,
    total_customers,
    defaulted_customers,
    default_percentage,
    average_credit_limit,

    RANK() OVER (
        ORDER BY default_percentage DESC
    ) AS risk_rank

FROM risk_summary;

-- Consecutive Repayment Delays
WITH monthly_repayments AS (

    SELECT ID, 1 AS month_order, 'April' AS month_name,
           PAY_6 AS repayment_status,
           `default payment next month` AS default_status
    FROM credit_card_default

    UNION ALL

    SELECT ID, 2, 'May', PAY_5,
           `default payment next month`
    FROM credit_card_default

    UNION ALL

    SELECT ID, 3, 'June', PAY_4,
           `default payment next month`
    FROM credit_card_default

    UNION ALL

    SELECT ID, 4, 'July', PAY_3,
           `default payment next month`
    FROM credit_card_default

    UNION ALL

    SELECT ID, 5, 'August', PAY_2,
           `default payment next month`
    FROM credit_card_default

    UNION ALL

    SELECT ID, 6, 'September', PAY_0,
           `default payment next month`
    FROM credit_card_default
),

repayment_history AS (
    SELECT
        ID,
        month_name,
        month_order,
        repayment_status,
        default_status,

        LAG(repayment_status) OVER (
            PARTITION BY ID
            ORDER BY month_order
        ) AS previous_month_status

    FROM monthly_repayments
),

consecutive_delays AS (
    SELECT
        ID,
        month_name,
        repayment_status,
        previous_month_status,
        default_status

    FROM repayment_history

    WHERE repayment_status > 0
      AND previous_month_status > 0
),

customer_delay_summary AS (
    SELECT
        ID,
        MAX(default_status) AS default_status,
        COUNT(*) AS consecutive_delay_occurrences

    FROM consecutive_delays
    GROUP BY ID
)

SELECT
    COUNT(ID) AS customers_with_consecutive_delays,

    SUM(default_status) AS defaulted_customers,

    ROUND(
        SUM(default_status) * 100.0 / COUNT(ID),
        2
    ) AS default_percentage,

    ROUND(
        AVG(consecutive_delay_occurrences),
        2
    ) AS average_consecutive_delay_occurrences

FROM customer_delay_summary;
-- — Compare Monthly Payment Amounts

WITH monthly_payments AS (

    SELECT ID, 1 AS month_order, 'April' AS month_name,
           PAY_AMT6 AS payment_amount,
           `default payment next month` AS default_status
    FROM credit_card_default

    UNION ALL

    SELECT ID, 2, 'May', PAY_AMT5,
           `default payment next month`
    FROM credit_card_default

    UNION ALL

    SELECT ID, 3, 'June', PAY_AMT4,
           `default payment next month`
    FROM credit_card_default

    UNION ALL

    SELECT ID, 4, 'July', PAY_AMT3,
           `default payment next month`
    FROM credit_card_default

    UNION ALL

    SELECT ID, 5, 'August', PAY_AMT2,
           `default payment next month`
    FROM credit_card_default

    UNION ALL

    SELECT ID, 6, 'September', PAY_AMT1,
           `default payment next month`
    FROM credit_card_default
),

payment_comparison AS (
    SELECT
        ID,
        month_name,
        month_order,
        payment_amount,
        default_status,

        LAG(payment_amount) OVER (
            PARTITION BY ID
            ORDER BY month_order
        ) AS previous_month_payment

    FROM monthly_payments
),

payment_trends AS (
    SELECT
        ID,
        month_name,
        payment_amount,
        previous_month_payment,
        default_status,

        CASE
            WHEN previous_month_payment IS NULL THEN 'First Month'
            WHEN payment_amount > previous_month_payment THEN 'Payment Increased'
            WHEN payment_amount < previous_month_payment THEN 'Payment Decreased'
            ELSE 'Payment Unchanged'
        END AS payment_trend

    FROM payment_comparison
)

SELECT
    payment_trend,
    COUNT(*) AS total_records,
    COUNT(DISTINCT ID) AS unique_customers,
    SUM(default_status) AS defaulted_records,

    ROUND(
        SUM(default_status) * 100.0 / COUNT(*),
        2
    ) AS default_percentage,

    ROUND(AVG(payment_amount), 2) AS average_payment

FROM payment_trends
GROUP BY payment_trend
ORDER BY default_percentage DESC;

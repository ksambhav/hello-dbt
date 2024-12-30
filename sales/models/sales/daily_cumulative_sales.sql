WITH ordered_data AS (
    SELECT
        order_date_time,
        amount
    FROM {{ ref('raw_orders') }}
),
cumulative_data AS (
    SELECT distinct
        date(order_date_time) as business_date,
        SUM(amount) OVER (partition by date(order_date_time)) AS daily_sales_total
    FROM ordered_data
)
SELECT *
FROM cumulative_data

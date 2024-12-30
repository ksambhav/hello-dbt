WITH sales AS (
    SELECT
        order_date_time,
        amount, category
    FROM {{ ref('raw_orders') }}
)
select distinct
date(order_date_time) as business_date,
category,
sum(amount) over(partition by category) as total_sales
from sales
order by business_date,category,total_sales
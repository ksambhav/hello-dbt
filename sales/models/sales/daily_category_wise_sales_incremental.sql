--https://docs.getdbt.com/docs/build/incremental-models
{{ config(materialized='incremental') }}
WITH sales AS (
    SELECT
        date(order_date_time) as sales_date,
        amount,
        category
    FROM {{ ref('raw_orders') }}
)
select distinct
sales_date as business_date,
category,
sum(amount) over(partition by category) as total_sales
from sales
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where sales_date > (SELECT coalesce(MAX(business_date),'1970-01-01') AS max_order_date FROM {{ this }} )
{% endif %}

{{ config(materialized='incremental') }}
select
business_date, sum(total_sales) as daily_sales
from {{ref('daily_category_wise_sales_incremental')}}
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where business_date > (SELECT coalesce(MAX(business_date),'1970-01-01') AS max_order_date FROM {{ this }} )
{% endif %}
group by business_date
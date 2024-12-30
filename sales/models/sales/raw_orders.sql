SELECT
id,
category,
amount,
order_date as order_date_time
FROM {{ source('raw_orders','t_orders') }}
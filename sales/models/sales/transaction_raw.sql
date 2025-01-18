select *
from {{ source('raw_orders','t_transaction') }}
{{
    config(
        materialized='incremental',
        unique_key='rrn',
        incremental_strategy ='merge'
    )
}}

select *
from {{ ref("transaction_raw") }}
    {% if is_incremental() %}
where id > (select max(id) from {{ this }})
{%  endif %}
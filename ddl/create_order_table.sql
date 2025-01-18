create table dbt.t_orders
(
    id         serial primary key,
    category   varchar(32) not null,
    amount     integer     not null,
    order_date timestamp default current_timestamp
);


insert into dbt.t_orders (category, amount, order_date)
values ('APPLIANCES', 32422, NOW() - INTERVAL '96 DAY'),
       ('LIQUOR', 10030, NOW() - INTERVAL '96 DAY'),
       ('LIQUOR', 1400, NOW() - INTERVAL '96 DAY'),
       ('TOOLS', 1400, NOW() - INTERVAL '96 DAY'),
       ('FURNITURE', 1400, NOW() - INTERVAL '96 DAY'),
       ('FURNITURE', 1400, NOW() - INTERVAL '96 DAY'),
       ('FURNITURE', 1400, NOW() - INTERVAL '96 DAY'),
       ('FURNITURE', 1400, NOW() - INTERVAL '96 DAY'),
       ('FURNITURE', 3, NOW() - INTERVAL '96 DAY'),
       ('APPAREL', 1040, NOW() - INTERVAL '96 DAY'),
       ('APPLIANCES', 100, NOW() - INTERVAL '96 DAY'),
       ('LIQUOR', 12950, NOW() - INTERVAL '96 DAY'),
       ('LIQUOR', 650, NOW() - INTERVAL '96 DAY'),
       ('BOOKS', 650, NOW() - INTERVAL '96 DAY'),
       ('HOME_FURNISHING', 650, NOW() - INTERVAL '96 DAY'),
       ('LIQUOR', 120, NOW() - INTERVAL '96 DAY'),
       ('BOOKS', 1230, NOW() - INTERVAL '96 DAY'),
       ('MUSICAL_INSTRUMENTS', 1230, NOW() - INTERVAL '96 DAY'),
       ('APPLIANCES', 1030, NOW() - INTERVAL '96 DAY');

create index category_idx on dbt.t_orders (category);
create index order_date_idx on dbt.t_orders (order_date);


create or replace view total_sales as
(
select category,
       sum(amount) over ()                      as total_sales,
       sum(amount) over (partition by category) as total_category_sales
from dbt.t_orders

    );

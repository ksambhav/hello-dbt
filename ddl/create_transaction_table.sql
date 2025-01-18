drop table if exists dbt.t_transaction;

create table dbt.t_transaction
(
    id     serial primary key,
    rrn    varchar(32),
    amount numeric
);



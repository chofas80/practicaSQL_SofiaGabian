-- Generar el campo masiva_lg
-- Queremos tener un registro por cada llamada y un flag que indique si la llamada ha pasado por el módulo AVERIA_MASIVA. 
-- Si es así indicarlo con un 1 de lo contrario con un 0.

with paso_averia_masiva as(
  select
    distinct ivr_id
  from `keepcoding.ivr_modules`
  where upper(module_name) = 'AVERIA_MASIVA'
)
select
  mds.ivr_id
  , if(pas.ivr_id is null, 0, 1) as masiva_lg
from `keepcoding.ivr_modules` mds 
left join paso_averia_masiva pas
on mds.ivr_id = pas.ivr_id
group by mds.ivr_id, pas.ivr_id;
-- Generar el campo vdn_aggregation
-- Es una generalización del campo vdn_label. Si vdn_label empieza por ATC pondremos FRONT, si empieza por TECH pondremos TECH, 
-- si es ABSORPTION dejaremos ABSORPTION y si no es ninguna de las anteriores pondremos RESTO.

select
  calls_ivr_id
  , case
      when upper(calls_vdn_label) like 'ATC%' then 'FRONT'
      when upper(calls_vdn_label) like 'TECH%' then 'TECH'
      when upper(calls_vdn_label) = 'ABSORPTION' then 'ABSORPTION'
      else 'RESTO' 
    end as vdn_aggregation
from `keepcoding.ivr_detail`
group by calls_ivr_id, calls_vdn_label;


select
  ivr_id as calls_ivr_id
  , case
      when upper(vdn_label) like 'ATC%' then 'FRONT'
      when upper(vdn_label) like 'TECH%' then 'TECH'
      when upper(vdn_label) = 'ABSORPTION' then 'ABSORPTION'
      else 'RESTO' 
    end as vdn_aggregation
from `keepcoding.ivr_calls`;
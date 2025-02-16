-- Generar el campo customer_phone
-- Queremos tener un registro por cada llamada y un sólo cliente identificado para la misma.

select
  ivr_id
  , customer_phone
from keepcoding.ivr_steps
where upper(customer_phone) != 'UNKNOWN'
group by ivr_id, customer_phone;
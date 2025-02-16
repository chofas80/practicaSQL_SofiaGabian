-- Generar el campo billing_account_id
-- Queremos tener un registro por cada llamada y un sólo cliente identificado para la misma.

select
  ivr_id
  , billing_account_id
from keepcoding.ivr_steps
where upper(billing_account_id) != 'UNKNOWN'
group by ivr_id, billing_account_id;
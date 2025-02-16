-- Generar el campo info_by_phone_lg
-- Queremos tener un registro por cada llamada y un flag que indique si la llamada pasa por el step de nombre CUSTOMERINFOBYPHONE.TX y su step_result es OK, 
-- quiere decir que hemos podido identificar al cliente a través de su número de teléfono. En ese caso pondremos un 1 en este flag, de lo contrario llevará un 0.

with cliente_telefono as(
  select
    distinct ivr_id
  from `keepcoding.ivr_steps`
  where upper(step_name) = 'CUSTOMERINFOBYPHONE.TX' 
        and upper(step_result) = 'OK'
)
select
  stp.ivr_id
  , if(cli.ivr_id is null, 0, 1) as info_by_phone_lg
from `keepcoding.ivr_steps` stp 
left join cliente_telefono cli
on stp.ivr_id = cli.ivr_id
group by stp.ivr_id, cli.ivr_id;
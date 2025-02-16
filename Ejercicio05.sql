-- Generar los campos document_type y document_identification
-- Queremos tener un registro por cada llamada y un sólo cliente identificado para la misma.

select
  ivr_id
  , document_type
  , document_identification
from keepcoding.ivr_steps
where upper(document_type) != 'UNKNOWN' 
      and upper(document_identification) != 'UNKNOWN' 
group by ivr_id, document_type, document_identification;
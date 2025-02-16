-- Crear tabla de vr_detail
-- Los campos calls_start_date_id y calls_end_date_id son campos de fecha calculados, del tipo yyyymmdd. Por ejemplo, el 1 de enero de 2023 sería 20230101.

create table `keepcoding.ivr_detail` as (
    select 
       cal.ivr_id as calls_ivr_id,
       cal.phone_number as calls_phone_number,
       cal.ivr_result as calls_ivr_result,
       cal.vdn_label as calls_vdn_label,
       cal.start_date as calls_start_date,
       concat(format_timestamp("%Y",cal.start_date),
              format_timestamp("%m",cal.start_date),
              format_timestamp("%d",cal.start_date)) as calls_start_date_id,
       cal.end_date as calls_end_date,
       concat(format_timestamp("%Y",cal.end_date),
              format_timestamp("%m",cal.end_date),
              format_timestamp("%d",cal.end_date)) as calls_end_date_id,
       cal.total_duration as calls_total_duration,
       cal.customer_segment as calls_customer_segment,
       cal.ivr_language as calls_ivr_language,
       cal.steps_module as calls_steps_module,
       cal.module_aggregation as calls_module_aggregation,
       mol.module_sequece as module_sequence,
       mol.module_name as module_name,
       mol.module_duration as module_duration,
       mol.module_result as module_result,
       ste.step_sequence as step_sequence,
       ste.step_name as step_name,
       ste.step_result as step_result,
       ste.step_description_error as step_description_error,
       "" as document_type,
       "" as document_identification,
       "" as customer_phone,
       "" as billing_account_id
    from `keepcoding.ivr_calls` cal 
    inner join `keepcoding.ivr_modules` mol
    on cal.ivr_id = mol.ivr_id
    inner join `keepcoding.ivr_steps` ste
    on mol.ivr_id = ste.ivr_id and mol.module_sequece = ste.module_sequece
)



-- Crear tabla vr_summary

with paso_averia_masiva as(
  select
    distinct ivr_id
  from `keepcoding.ivr_modules`
  where upper(module_name) = 'AVERIA_MASIVA'
), 
cliente_telefono as(
  select
    distinct ivr_id
  from `keepcoding.ivr_steps`
  where upper(step_name) = 'CUSTOMERINFOBYPHONE.TX' and upper(step_result) = 'OK'
), 
cliente_dni as(
  select
    distinct ivr_id
  from `keepcoding.ivr_steps`
  where upper(step_name) = 'CUSTOMERINFOBYDNI.TX' and upper(step_result) = 'OK'
), 
llamadas_24 as(
  SELECT 
    ivr_id
    , if(timestamp_diff(timestamp(start_date), 
                        timestamp(LAG(start_date) OVER(PARTITION BY phone_number ORDER BY start_date)),
                        hour) <= 24, 1 ,0) as repeated_phone_24H
    , if(timestamp_diff(timestamp(LEAD(start_date) OVER(PARTITION BY phone_number ORDER BY start_date)), 
                        timestamp(start_date), 
                        hour) <= 24, 1 ,0) as cause_recall_phone_24H
  FROM `keepcoding.ivr_calls`
)

create table keepcoding.ivr_summary as(
    select 
      distinct det.calls_ivr_id as ivr_id,
      det.calls_phone_number as phone_number,
      det.calls_ivr_result as ivr_result,
      case
        when upper(det.calls_vdn_label) like 'ATC%' then 'FRONT'
        when upper(det.calls_vdn_label) like 'TECH%' then 'TECH'
        when upper(det.calls_vdn_label) = 'ABSORPTION' then 'ABSORPTION'
        else 'RESTO' 
      end as vdn_aggregation, 
      det.calls_start_date as start_date,
      det.calls_end_date as end_date,
      det.calls_total_duration as total_duration,
      det.calls_customer_segment as customer_segment,
      det.calls_ivr_language as ivr_language,
      det.calls_steps_module as steps_module,
      det.calls_module_aggregation as module_aggregation,
      ste.document_type as document_type, 
      ste.document_identification as document_identification,
      ste.customer_phone as customer_phone,
      ste.billing_account_id as billing_account_id,
      if(mas.ivr_id is null, 0, 1) as masiva_lg,
      if(tel.ivr_id is null, 0, 1) as info_by_phone_lg,
      if(dni.ivr_id is null, 0, 1) as info_by_dni_lg,
      lla.repeated_phone_24H as repeated_phone_24H,
      lla.cause_recall_phone_24H as cause_recall_phone_24H
    from `keepcoding.ivr_detail` det 
    inner join `keepcoding.ivr_steps` ste
      on det.calls_ivr_id = ste.ivr_id 
        and ((upper(ste.document_type) != 'UNKNOWN' and ste.document_type is not null and upper(ste.document_identification) != 'UNKNOWN' and ste.document_identification is not null) 
              or (upper(ste.customer_phone) != 'UNKNOWN' and ste.customer_phone is not null)
              or (upper(ste.billing_account_id) != 'UNKNOWN' and ste.billing_account_id is not null))
    left join paso_averia_masiva mas
      on det.calls_ivr_id = mas.ivr_id
    left join cliente_telefono tel
      on det.calls_ivr_id = tel.ivr_id
    left join cliente_dni dni
      on det.calls_ivr_id = dni.ivr_id
    left join llamadas_24 lla
      on det.calls_ivr_id = lla.ivr_id
)
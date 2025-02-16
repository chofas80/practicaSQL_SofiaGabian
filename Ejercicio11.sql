-- Gerar los campos repeated_phone_24H, cause_recall_phone_24H.
-- Queremos tener un registro por cada llamada y dos flags que indiquen si el calls_phone_number tiene una llamada las anteriores 24 horas o en las siguientes 24 horas. 
-- En caso afirmativo pondremos un 1 en estos flag, de lo contrario llevará un 0.

SELECT 
    ivr_id
    , if(timestamp_diff(timestamp(start_date), 
                        timestamp(LAG(start_date) OVER(PARTITION BY phone_number ORDER BY start_date)),
                        hour) <= 24, 1 ,0) as repeated_phone_24H
    , if(timestamp_diff(timestamp(LEAD(start_date) OVER(PARTITION BY phone_number ORDER BY start_date)), 
                        timestamp(start_date), 
                        hour) <= 24, 1 ,0) as cause_recall_phone_24H
FROM `keepcoding.ivr_calls`
order by phone_number, start_date asc;
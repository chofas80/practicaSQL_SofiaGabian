-- Crear función de limpieza de enteros.
-- Crear una función de limpieza de enteros por la que si entra un null la función devuelva el valor -999999.

create function `keepcoding.clean_integer`(x any type)
as (ifnull(x, -999999));

select
  `keepcoding.clean_integer`(123) as integer_put,
  `keepcoding.clean_integer`(123.23) as float_put,
  `keepcoding.clean_integer`(null) as null_put;
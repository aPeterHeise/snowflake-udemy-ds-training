use database demo;
use warehouse public;


---- define and create the procedure
create or replace procedure proc_addone(i int)
    returns int
    language python
    runtime_version = '3.8'
    handler = 'addone_py'
    packages = ('snowflake-snowpark-python')
as
$$
def addone_py(snowflake_session, input_int_py):
  return input_int_py + 1
$$;


call proc_addone(5);
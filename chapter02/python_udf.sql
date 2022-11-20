use database demo;
use warehouse public;


---- define and create the function
create or replace function udf_addone(i int)
    returns int
    language python
    runtime_version = '3.8'
    handler = 'addone_py'
as
$$
def addone_py(i):
  return i+1
$$;

select udf_addone(5);
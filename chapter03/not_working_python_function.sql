---
--- Remote function on Snowflake to call an external URL.
--- Spoiler: this does not work. 
--- Reason: Snowflake workers don't have any external network access.
---
create or replace function py_xml_http_request(theUrlParameter varchar)
  returns variant
  language python
  runtime_version = '3.8'
  packages = ('requests')
  handler = 'udf'
as $$
import requests
def udf(theUrlParameter_py: str):
    r = requests.get("https://xxx-ml-endpoint.azurewebsites.net/api/Inference?parameter=" + theUrlParameter_py)
    return r.content
$$;

select py_xml_http_request('parameter');

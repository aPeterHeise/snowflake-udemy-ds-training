---
--- Remote function on Snowflake to call an external URL.
--- Spoiler: this does not work. 
--- Reason: Snowflake workers don't have any external network access.
---
create or replace function js_xml_http_request(theUrlParameter  varchar)
  returns variant
  language javascript
  strict
  as '
    var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;
    xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", "https://xxx-ml-endpoint.azurewebsites.net/api/Inference?parameter=" + theUrlParameter, false );
    xmlHttp.send( null );
    return xmlHttp.responseText;
  ';

select js_xml_http_request('parameter');

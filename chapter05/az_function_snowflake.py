import json
import logging

import azure.functions as func

# # 
# # Run the following code to run this in Snowflake:
#
# create or replace api integration az_function_integration
#    api_provider = azure_api_management
#    azure_tenant_id = 'xxx-yyy-zzz'
#    azure_ad_application_id = 'aaa-bbb-ccc
#    api_allowed_prefixes = ('https://xxx-yyy.azure-api.net/')
#    enabled = true;
#
# create or replace external function sf_ext_fct_model_inference(name varchar)
#    returns variant
#    api_integration = az_function_integration
#    as 'https://xxx-yyy.azure-api.net/aaa/bbb';
#    
# select sf_ext_fct_model_inference('Elon Musk');
#

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    ## More parameters see here, https://docs.snowflake.com/en/sql-reference/external-functions-data-format.html
    # sf_external_function_name = req.params.get('sf-external-function-name')  

    data = req.params.get('data')
    if not data:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            data = req_body.get('data')

    if data:

        retVal= { "result" : f"Hello {data[0][1]}, good to see you here!" }
    
        ## See here for format: https://docs.snowflake.com/en/sql-reference/external-functions-data-format.html
        return func.HttpResponse(
            json.dumps({"data": [[0, retVal]]}),
            mimetype = 'application/json',
            charset = 'utf-8'
        )

    else:
        return func.HttpResponse(
             "Please pass data in the request body for a personalized response.",
             status_code = 400
        )

import json
import logging
import os
import boto3
import sys
from boto3.dynamodb.conditions import Key, Attr
logger = logging.getLogger()
logger.setLevel(logging.INFO)
db_client = boto3.resource('dynamodb',region_name='us-east-1')

def lambda_handler(event, context):
    table=db_client.Table('message')
    logger.info('## ENVIRONMENT VARIABLES')
    logger.info(os.environ)
    logger.info('## EVENT')
    logger.info(event)
    fromid=event["queryStringParameters"]['fromid']
    toid=event["queryStringParameters"]['toid']
    result=[]
    response = table.scan(FilterExpression=Attr('fromID').eq(fromid) and Attr('toID').eq(toid))
    if "Items" in response:
        result=response['Items']+result
    print("response1")
    print(response['Items'])
    response2 = table.scan(FilterExpression=Attr('toID').eq(fromid) and Attr('fromID').eq(toid))
    if "Items" in response:
        result=response2['Items']+result
    print(result)
    result=sorted(result, key = lambda i: i['datesend'])

    
    return {
        'statusCode': 200,
        'body': json.dumps(result)
    }

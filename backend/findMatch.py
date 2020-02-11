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
    logger.info('## ENVIRONMENT VARIABLES')
    logger.info(os.environ)
    logger.info('## EVENT')
    logger.info(event)
    filter=event["queryStringParameters"]
    print(filter)
    table=db_client.Table('UserTable')
    #print(table)
    response = table.scan(FilterExpression=Attr('country').eq(filter['country']) or Attr('city').eq(filter['city']) or Attr('gender').eq(filter['gender']))
    #result=db_client.get_item(TableName='UserTable',Key={'country':{'S':"China"}})
    print(response['Items'])
    return {
        'statusCode': 200,
        'body': json.dumps(response["Items"])
    }

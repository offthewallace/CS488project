import json
import boto3
import os
import sys
import logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3_client = boto3.client('dynamodb')

def lambda_handler(event, context):
    logger.info('## ENVIRONMENT VARIABLES')
    logger.info(os.environ)
    logger.info('## EVENT')
    logger.info(event)
    #res = json.loads(event['body']) 

    #print()
    #s3_client.put_item(TableName='testtable', Item={'name':{'S':res['usernames']},'passwords':{'S':res['passwords']}})
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!!!!')
    }

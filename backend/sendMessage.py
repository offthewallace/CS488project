import json
import logging
import os
import boto3
import sys

import datetime

import random

from boto3.dynamodb.conditions import Key, Attr
logger = logging.getLogger()
logger.setLevel(logging.INFO)
db_client = boto3.client('dynamodb',region_name='us-east-1')


def lambda_handler(event, context):
    logger.info('## ENVIRONMENT VARIABLES')
    logger.info(os.environ)
    logger.info('## EVENT')
    logger.info(event)
    dict2=event
    
    datetime_object = datetime.datetime.now()
    date=str(datetime_object).split(".")[0]
    db_client.put_item(TableName='message', Item={'IDINDEX':{'S':str(random.getrandbits(100))},'fromID':{'S':event['fromUserId']},'toID':{'S':event['toUserId']}, 'message':{'S':event['message']},'datesend':{'S':date}})
    return {
        'statusCode': 200,
        'body': json.dumps("fuck off")
    }

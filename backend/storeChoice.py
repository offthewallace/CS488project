import json
import boto3
import os
import sys
import logging
from boto3.dynamodb.conditions import Key, Attr
logger = logging.getLogger()
logger.setLevel(logging.INFO)
s3_client = boto3.client('dynamodb')
db_client = boto3.resource('dynamodb')

def lambda_handler(event, context):
    logger.info('## ENVIRONMENT VARIABLES')
    logger.info(os.environ)
    logger.info('## EVENT')
    logger.info(event)
    #res = json.loads(event) 

    #print()
    table = db_client.Table('likes')
    response = table.get_item(Key={'username': event['fromUserId']})
    if not response['Item']:
        s3_client.put_item(TableName='likes', Item={'username':{'S':event['fromUserId']},str(event['toUserId']):{'S':str(event['likeValue'])}})
    else:
        temp=[]
        temp.append(str(event['toUserId']))
        ExpressionAttributeNames = {'#service_name': str(event['toUserId'])}
        query="SET #service_name = :r"
        response = table.update_item(Key={'username': event['fromUserId']}, UpdateExpression=query, ExpressionAttributeValues={":r" : str(event['likeValue'])},ExpressionAttributeNames = {'#service_name': str(event['toUserId'])},ReturnValues="UPDATED_NEW")
    #for k in table.get_item(Key={'username': event['fromUserId']})['Item']:
        #if not k == event['fromUserId']:
            #print(k)
    return {
        'statusCode': 200,
        'body': json.dumps('test work!!!!')
    }


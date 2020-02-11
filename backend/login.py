import json
import boto3
import os
import sys
import logging
from datetime import date
#from collection import defaultdict
logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3_client = boto3.client('dynamodb')

def lambda_handler(event, context):
    logger.info('## ENVIRONMENT VARIABLES')
    logger.info(os.environ)
    logger.info('## EVENT')
    logger.info(event)
    user = event
    print(event)
    userItem=s3_client.get_item(TableName='Registration',Key={'username':{'S':user['username']}})['Item']
    # here is onlyt considering the best case instead of the other user case 
    print(userItem)
    if userItem['username']['S']==user['username'] and userItem['passwords']['S']==user['password']:
        returnItem= s3_client.get_item(TableName='UserTable',Key={'username':{'S':user['username']}})['Item']
    
    returndict={k:returnItem[k]['S'] for k in returnItem}
    today=date.today()
    if len(returndict['birth'])>2:
    
        returndict['birth']=str(today.year-int(returndict['birth'].split("-")[0]))
    #print(returnItem['image']['L'])
    #returndict['image']=returnItem['image']['L']
    print(returndict)
    #s3_client.put_item(TableName='Registration', Item={'username':{'S':res['email']},'passwords':{'S':res['password']}})
    #s3_client.put_item(TableName='UserTable',Item={'username':{'S':res['email']},'displayname':{'S':res['name']+' '+res['surname']},'gender':{'S':res['gender']},'country':{'S':res['country']},'city':{'S':res['city']},'birth':{'S':res['birth']}})
    return {
        'statusCode': 200,
        'user': json.dumps(returndict)
    }


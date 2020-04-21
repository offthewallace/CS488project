import json
import boto3
import os
import sys
import logging
import random
logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3_client = boto3.client('dynamodb')

def lambda_handler(event, context):
    logger.info('## ENVIRONMENT VARIABLES')
    logger.info(os.environ)
    logger.info('## EVENT')
    logger.info(event)
    res = event

    #print()
    s3_client.put_item(TableName='Registration', Item={'username':{'S':res['email']},'passwords':{'S':res['password']}})
    #s3_client.put_item(TableName='UserTable2',Item={'username':{'S':res['email']},'displayname':{'S':res['name']+' '+res['surname']},'gender':{'S':res['gender']},'country':{'S':res['country']},'city':{'S':res['city']},'birth':{'S':res['birth']}})
    s3_client.put_item(TableName='UserTable',Item={"username":{'S':res['email']}, "name":{'S':res['name']},'surname':{'S':res['surname']}, 'password':{'S':res['password']},'password2':{'S':res['password2']},'gender':{'S':res['gender']},'country':{'S':res['country']},'city':{'S':res['city']},'birth':{'S':res['birth']}, 'like':{'S':" "},'bio':{'S':' '}, 'image':{'S':res['image']} })
    return {
        'statusCode': 200,
        'body': json.dumps('test work!!!!')
    }


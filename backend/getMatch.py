import json
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
    table1=db_client.Table('likes')
    table2=db_client.Table("UserTable")
    id =event['queryStringParameters']['key']
    #print(id)
    userList=[]
    matchDict=table1.get_item(Key={'username': id})['Item']
    for k in matchDict:
        if not k ==id and matchDict[k]=="1":
            #print(k)
            response=table1.get_item(Key={'username': k})
            #print(response)
            if "Item" in response:
                if response['Item'][id]=="1":
                    userList.append(table2.get_item(Key={'username': k})['Item'])
                    
            
            
    
    return {
        'statusCode': 200,
        'body': json.dumps(userList)
    }

import json
import boto3

db_client = boto3.client('dynamodb')
def lambda_handler(event, context):
    print(event)
    #table =db_client.Table('my_table')
    userItem=db_client.get_item(TableName='UserTable',Key={'username':{'S':event['previousKey']}})['Item']
    print(userItem)
    for k in event:
        if not k =="previousKey":
            userItem[k]['S']=str(event[k])
    print(userItem)
    db_client.put_item(TableName='UserTable',Item=userItem)
    
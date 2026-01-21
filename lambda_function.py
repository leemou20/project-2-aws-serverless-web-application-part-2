import json
import os
import boto3

def lambda_handler(event, context):
    try:
        httpmethod = event.get('httpMethod')

        # For HTTP API (v2)
        if not httpmethod:
            httpmethod = event['requestContext']['http']['method']

        mypage = page_router(
            httpmethod,
            event.get('queryStringParameters'),
            event.get('body')
        )

        return mypage

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }

def page_router(httpmethod, querystring, formbody):
    if httpmethod == 'GET':
        try:
            with open('contactus.html', 'r') as htmlFile:
                htmlContent = htmlFile.read()
            return {
                'statusCode': 200,
                'headers': {"Content-Type": "text/html"},
                'body': htmlContent
            }
        except Exception as e:
            return {
                'statusCode': 500,
                'body': json.dumps({'error': str(e)})
            }

    elif httpmethod == 'POST':
        try:
            insert_record(formbody)
            with open('success.html', 'r') as htmlFile:
                htmlContent = htmlFile.read()
            return {
                'statusCode': 200,
                'headers': {"Content-Type": "text/html"},
                'body': htmlContent
            }
        except Exception as e:
            return {
                'statusCode': 500,
                'body': json.dumps({'error': str(e)})
            }

def insert_record(formbody):
    import uuid

    # Generate unique primary key
    item_id = str(uuid.uuid4())

    # Convert form data to PartiQL format
    formbody = formbody.replace("=", "' : '")
    formbody = formbody.replace("&", "', '")

    # FINAL CORRECT PartiQL (single item only)
    formbody = (
        "INSERT INTO leemou VALUE {"
        "'id' : '" + item_id + "', '"
        + formbody +
        "'}"
    )

    client = boto3.client('dynamodb')
    response = client.execute_statement(Statement=formbody)
    return response
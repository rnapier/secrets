def lambda_handler(event, context):
    keys = ['TYYLWKMUAPZHLYXJMPUW', 's3kret', 'TlqI7CIrzHp4/pY1wpRErEytlqs0IKeS4BzD9/3quqQ=']
    
    query = event.get('queryStringParameters')
    if query is not None and query.get('token') in keys:
        return { 'statusCode': 200, 'body': 'SUCCESS' }

    return { 'statusCode': 401, 'body': 'GO AWAY!' }

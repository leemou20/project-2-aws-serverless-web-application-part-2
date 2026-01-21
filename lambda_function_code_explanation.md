# Lambda Function – Step-by-Step Python Code Explanation

This document explains the **lambda_function.py** file line by line in very simple language.
It is written for **beginners** who are new to AWS Lambda, Python, and serverless concepts.

---

## 1️⃣ Importing Required Libraries

```python
import json
import boto3
import urllib.parse
```

### Explanation:
- **json** → Used to format error messages
- **boto3** → AWS SDK for Python (used to access DynamoDB)
- **urllib.parse** → Used to safely read form data sent from HTML

---

## 2️⃣ Connecting to DynamoDB

```python
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('leetable')
```

### Explanation:
- Creates a connection to DynamoDB
- Connects specifically to the table named **leetable**
- This table stores the contact form data

---

## 3️⃣ Lambda Entry Point

```python
def lambda_handler(event, context):
```

### Explanation:
- This is the **main function** AWS Lambda runs
- `event` → contains request data from API Gateway
- `context` → runtime information (not used here)

---

## 4️⃣ Detecting HTTP Method (GET / POST)

```python
method = event.get('httpMethod')
if not method:
    method = event['requestContext']['http']['method']
```

### Explanation:
- REST API uses `httpMethod`
- HTTP API uses `requestContext.http.method`
- This logic ensures compatibility with both

---

## 5️⃣ Handling GET Requests

```python
if method == 'GET':
    return load_page('contactus.html')
```

### What Happens:
- Loads **contactus.html**
- Displays the contact form in the browser

---

## 6️⃣ Handling POST Requests

```python
if method == 'POST':
    data = urllib.parse.parse_qs(event['body'])
    save_data(data)
    return load_page('success.html')
```

### What Happens:
1. Reads submitted form data
2. Saves data into DynamoDB
3. Displays success page

---

## 7️⃣ Loading HTML Pages

```python
def load_page(file):
    with open(file) as f:
        return {
            'statusCode': 200,
            'headers': {'Content-Type': 'text/html'},
            'body': f.read()
        }
```

### Explanation:
- Opens HTML file
- Sends it as HTTP response
- Browser renders the page

---

## 8️⃣ Saving Data to DynamoDB

```python
def save_data(data):
    table.put_item(
        Item={
            'email': data['email'][0],
            'first_name': data['fname'][0],
            'last_name': data['lname'][0],
            'message': data['message'][0]
        }
    )
```

### Explanation:
- Uses **put_item()** (AWS recommended)
- Safely inserts form data
- `email` is the partition key

---

## 9️⃣ Error Handling

```python
except Exception as e:
    return {'statusCode': 500, 'body': json.dumps(str(e))}
```

### Explanation:
- Prevents Lambda crash
- Returns readable error message

---

## 🔐 Why This Code Is Safe & Correct

✔ No hardcoded credentials  
✔ Uses IAM Role  
✔ Secure DynamoDB insert  
✔ Works with REST & HTTP APIs  
✔ Beginner-friendly structure  

---

## 🎯 Summary

This Lambda function:
- Serves HTML pages
- Handles form submission
- Stores data in DynamoDB
- Runs without servers
- Scales automatically

---

## 👨‍💻 Author
Mouli S

# AWS Serverless Web Application using Terraform

This project demonstrates the design and deployment of a fully serverless web application on AWS using Terraform (Infrastructure as Code). The application uses Amazon API Gateway, AWS Lambda, and Amazon DynamoDB to deliver a scalable and cost-effective solution without managing any servers.

A simple HTML-based contact form is served through API Gateway. When a user submits the form, the request is processed by a Lambda function, which stores the submitted data in a DynamoDB table and then returns a success page to the user.

Terraform is executed from an Amazon EC2 instance, which acts solely as a deployment and automation machine. Using Terraform, all AWS resources—including IAM roles, Lambda functions, API Gateway configuration, and DynamoDB tables—are provisioned, managed, and destroyed in a repeatable and automated manner.

## Author
Mouli S

## 🧭 OVERALL FLOW (Understand First)

Your Laptop / Browser  
↓  
EC2 (Linux VM)  
↓  
Install AWS CLI + Terraform  
↓  
Write Terraform code  
↓  
terraform apply  
↓  
AWS creates Lambda, API Gateway, DynamoDB  

👉 **EC2 is just a tool machine to run Terraform.**

---

## ✅ STEP 1: Launch an EC2 Instance (Terraform Machine)

1️⃣ Go to AWS Console → EC2 → **Launch Instance**

2️⃣ Choose AMI  
✅ Amazon Linux 2023 (Free tier eligible)

3️⃣ Instance Type  
`t2.micro`

4️⃣ Key Pair  
- Create new key pair  
- Name: `terraform-key`  
- Download `.pem` file (**VERY IMPORTANT**)

5️⃣ Network Settings  
- Allow SSH (port 22)  
- Source: My IP

6️⃣ Launch Instance  


---

## ✅ STEP 2: Connect to EC2

### From Local Machine:
```bash
chmod 400 terraform-key.pem
ssh -i terraform-key.pem ec2-user@<EC2_PUBLIC_IP>
```

### Using Browser:
- Click **Connect**
- Choose **EC2 Instance Connect**



---

## ✅ STEP 3: Install Required Tools on EC2

### Update system
```bash
sudo yum update -y
```

### Install AWS CLI
```bash
aws --version
sudo yum install awscli -y
```

### Configure AWS CLI
```bash
aws configure
```

Enter:
- Region: `ap-south-1`
- Output: `json`

Verify:
```bash
aws sts get-caller-identity
```



### Install Terraform
```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install terraform -y
terraform version
```


---

## ✅ STEP 4: Create Project Directory

```bash
mkdir terraform-serverless-app
cd terraform-serverless-app
mkdir lambda terraform
```

---

## ✅ STEP 5: Add Lambda Files

```bash
cd lambda
vi lambda_function.py
vi contactus.html
vi success.html
```

Zip files:
```bash
zip -r lambda.zip .
ls
```

Expected:
```
lambda.zip
lambda_function.py
contactus.html
success.html
```

---

## ✅ STEP 6: Add Terraform Files

```bash
cd ../terraform
vi provider.tf
vi iam.tf
vi dynamodb.tf
vi lambda.tf
vi api_gateway.tf
vi outputs.tf
```


---

## ✅ STEP 7: Run Terraform

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

Type `yes`

TERRAFORM INITIALIZED

<img width="940" height="313" alt="image" src="https://github.com/user-attachments/assets/ea0a5c00-76a7-444c-857b-58d9cc946bf2" />


TERRAFORM PLAN 

<img width="910" height="468" alt="image" src="https://github.com/user-attachments/assets/02594943-fe63-461f-aaf4-f6a816e1a971" />


TERRAFORM APPLY 

<img width="940" height="310" alt="image" src="https://github.com/user-attachments/assets/0213bee4-6ad6-4c74-8300-3dd88649da59" />

---

## ✅ STEP 8: Test the Application

Terraform output:
```
invoke_url = https://xxxxx.execute-api.ap-south-1.amazonaws.com/dev
```

- Open URL
- Submit contact form
- DynamoDB updated
- Success page displayed

<img width="637" height="340" alt="image" src="https://github.com/user-attachments/assets/785f3b9d-f157-4a79-8489-29c24fa56120" />


<img width="634" height="329" alt="image" src="https://github.com/user-attachments/assets/96c31bea-e3bc-4940-8936-d5e86939c629" />



---

## ✅ STEP 9: Verify AWS Resources

Check in AWS Console:
- Lambda Function
- API Gateway
- DynamoDB table `leetable`
- IAM Role attached
- 

<img width="644" height="272" alt="image" src="https://github.com/user-attachments/assets/28e3eebc-7578-4d20-a2a0-4c6a0a07b5ac" />


---

## ✅ STEP 10: Destroy Resources

```bash
terraform destroy
```

Type `yes`


---




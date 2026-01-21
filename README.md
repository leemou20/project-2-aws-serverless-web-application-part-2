# AWS Serverless Web Application using Terraform

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


---

## ✅ STEP 9: Verify AWS Resources

Check in AWS Console:
- Lambda Function
- API Gateway
- DynamoDB table `leetable`
- IAM Role attached



---

## ✅ STEP 10: Destroy Resources

```bash
terraform destroy
```

Type `yes`


---

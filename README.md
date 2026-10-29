# Terraform AWS Web Server

## Project Overview
This project uses Terraform to deploy an instance of an EC2 web server on AWS.

The infrastructure includes:
- An AWS EC2 instance running Amazon Linux 2
- Nginx installed automatically using a bash user-data script
- An AWS security grou (firewall) allowing inbound HTTP traffic on port 80
- A Terraform output displaying the instance's public IP address

## How to Run (in terminal/command line):

**1. Initialize Terraform:**

cd to the parent folder, then

`terraform init`

**2. Preview the infrastructure**

`terraform plan`

**3. Deploy the infrastructure**

`terraform apply`

Type `yes` to confirm apply.

The EC2 instance is then created.

**4. Access the instantiated web server**

Copy the public IP address displayed by Terraform and visit:

`http://IP`

**5. Clean up resources**

'terraform destroy'

Type `yes` to confirm destroy.

**THIS STEP SHOULD BE DONE TO TERMINATE THE EC2 INSTANCE**
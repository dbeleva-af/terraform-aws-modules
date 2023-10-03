Terraform configuration for deployement of one resource in multiple regions
Prerequisites
git
terraform (>=1.5)
AWS account
AWS credentials configured to work with terraform
Terraform installed localy.
VERSIONS:
provider "registry.terraform.io/hashicorp/aws"
  version     = "5.4.0"
Configuration:
PARRENT (CALLING) MODULE:
- Create `main.tf` file

data "aws_ami" "ubuntu-1" {}
resource "aws_instance" "web-1" {}
resource "aws_instance" "web-2" {}


- Create `providers.tf` file

provider "aws" {
  alias = "ohio"
  region = "us-east-2"
}


- Create `variables.tf` file

variable "instance_type" {}
variable "region" {}


- Create `outputs.tf` file

output "ami_id-1" {
  description = "The AMI ID after apply"
  value       = data.aws_ami.ubuntu-1.id
}

output "instance_id-1" {
  description = "The id after apply"
  value       = resource.aws_instance.web-1.id
}

output "instance_id-2" {
  description = "The id after apply"
  value       = resource.aws_instance.web-2.id
}
Inputs
Name	Description	Type	Default	Required
access_key	Requester AWS access key	string	-	yes
secret_key	Requester AWS secret key	string	-	yes
default region	Requester AWS region	string	us-west-2	yes
second region	The second region	alias	us-east-2	yes
Initialize terraform and plan/apply
$ terraform init
$ terraform plan
$ terraform apply
Terraform apply will:
create two resources using one module for 2 different regions
create 2 AMIs for the instances in those regions
Outputs
Name	Description
ami_id	ID for aws_instances AMI in the alias region
instance_id-1	ID for the instance in the default region
instance_id-2	ID for the instance in the alias region

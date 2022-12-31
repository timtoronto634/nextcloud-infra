provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      hashicorp-learn = "module-use"
    }
  }
}

resource "aws_vpc" "nextcloud-vpc" {
  cidr_block = "10.0.0.0/16"
}

# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "nextcloud-vpc"
#   cidr = "10.0.0.0/16"

#   azs             = ["ap-northeast-1"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

#   # enable_nat_gateway = true

#   tags = {
#     Terraform = "true"
#     Environment = "dev"
#   }
# }

/*
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "nextcloud-instance"

  instance_type          = "t3.micro"
  key_name               = aws_key_pair.main-ec2-key-pair.id
  monitoring             = true
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_key_pair" "main-ec2-key-pair" {
  key_name   = "test_key"
  public_key = file(var.ssh_key_path)
}
*/
provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      hashicorp-learn = "module-use"
    }
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "nextcloud-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-northeast-1a"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # enable_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "allow ssh to ec2 inside vpc"
  vpc_id = module.vpc.vpc_id

  
  tags = {
    Name = "nextcloud allow ssh"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group_rule" "allow_ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  security_group_id = aws_security_group.allow_ssh.id
}

resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.allow_ssh.id
}


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "nextcloud-instance"

  ami ="ami-0bba69335379e17f8"
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

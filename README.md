# About
NOTE: This project is WIP
Terraform configuration for infrastrucre of nextcloud

# usage

## setup ssh key
Create an ssh-key pair in .ssh/ directory.

```
# in the prompt after this command, type the path to <repo>/.ssh/id_rsa
ssh-keygen -t rsa -b 4096
```

## apply
there you go

```
terraform init
terraform plan
terraform apply
```


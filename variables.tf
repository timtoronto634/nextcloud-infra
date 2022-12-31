variable "ssh_key_path" {
  description = "path to the ssh-key for ec2"
  type = string
  default = ".ssh/id_rsa.pub"
}

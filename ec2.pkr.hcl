packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ec2" {
  region          = "us-east-1"
  instance_type   = "t3.small"
  ssh_username    = "ec2-user"
  ami_name        = "rhel-golden-image"
  source_ami_filter {
    filters = {
      name = "RHEl-9-DevOps-practice"
      root-device-type = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owner = ["973714476881"]
  }
  ssh_username = "ec2-user"
  ssh_password = "DevOps321"
  }
build {
  sources = ["source.amazon-ebs.ec2"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras enable ansible2",
      "sudo yum install ansible -y",
      "ansible --version"
    ]
  }
}
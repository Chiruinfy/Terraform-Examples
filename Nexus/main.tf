provider "aws" {
    access_key = "AKIA3Z7ARX36J2JUFGHC"
    secret_key = "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"
    region = "us-east-2"
}

resource "aws_instance" "nexus_instance" {
    ami                         = "ami-0231217be14a6f3ba" # Amaxon Linux 2 AMI from eu-east-2 region
    count                       = 1
    instance_type               = "t2.medium"
    key_name                    = "Test"
    associate_public_ip_address = true
     vpc_security_group_ids      = ["sg-08d9d8dc052d5d417"] # ensure this Security Group has port 8081 opened
    user_data                   = templatefile("${path.cwd}/instance-bootstrap.sh", {})



    tags = {
        Name            = "Nexus-Instance"
        ProvisionedBy   = "Terraform"
    }
}
provider "aws" {
    access_key = "AKIA36MY2C4SDH75RO4J"
    secret_key = "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"
    region = "us-east-2"
}

resource "aws_instance" "nexus_instance" {
    ami                         = "ami-0231217be14a6f3ba"
    
    instance_type               = "t2.medium"
    key_name                    = "${aws_key_pair.testkey.id}"
    associate_public_ip_address = true
    security_groups      = ["test-sg"]
    user_data                   = templatefile("${path.cwd}/instance-bootstrap.sh", {})



    tags = {
        Name            = "Nexus-Instance"
        ProvisionedBy   = "Terraform"
    }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.nexus_instance.id}"
  allocation_id = "${aws_eip.test.id}"
  

}
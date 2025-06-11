resource "aws_account" "aws" {
  regions  = ["us-east-1", "eu-west-1"]
  services = ["ec2", "kms"]

  user "user" {
    iam_policy = file("files/iam_policy.json")
  }
}

resource "terraform" "instance" {
  source = "files/terraform"

  volume {
    source      = data("ssh")
    destination = "/tmp/ssh"
  }

  variables = {
    region = "us-east-1"
  }

  environment = {
    AWS_ACCESS_KEY_ID     = resource.aws_account.aws.user.0.access_key_id
    AWS_SECRET_ACCESS_KEY = resource.aws_account.aws.user.0.secret_access_key
  }
}
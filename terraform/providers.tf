provider "aws" {
  # Requester's credentials (e.g. a Staging account).
  profile = "${var.requester_profile}"
  region  = "${var.region}"
}

provider "aws" {
  alias   = "acceptor"

  # Acceptor's credentials (e.g. a Production account).
  profile = "${var.acceptor_profile}"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket         = "<TERRAFORM STATE BUCKET>"
    key            = "vpc-peering/terraform.tfstate"
    region         = "${var.region}"
    profile        = "${var.requester_profile}"
    dynamodb_table = "<DYNAMO DB TABLE NAME>"
  }
  required_version = ">= 0.10.0"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region

}

data "aws_availability_zones" "available" {}


# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external.tf for additional information.
provider "http" {}
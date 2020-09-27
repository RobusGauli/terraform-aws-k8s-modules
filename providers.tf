provider "aws" {
  region  = var.region
  version = "~> v2.0"
}
provider "aws" {
  alias  = "north-virginia"
  region = "us-east-1"
}

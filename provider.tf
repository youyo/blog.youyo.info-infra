provider "aws" {
  region = "${var.aws_region}"
}

provider "aws" {
  region = "us-east-1"
  alias  = "ailas_us_east_1"
}

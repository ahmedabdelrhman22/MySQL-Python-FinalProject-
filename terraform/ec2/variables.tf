variable "aws_region" {
  description = "The AWS region to create things in."
  //default     = "us-east-2"
}

variable "aws_profile" {
  description = "AWS profile"
}

variable "public1_subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}
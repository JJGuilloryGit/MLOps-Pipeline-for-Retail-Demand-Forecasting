variable "vpc_id" {
  description = "aws_vpc.mlops_vpc.id"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs for MSK cluster"
  type        = list(string)
}
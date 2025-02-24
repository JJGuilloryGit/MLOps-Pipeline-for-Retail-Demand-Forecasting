variable "vpc_id" {}
variable "subnets" {
  type = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for EKS cluster"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs for EKS cluster"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

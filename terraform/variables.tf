variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "ssh_public_key" {
  description = "Public key installed on the instance (used by Ansible)"
  type        = string
}

variable "admin_cidr" {
  description = "CIDR allowed to reach SSH and Grafana. Do not use 0.0.0.0/0."
  type        = string
}

variable "kubernetes_version" {
  default     = 1.27
  description = "kubernetes version"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "default CIDR range of the VPC"
}
variable "aws_region" {
  default = "us-east-2"
  description = "aws region"
}

variable "fsxame" {
  default     = "eksfs"
  description = "default fsx name"
}

variable "fsx_admin_password" {
  default     = "Netapp1!"
  description = "default fsx filesystem admin password"
}

variable "fsxn_addon_version" {
  default = "v24.2.0-eksbuild.1"
  description = "fsx csi addon version"
}

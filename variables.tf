//
// Variables  
//

variable "env" {
  type = string
  description = "This is the environment : dev, prod or preprod."
}

variable "app_name" {
  type = string
  description = "This is the application name."
}

variable "app_cidr" {
  type = string
  description = "This is the infrastructure cidr : it depends on the environment."
}

variable "app_region" {
  type = string
  description = "This is the AWS region in which the infrastructure will be deployed."
}

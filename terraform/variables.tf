// AWS Tag Variable Definitions.

variable "billing_code" {
  default = "Common"
}

variable "service" {
  default = "VPC Peering"
}

variable "region" {
  default = "eu-west-1"
}

// Requester definitions.

variable "requester_profile" {
  default = "staging"
}

variable "requester_environment" {
  default = "staging"
}

variable "requester_vpc_name" {
  description = "Name of the requesting VPC."
  default     = "Staging"
}

variable "requester_vpc_id" {
  description = "The VPC ID of the requesting peer."
  default     = ""
}

variable "requester_cidr_block" {
  description = "CIDR block for the requesting VPC."
  type        = "list"

  default     = [
    "",
    "",
    ""
  ]
}

// Acceptor definitions.

variable "acceptor_profile" {
  default = "production"
}

variable "acceptor_environment" {
  default = "production"
}

variable "acceptor_vpc_name" {
  description = "Name of the accepting VPC."
  default     = "Production"
}

variable "acceptor_vpc_id" {
  description = "The VPC ID of the accepting peer."
  default     = ""
}

variable "acceptor_cidr_block" {
  description = "CIDR block for the accepting VPC."
  type        = "list"

  default = [
    "",
    "",
    "",
    "",
    ""
  ]
}

variable "auto_accept" {
  description = "Specify whether or not connections should be automatically accepted"
  type        = "string"
  default     = true
}

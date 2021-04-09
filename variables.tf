variable "name" {
  type = string
}

variable "kinesis_users_public_key_parameter_name" {
  type        = string
  description = "The name of the SSM parameter containing the public key for encrypting the AWS secret access key"
  default     = "kinesis-user-gpg-public-key"
}

variable "tags" {
  type = map(string)
}

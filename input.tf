variable "region" {
  default     = "us-east-1"
  description = "The AWS region."
}

variable "accountid" {
  description = "the accountid for which this bucket is holding state files"
}

variable "tags" {
  default = {}

  description = "A map of tags that should be added to all resources this module creates"
}

variable "authorised_accountid" {
  description = "an accountid of an account that needs to be able to access this bucket"
}

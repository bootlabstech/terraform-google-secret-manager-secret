//required variables
variable "secret_id" {
  type        = string
  description = "This must be unique within the project."
}

variable "project" {
  type        = string
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
}

variable "labels" {
  type        = map(any)
  description = "A set of key/value label pairs to assign to this ManagedZone."
  default     = {}
}

variable "replication_automatic" {
  type        = bool
  description = "The Secret will automatically be replicated without any restrictions."
  default     = true
}

variable "replication_user_managed_replicas" {
  type = list(object({
    location                    = string,
    customer_managed_encryption = string
  }))
  description = "The list of Replicas for this Secret."
  default     = []
}

variable "secret_data" {
  type        = string
  description = "The secret data. Must be no larger than 64KiB. Note: This property is sensitive and will not be displayed in the plan."
}

variable "secretAccessorMembers" {
  type        = list(string)
  description = "The list of members who will have secret accessor role."
  default     = []
}
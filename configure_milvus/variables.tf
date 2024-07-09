variable "milvus_create_api_key" {
  description = "The Watson API key needed to call Watson APIs for configuring users."
  type        = string
}

variable "watsonx_data_crn" {
  description = "CRN of the watsonx.data instance."
  type        = string
}

variable "cos_access_id" {
	description = "COS HMAC ID"
	type        = string
}

variable "cos_access_secret" {
	description = "COS HMAC secret"
	type        = string
}

variable "milvus_service_bucket_name" {
  description = "What to name the bucket for this Milvus service"
  type        = string
}

variable "location" {
  default     = "us-south"
  description = "The location that's used with the IBM Cloud Terraform IBM provider. It's also used during resource creation."
  type        = string
  validation {
    condition     = contains(["us-east", "us-south"], var.location)
    error_message = "You must specify `us-east` or `us-south` as the IBM Cloud location."
  }
}

variable "milvus_service_name" {
  description = "What to name the Milvus service"
  type        = string
}

variable "milvus_flavor" {
  default     = "small"
  description = "The sizing for Milvus service to deploy"
  type        = string
  validation {
    condition = anytrue([
      var.milvus_flavor == "small",
      var.milvus_flavor == "medium",
      var.milvus_flavor == "large",
    ])
    error_message = "You must select small, medium, or large."
  }
}
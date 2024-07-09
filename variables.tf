########################################################################################################################
# Input Variables
########################################################################################################################

variable "ibmcloud_api_key" {
  description = "The API key that's used with the IBM Cloud Terraform IBM provider."
  sensitive   = true
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

variable "use_existing_resource_group" {
  type        = bool
  description = "Determines whether to use an existing resource group."
  default     = false
}

variable "resource_group_name" {
  type        = string
  description = "The name of a new or an existing resource group where the resources are created."
}

variable "cos_plan" {
  default     = "standard"
  description = "The plan that's used to provision the Cloud Object Storage instance."
  type        = string
  validation {
    condition     = contains(["standard"], var.cos_plan)
    error_message = "You must use a standard plan. Standard plan instances are the most common and are recommended for most workloads."
  }
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

variable "milvus_service_name" {
  description = "What to name the created Milvus service"
  type        = string
}

variable "milvus_service_bucket_name" {
  description = "What to name the bucket for this Milvus service"
  type        = string
}

variable "watsonx_data_crn" {
  description = "CRN of the existing watsonx.data instance"
  type        = string
}

variable "resource_prefix" {
  description = "The name to be used on all Milvus resources as a prefix."
  type        = string
  default     = "milvus-poc"

  validation {
    condition     = var.resource_prefix != "" && length(var.resource_prefix) <= 25
    error_message = "You must provide a value for the resource_prefix variable and the resource_prefix length can't exceed 25 characters."
  }
}
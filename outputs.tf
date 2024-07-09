########################################################################################################################
# Outputs
########################################################################################################################

output "milvus_grpc_endpoint" {
  description = "The endpoint of the gRPC service for created Milvus"
  value       = "var.grpc_endpoint"
}

output "milvus_https_endpoint" {
  description = "The URL for https service for created Milvus"
  value       = "var.https_endpoint"
}

output "milvus_service_bucket_name" {
  description = "The bucket name that was created for Milvus service."
  value       = "tbd"
}

output "watsonx_data_crn" {
  description = "The CRN of the watsonx.data instance that Milvus service was deployed to."
  value       = var.watsonx_data_crn
}

output "milvus_service_name" {
  description = "The name of the Milvus service created."
  value       = "tbd"
}

output "watsonx_data_lakehouse_url" {
  value       = "https://${var.location}.lakehouse.cloud.ibm.com/#/infrastructure-manager?crn=${var.watsonx_data_crn}"
  description = "The URL to access Milvus service and see provisioning status"
}
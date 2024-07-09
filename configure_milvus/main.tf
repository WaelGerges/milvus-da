data "ibm_iam_auth_token" "tokendata" {}

resource "restapi_object" "configure_bucket" {
  depends_on     = [data.ibm_iam_auth_token.tokendata]
  path           = "/bucket_registrations"
  read_method    = "GET"
  create_method  = "POST"
  id_attribute   = "bucket_id"
  destroy_method = "DELETE"
  data           = <<-EOT
                  { 
                    "bucket_details": {
                      "access_key": "${var.cos_access_id}",
                      "bucket_name": "${var.milvus_service_bucket_name}",
                      "endpoint": "https://s3.${var.location}.cloud-object-storage.appdomain.cloud",
                      "secret_key": "${var.cos_access_secret}"
                    },
                    "bucket_display_name": "${var.milvus_service_bucket_name}",
                    "bucket_type": "ibm_cos",
                    "description": "COS bucket for ${var.milvus_service_bucket_name}",
                    "managed_by": "customer",
                    "region": "${var.location}" 
                  }
                  EOT
  update_method  = "PATCH"
  update_data    = <<-EOT
                  { 
                    "bucket_details": {
                      "access_key": "${var.cos_access_id}",
                      "endpoint": "https://s3.${var.location}.cloud-object-storage.appdomain.cloud",
                      "secret_key": "${var.cos_access_secret}"
                    },
                    "bucket_display_name": "${var.milvus_service_bucket_name}",
                    "bucket_type": "ibm_cos",
                    "description": "COS bucket for ${var.milvus_service_bucket_name}",
                    "managed_by": "customer",
                    "region": "${var.location}" 
                  }
                  EOT
}

resource "restapi_object" "configure_milvus" {
  depends_on     = [data.ibm_iam_auth_token.tokendata, resource.restapi_object.configure_bucket]
  path           = "/milvus_services"
  id_attribute   = "service_id"
  read_method    = "GET"
  create_method  = "POST"
  destroy_method = "DELETE"
  data           = <<-EOT
                  { 
                    "bucket_name": "${var.milvus_service_bucket_name}",
                    "bucket_type": "ibm_cos",
                    "description": "${var.milvus_service_name} Milvus service",
                    "origin": "native",
                    "root_path": "",
                    "service_display_name": "${var.milvus_service_name}",
                    "tshirt_size": "${var.milvus_flavor}",
                    "type": "milvus"
                  }
                  EOT
  update_method  = "PATCH"
  update_data    = <<-EOT
                  { 
                    "bucket_name": "${var.milvus_service_bucket_name}",
                    "bucket_type": "ibm_cos",
                    "description": "${var.milvus_service_name} Milvus service",
                    "origin": "native",
                    "root_path": "",
                    "service_display_name": "${var.milvus_service_name}",
                    "tshirt_size": "${var.milvus_flavor}",
                    "type": "milvus"
                  }
                  EOT
}
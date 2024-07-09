module "resource_group" {
  providers = {
    ibm = ibm.deployer
  }
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.1.6"
  resource_group_name          = var.use_existing_resource_group == false ? var.resource_group_name : null
  existing_resource_group_name = var.use_existing_resource_group == true ? var.resource_group_name : null
}

module "cos" {
  providers = {
    ibm = ibm.deployer
  }
  source            = "terraform-ibm-modules/cos/ibm//modules/fscloud"
  version           = "8.4.1"
  resource_group_id = module.resource_group.resource_group_id
  cos_instance_name = "${var.resource_prefix}-cos-instance"
  cos_plan          = var.cos_plan
}

resource "ibm_resource_key" "key" {
  name                 = "milvus-integration-key"
  resource_instance_id = module.cos.cos_instance_id
  parameters           = { "HMAC" = true }
  role                 = "Manager"
}

locals {
  resource_credentials =jsondecode(ibm_resource_key.key.credentials_json)
}

module "buckets" {
  source  = "terraform-ibm-modules/cos/ibm//modules/buckets"
  bucket_configs = [
    {
      bucket_name 	= var.milvus_service_bucket_name
      kms_encryption_enabled = false
      region_location = var.location
      resource_instance_id = module.cos.cos_instance_crn
    }
  ]
}

module "configure_milvus" {
  source                = "./configure_milvus"
  milvus_create_api_key = var.ibmcloud_api_key
  watsonx_data_crn = var.watsonx_data_crn
  cos_access_id    = local.resource_credentials.cos_hmac_keys.access_key_id
  cos_access_secret = local.resource_credentials.cos_hmac_keys.secret_access_key
  milvus_service_bucket_name = var.milvus_service_bucket_name
  milvus_service_name = var.milvus_service_name
  milvus_flavor       = var.milvus_flavor
  location            = var.location
}
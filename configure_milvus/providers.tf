provider "ibm" {
  ibmcloud_api_key = var.milvus_create_api_key
}

provider "restapi" {
  uri                  = "https://${var.location}.lakehouse.cloud.ibm.com/lakehouse/api/v2"
  write_returns_object = true
  debug                = true
  headers = {
    Authorization  = data.ibm_iam_auth_token.tokendata.iam_access_token
    Content-Type   = "application/json"
	AuthInstanceId = var.watsonx_data_crn
  }
}
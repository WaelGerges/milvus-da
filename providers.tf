provider "ibm" {
  alias            = "deployer"
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.location
}

provider "restapi" {
  alias                = "restapi_milvus_admin"
  uri                  = "https:"
  write_returns_object = true
  debug                = true
  headers = {
    Authorization = data.ibm_iam_auth_token.restapi.iam_access_token
    Content-Type  = "application/json"
  }
}
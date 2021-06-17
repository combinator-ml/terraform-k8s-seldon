variable "seldon_core_operator_namespace" {
  description = "(Optional) The namespace to install the minio operator into. Defaults to minio-operator"
  type        = string
  default     = "seldon-system"
}

variable "seldon_core_values" {
  description = "(Optional) List of values in raw yaml to pass to helm."
  type        = list(string)
  default     = []
}

variable "enable_example_seldon_deployment" {
  description = "Enable an example seldon deployment"
  type        = bool
  default     = true
}

variable "enable_seldon_gateway" {
  description = "Create an istio gateway for seldon"
  type        = bool
  default     = true
}

# variable "ambassador_namespace" {
#   description = "(Optional) The namespace to install the ambassador operator into. Defaults to ambassador"
#   type        = string
#   default     = "ambassador"
# }

# variable "ambassador_values" {
#   description = "(Optional) List of values in raw yaml to pass to helm. See https://github.com/pachyderm/helmchart/blob/master/pachyderm/values.yaml."
#   type        = list(string)
#   default = []
# }

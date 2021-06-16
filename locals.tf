locals {
  seldon_helm_values = {
    istio = {
      enabled = true
      gateway = "istio-system/seldon-gateway"
    }
  }
}

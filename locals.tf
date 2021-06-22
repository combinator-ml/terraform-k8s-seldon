locals {
  seldon_helm_values = {
    istio = {
      enabled = true
      gateway = "istio-system/seldon-gateway" # todo: factor
    }
  }
  istio_ingress_values = {
    gateways = {
      istio-ingressgateway = {
        type = "ClusterIP" # todo: factor
      }
    }
  }
}

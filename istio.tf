module "istio" {
  #   source  = "combinator-ml/istio/k8s"
  source = "../terraform-k8s-istio"
}

resource "kubernetes_manifest" "gateway" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "networking.istio.io/v1alpha3"
    "kind"       = "Gateway"
    "metadata" = {
      "name"      = "seldon-gateway"
      "namespace" = "istio-system"
    }
    "spec" = {
      "selector" = {
        "istio" = "ingressgateway"
      }
      "servers" = [
        {
          "port" = {
            "number"   = "80"
            "name"     = "http"
            "protocol" = "HTTP"
          }
          "hosts" = ["*"]
        }
      ]
    }
  }
}

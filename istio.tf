module "istio" {
  source  = "combinator-ml/istio/k8s"
  version = "0.0.1"
  ingress_values = [
    yamlencode(local.istio_ingress_values)
  ]
}

data "kubectl_file_documents" "gateway_manifest" {
  content = file("${path.module}/gateway.yaml")
}

resource "kubectl_manifest" "gateway" {
  count              = var.enable_seldon_gateway ? length(data.kubectl_file_documents.gateway_manifest.documents) : 0
  yaml_body          = element(data.kubectl_file_documents.gateway_manifest.documents, count.index)
  override_namespace = "istio-system" # TODO: factor
  depends_on = [
    module.istio,
  ]
}

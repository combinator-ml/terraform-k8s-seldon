module "istio" {
  #   source  = "combinator-ml/istio/k8s"
  source = "../terraform-k8s-istio"
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

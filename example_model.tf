resource "kubernetes_namespace" "seldon" {
  metadata {
    name = "seldon" # TODO: factor
  }

  depends_on = [
    helm_release.seldon_core_operator
  ]
}

# This currently doesn't work due to https://github.com/SeldonIO/seldon-core/issues/3305

# data "kubectl_file_documents" "seldon_deployment_manifest" {
#   content = file("${path.module}/seldon_deployment.yaml")
# }

# resource "kubectl_manifest" "seldon_deployment" {
#   count              = var.enable_example_seldon_deployment ? length(data.kubectl_file_documents.seldon_deployment_manifest.documents) : 0
#   yaml_body          = element(data.kubectl_file_documents.seldon_deployment_manifest.documents, count.index)
#   override_namespace = "seldon"
#   depends_on = [
#     helm_release.seldon_core_operator,
#     kubernetes_namespace.seldon
#   ]
# }

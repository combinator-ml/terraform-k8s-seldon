resource "helm_release" "seldon_core_operator" {
  name       = "seldon-core"
  repository = "https://storage.googleapis.com/seldon-charts"
  chart      = "seldon-core-operator"
  version    = "1.9.0"
  namespace  = var.seldon_core_operator_namespace
  wait       = true
  values = [
    yamlencode(local.seldon_helm_values)
  ]
  create_namespace = true

  depends_on = [
    module.istio
  ]
}

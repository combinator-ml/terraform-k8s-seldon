resource "kubernetes_namespace" "seldon" {
  metadata {
    name = "seldon"
  }

  depends_on = [
    helm_release.seldon_core_operator
  ]
}

resource "kubernetes_manifest" "iris_model" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "machinelearning.seldon.io/v1"
    "kind"       = "SeldonDeployment"
    "metadata" = {
      "name"      = "iris-model"
      "namespace" = "seldon"
    }
    "spec" = {
      "name" = "iris"
      "predictors" = [
        {
          "graph" = {
            "implementation" = "SKLEARN_SERVER"
            "modelUri"       = "gs://seldon-models/sklearn/iris"
            "name"           = "classifier"
          }
          "name"     = "default"
          "replicas" = 1
        }
      ]
    }
  }

  depends_on = [
    kubernetes_namespace.seldon
  ]
}

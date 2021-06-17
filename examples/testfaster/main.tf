variable "namespace" {
  description = "The namespace to install into."
  default     = "default"
  type        = string
}

locals {
  prefix           = "testfaster"
  create_namespace = var.namespace == "default" ? 0 : 1 # Create if not default
}

resource "kubernetes_namespace" "namespace" {
  count = local.create_namespace
  metadata {
    name = var.namespace
  }
}

module "seldon" {
  source = "../../"
}

module "jupyter" {
  source    = "combinator-ml/jupyter/k8s"
  version   = "0.0.3"
  namespace = var.namespace
  depends_on = [
    kubernetes_namespace.namespace
  ]
}

resource "kubernetes_service" "jupyter" {
  metadata {
    name      = "${local.prefix}-jupyter"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = "combinator-jupyter"
    }
    port {
      name        = "http"
      port        = 8888
      target_port = 8888
      node_port   = 30600
    }
    type = "NodePort"
  }
  depends_on = [
    module.jupyter
  ]
}

# Wait for the pod to start then copy the notebook into the working directory of the pod
# Any changes will only exist inside the pod. Download the notebook if you want a copy.
resource "null_resource" "copy_notebook" {
  provisioner "local-exec" {
    command = "kubectl -n ${var.namespace} rollout status deployment/combinator-jupyter-deployment && kubectl -n ${var.namespace} cp demo.ipynb $(kubectl -n ${var.namespace} get po -l app=combinator-jupyter -o custom-columns=POD:.metadata.name --no-headers):/home/jovyan"
  }
  depends_on = [
    module.jupyter
  ]
}

resource "kubernetes_cluster_role_binding" "jupyter" {
  metadata {
    name = "jupyter"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "seldon-manager-role-seldon-system"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "default"
  }
}

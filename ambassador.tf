# resource "helm_release" "ambassador_operator" {
#   name             = "ambassador"
#   repository       = "https://getambassador.io"
#   chart            = "ambassador"
#   version          = "6.7.5"
#   namespace    = var.ambassador_namespace
#   wait             = true
#   values           = var.ambassador_values
#   create_namespace = true
#   lint = true
#   set {
#       name = "replicaCount"
#       value = 1
#   }
#   set {
#       name = "image.repository"
#       value = "quay.io/datawire/ambassador" # Use OSS image
#   }
#   # Does not work. No idea why. Could be k3d.
#   set {
#       name = "enableAES"
#       value = false
#   }
#   set {
#       name = "crds.keep"
#       value = false
#   }
#   set {
#       name = "service.type"
#       value = "ClusterIP"
#   }
# }

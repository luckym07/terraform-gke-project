resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  namespace  = var.namespace
  chart      = var.chart
  repository = var.repository
  version    = var.version

  values = [file(var.values_file)]
}

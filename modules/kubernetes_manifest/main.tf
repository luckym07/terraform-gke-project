resource "kubernetes_manifest" "manifest" {
  for_each = var.manifests
  manifest = yamldecode(file(each.value.file_path))
}

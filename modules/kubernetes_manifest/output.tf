output "manifest_ids" {
  value = [for key, value in kubernetes_manifest.manifest : value.id]
}

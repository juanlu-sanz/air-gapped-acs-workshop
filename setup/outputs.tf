# outputs.tf
# Purpose: Output cluster connection details after provisioning

output "hub_api_url" {
  description = "API URL for the hub cluster"
  value       = rhcs_cluster_rosa_hcp.hub.api_url
}

output "hub_console_url" {
  description = "Console URL for the hub cluster"
  value       = rhcs_cluster_rosa_hcp.hub.console_url
}

output "hub_cluster_id" {
  description = "ROSA cluster ID for the hub (use with rosa describe cluster)"
  value       = rhcs_cluster_rosa_hcp.hub.id
}

output "secured_api_url" {
  description = "API URL for the secured cluster"
  value       = rhcs_cluster_rosa_hcp.secured.api_url
}

output "secured_console_url" {
  description = "Console URL for the secured cluster"
  value       = rhcs_cluster_rosa_hcp.secured.console_url
}

output "secured_cluster_id" {
  description = "ROSA cluster ID for the secured cluster (use with rosa describe cluster)"
  value       = rhcs_cluster_rosa_hcp.secured.id
}

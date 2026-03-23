output "server_ipv4" {
  description = "Public IPv4 address of the benchmark host."
  value       = hcloud_server.benchmark_runner.ipv4_address
}

output "server_name" {
  description = "Provisioned server name."
  value       = hcloud_server.benchmark_runner.name
}

output "runner_label" {
  description = "GitHub Actions label configured on the host."
  value       = var.github_runner_label
}

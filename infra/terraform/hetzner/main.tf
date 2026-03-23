provider "hcloud" {
  token = var.hcloud_token
}

locals {
  user_data = templatefile("${path.module}/templates/cloud-init.yaml.tftpl", {
    github_runner_url   = var.github_runner_url
    github_runner_token = var.github_runner_token
    github_runner_label = var.github_runner_label
    runner_count        = var.runner_count
    runner_version      = var.runner_version
    server_name         = var.server_name
  })
}

resource "hcloud_server" "benchmark_runner" {
  name        = var.server_name
  server_type = var.server_type
  image       = var.image
  location    = var.location
  ssh_keys    = var.ssh_keys
  user_data   = local.user_data

  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

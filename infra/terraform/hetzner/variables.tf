variable "hcloud_token" {
  description = "Hetzner Cloud API token."
  type        = string
  sensitive   = true
}

variable "server_name" {
  description = "Name assigned to the Hetzner benchmark host."
  type        = string
  default     = "rest-api-benchmark"
}

variable "server_type" {
  description = "Hetzner Cloud server type."
  type        = string
  default     = "cax41"
}

variable "location" {
  description = "Hetzner Cloud location."
  type        = string
  default     = "nbg1"
}

variable "image" {
  description = "Base OS image."
  type        = string
  default     = "ubuntu-24.04"
}

variable "ssh_keys" {
  description = "SSH key names or IDs already registered in Hetzner Cloud."
  type        = list(string)
  default     = []
}

variable "github_runner_url" {
  description = "Repository or organization URL for the self-hosted GitHub Actions runner."
  type        = string
}

variable "github_runner_token" {
  description = "GitHub registration token for the self-hosted runner."
  type        = string
  sensitive   = true
}

variable "github_runner_label" {
  description = "Custom GitHub Actions label used by benchmark workflows."
  type        = string
  default     = "benchmark-cax41"
}

variable "runner_count" {
  description = "Number of runner services to install on the host for parallel benchmark jobs."
  type        = number
  default     = 4
}

variable "runner_version" {
  description = "GitHub Actions runner version."
  type        = string
  default     = "2.328.0"
}

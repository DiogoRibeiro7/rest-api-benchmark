# Hetzner Benchmark Runner

This Terraform stack provisions a dedicated Hetzner Cloud host for benchmark execution and installs one or more self-hosted GitHub Actions runners on that machine.

## Why this exists

GitHub-hosted runners are convenient, but they are not a good primary measurement environment for repeatable performance benchmarks. A dedicated cloud machine gives us:

- stable hardware across runs
- explicit CPU and memory capacity
- lower cost for long benchmark matrices
- the option to run multiple benchmark jobs concurrently on the same host

The default profile targets a `cax41` ARM64 machine, matching the reviewer recommendation.

## What it creates

- one Hetzner Cloud server
- Docker, K6, Node.js, sysstat and related benchmark dependencies
- `runner_count` self-hosted GitHub Actions runner services on the same host

Registering multiple runner services matters because one GitHub runner processes one job at a time. With `runner_count = 4`, the workflow matrix can execute up to four benchmark jobs in parallel on the same `cax41`.

## Required inputs

Create a `terraform.tfvars` file locally:

```hcl
hcloud_token         = "..."
github_runner_url    = "https://github.com/<owner>/<repo>"
github_runner_token  = "..."
github_runner_label  = "benchmark-cax41"
ssh_keys             = ["your-hetzner-ssh-key-name"]
runner_count         = 4
```

Notes:

- `github_runner_url` can target a repository or an organization.
- `github_runner_token` is the GitHub registration token for self-hosted runners.
- The workflows in this repository expect the runner label to match `BENCHMARK_RUNNER_LABEL` or the manual `runner_label` workflow input.

## Usage

```bash
cd infra/terraform/hetzner
terraform init
terraform apply
```

After apply:

1. Set the repository variable `BENCHMARK_RUNNER_LABEL` to the same value as `github_runner_label`.
2. Trigger the benchmark workflow normally. Build and benchmark jobs will run on the Hetzner host instead of `ubuntu-latest`.

## Cleanup

```bash
terraform destroy
```

#!/bin/bash

# Terraform CLI Common Operations Examples
# Replace placeholder values (like aws_region, my-stack, resource addresses, IDs) with your own.

# Show Terraform version and environment info
terraform version

# Initialize a working directory
terraform init

# Initialize and upgrade provider/module versions to the newest allowed by constraints
terraform init -upgrade

# Initialize with backend configuration (example: S3 backend)
# terraform init \
#   -backend-config="bucket=my-terraform-state" \
#   -backend-config="key=envs/dev/terraform.tfstate" \
#   -backend-config="region=us-east-1" \
#   -backend-config="dynamodb_table=terraform-locks"

# Migrate state when changing backends
# terraform init -migrate-state

# Format configuration files
terraform fmt -recursive

# Validate configuration for syntax and internal consistency
terraform validate

# View providers in use and their versions
terraform providers

# Lock provider dependency versions for reproducible builds (multi-platform lock file)
# Useful for CI to pre-resolve provider checksums for specific OS/ARCH pairs
terraform providers lock -platform=linux_amd64 -platform=linux_arm64 -platform=darwin_amd64 -platform=darwin_arm64 -platform=windows_amd64

# Create a plan and show changes
terraform plan

# Plan with variable overrides (inline)
terraform plan -var="project=my-stack" -var="region=us-east-1"

# Plan with variable file(s)
terraform plan -var-file="vars/dev.tfvars"

# Plan with an explicit output file (recommended for review or apply later)
terraform plan -out="plan.tfplan"

# Plan to refresh state only (no changes applied) - useful for drift detection
terraform plan -refresh-only

# Plan a destroy (preview what would be destroyed)
terraform plan -destroy

# Apply the last plan interactively
terraform apply

# Apply a previously saved plan file (non-interactive with -auto-approve if desired)
terraform apply "plan.tfplan"

# Apply without interactive approval (use with care, especially in CI)
terraform apply -auto-approve

# Replace a resource in the next plan/apply (modern alternative to 'terraform taint')
# Replace performs a destroy-and-recreate of the targeted resource
terraform apply -replace="aws_instance.web"

# Target specific resources during plan/apply (use sparingly)
terraform plan -target="module.network.aws_vpc.main"

# Destroy all managed infrastructure (interactive)
terraform destroy

# Destroy specific target(s)
terraform destroy -target="aws_instance.web"

# Show outputs after apply
terraform output

# Show outputs as JSON (useful for scripting)
terraform output -json

# Inspect current state (local view)
terraform show

# Inspect a previously saved plan file (human-readable)
terraform show "plan.tfplan"

# Inspect a plan file as JSON (for tooling/automation)
# Requires 'jq' to pretty-print
terraform show -json "plan.tfplan" | jq

# Workspaces (separate state per workspace; good for envs like dev/stage/prod)
terraform workspace list
terraform workspace new dev
terraform workspace select dev
terraform workspace select default
terraform workspace delete dev

# State management (advanced; be careful)
terraform state list
terraform state show "aws_instance.web"

# Move an address within state (e.g., after refactoring resource names/modules)
terraform state mv "aws_instance.old_name" "aws_instance.new_name"

# Remove an object from state without destroying it (stop managing)
terraform state rm "aws_instance.web"

# Replace a provider in state (e.g., when changing provider source addresses)
# Example switches from legacy to modern address
# terraform state replace-provider "registry.terraform.io/-/aws" "registry.terraform.io/hashicorp/aws"

# Pull raw state (JSON) to stdout and push a state file (advanced/backends)
terraform state pull > state-backup.json
# terraform state push state-backup.json

# Force unlock state if a lock was orphaned (use only if you're sure the lock is stale)
# Get the lock ID from the error message when a lock occurs
# terraform force-unlock <LOCK_ID>

# Import an existing resource into state (CLI-based import)
# Find the correct resource ID in the provider docs for your resource
terraform import "aws_instance.web" "i-0123456789abcdef0"

# Config-driven import (preferred in newer Terraform): add an 'import' block in configuration,
# then run 'terraform plan' to generate import steps. Example (in *.tf):
# import {
#   to = aws_instance.web
#   id = "i-0123456789abcdef0"
# }
# Then:
# terraform plan
# terraform apply

# Generate a dependency graph (requires Graphviz 'dot' to convert to images)
terraform graph | dot -Tsvg > graph.svg

# Interactive console for evaluating expressions and inspecting values
terraform console

# Provider and module downloads without init (rarely needed; init generally covers this)
# terraform get -update

# Login to Terraform Cloud/Enterprise (if using remote services)
# terraform login
# terraform logout

# Typical CI workflow (idempotent):
# 1) terraform fmt -check -recursive
# 2) terraform init -input=false
# 3) terraform validate
# 4) terraform plan -input=false -out=plan.tfplan -var-file="vars/${ENV}.tfvars"
# 5) terraform show -no-color plan.tfplan > plan.txt (upload as artifact)
# 6) terraform apply -input=false -auto-approve plan.tfplan (manual approval gate recommended)

# Environment variables for variables and logging:
# Pass variables via environment:
# export TF_VAR_project="my-stack"
# export TF_VAR_region="us-east-1"
#
# Enable logging (TRACE|DEBUG|INFO|WARN|ERROR)
# export TF_LOG=INFO
# export TF_LOG_PATH=./terraform.log
#
# Configure default parallelism (useful when hitting API rate limits)
# export TF_CLI_ARGS_apply="-parallelism=5"
# export TF_CLI_ARGS_plan="-parallelism=5"

# Helpful flags:
# -compact-warnings   Reduce verbosity of warnings in plan/apply output
# -lock=true          Enable state locking (default true; backend must support)
# -lock-timeout=5m    How long to retry acquiring the lock
# -refresh=false      Skip state refresh (not generally recommended)
# -input=false        Disable interactive prompts (for CI)
# -no-color           Remove color codes (for logs/CI)

# Notes:
# - Prefer using -replace over 'terraform taint' (taint is deprecated in newer versions).
# - Use workspaces or separate backends to isolate environments.
# - Keep versions pinned in required_providers and use 'terraform providers lock' for reproducibility.
# - Treat state as sensitive data; back it up and protect access.

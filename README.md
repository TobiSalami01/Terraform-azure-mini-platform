# Terraform Azure Mini Platform (Free / Trial Friendly)

This project demonstrates a modular Azure infrastructure built with Terraform, designed to work within **Azure Free / Trial subscription limits** while still reflecting real-world cloud architecture patterns.

## Architecture Overview

**Core Components**
- Resource Group
- Virtual Network with segmented subnets (app / private)
- Log Analytics Workspace
- Storage Account
- Azure Key Vault with access policies

**Application Layer**
- Azure Storage Static Website (trial-safe)
- Custom index and 404 pages
- App Service Plan & Web App included as optional, feature-flagged code (disabled by default due to quota limits)


## Project Structure

terraform-azure-mini-prod/
├── modules/
│   ├── network/        # VNet and subnets
│   ├── monitoring/     # Log Analytics + Storage
│   ├── app/            # Key Vault + optional App Service
│   └── static_site/    # Storage Static Website
│
├── environments/
│   ├── dev/
│   │   └── main.tf
│   └── prod/
│
├── .gitignore
└── README.md

## Key Concepts Demonstrated

- Modular Terraform design
- Environment separation (dev / prod)
- Importing existing Azure resources into Terraform state
- Feature flags for quota-heavy services
- Secure handling of secrets with Azure Key Vault
- Trial-safe application deployment using Azure Storage Static Website

## How to Run (Dev)

cd environments/dev
terraform init
terraform plan
terraform apply

## Notes

- App Service is disabled by default to avoid Azure Free/Trial quota failures.
- Static Website provides a working endpoint without paid compute.
- No secrets or state files are committed to GitHub.

## Author

Built by **Tobi Salami** as a hands-on Azure + Terraform infrastructure project.


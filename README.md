# Terraform Azure Mini Platform

This repository contains a modular Azure infrastructure platform** built with Terraform.  
It demonstrates how to design, organize, and deploy core cloud infrastructure using real world architectural patterns, with an emphasis on scalability, security, and operational clarity.

The platform is intentionally designed to be cost efficient and quota aware, making it easy to deploy in constrained environments while remaining fully extensible to larger production workloads.

---

#Architecture Overview

#Core Infrastructure
- Azure Resource Group
- Virtual Network with segmented subnets (application / private)
- Log Analytics Workspace for centralized monitoring
- Azure Storage Account
- Azure Key Vault with access policies

#Application Layer
- Azure Storage Static Website for application hosting
- Custom `index.html` and `404.html` pages
- App Service Plan and Linux Web App included as optional, feature-flagged components**, allowing seamless enablement in environments where compute quotas are available

---

#Project Structure



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

#Key Concepts Demonstrated

- Modular Terraform design
- Environment separation (dev / prod)
- Importing existing Azure resources into Terraform state
- Feature flags for quota-heavy services
- Secure handling of secrets with Azure Key Vault
- Trial-safe application deployment using Azure Storage Static Website

#How to Run (Dev)

cd environments/dev
terraform init
terraform plan
terraform apply

#Notes

- App Service is disabled by default to avoid Azure Free/Trial quota failures.
- Static Website provides a working endpoint without paid compute.
- No secrets or state files are committed to GitHub.

#Author

Built by TOBI SALAMI as a hands-on Azure + Terraform infrastructure project.


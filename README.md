# Simple Cloud-Based File Storage with Bash and Azure CLI

## Project Overview
This project is a simple cloud-based file storage system built using Bash scripting and Azure CLI. It uses Azure Blob Storage as the cloud storage backend.

## Features
- Create Azure resource group
- Create Azure storage account
- Create blob container with public access
- Upload files
- List files
- Download files
- Delete files
- Log storage actions with timestamps

## Files
- `deploy.sh` - deploys the Azure infrastructure
- `file_manager.sh` - manages file operations
- `config.env` - stores configuration values
- `logs/storage.log` - stores activity logs

## Deployment
Run:

```bash
bash deploy.sh

```

## Screenshots
### Azure CLI
![Azure CLI](screenshots/azure-cli.png)

### Azure Login Show
![Azure Login Show](screenshots/azure-login-show.png)

### Blob Container
![Blob Container](screenshots/blob-container.png)

### Resource Group
![Resource Group](screenshots/resource-group.png)

### Storage Account
![Storage Account](screenshots/storage-account.png)

### Delete Success
![Delete Success](screenshots/delete-success.png)

### Download Success
![Download Success](screenshots/download-success.png)

### List Success
![List Success](screenshots/list-success.png)

### Upload List Success
![Upload Success](screenshots/upload-list-success.png)

### GitHub Run Azure Storage
![Git Hub Run](screenshots/github-run-azure-storage.png)

### GitHub Azure Storage
![GitHub Azure Storage](screenshots/github-storage-job-success.png)

## Conclusion
This project demostrates how Bash Scripting, Azure CLI, Azure Blob Storage, and GitHub Actions can be combined to automate cloud storage deployment and file management.

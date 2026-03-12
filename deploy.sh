#!/bin/bash

set -e

source config.env

if ! az account show > /dev/null 2>&1; then
  echo "You are not logged into Azure. Run: az login"
  exit 1
fi

mkdir -p logs

printf "%s - %s\n" "$(date)" "Starting deployment..." >> "$LOG_FILE"

echo "Creating resource group..."
az group create --name $RESOURCE_GROUP --location $LOCATION

echo "Creating storage account..."
az storage account create \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS \
  --kind StorageV2 \
  --allow-blob-public-access true

echo "Getting storage account key..."
ACCOUNT_KEY=$(az storage account keys list \
  --resource-group $RESOURCE_GROUP \
  --account-name $STORAGE_ACCOUNT \
  --query "[0].value" \
  --output tsv)

echo "Creating blob container..."
az storage container create \
  --name $CONTAINER_NAME \
  --account-name $STORAGE_ACCOUNT \
  --account-key $ACCOUNT_KEY \
  --public-access blob

printf "%s - %s\n" "$(date)" "Deployment completed successfully." >> "$LOG_FILE"

echo "Deployment complete."
echo "Storage Account: $STORAGE_ACCOUNT"
echo "Container Name: $CONTAINER_NAME"
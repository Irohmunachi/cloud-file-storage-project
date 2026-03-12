#!/bin/bash

set -e

source config.env

if ! az account show > /dev/null 2>&1; then
  echo "You are not logged into Azure. Run: az login"
  exit 1
fi

mkdir -p logs downloads

ACCOUNT_KEY=$(az storage account keys list \
  --resource-group $RESOURCE_GROUP \
  --account-name $STORAGE_ACCOUNT \
  --query "[0].value" \
  --output tsv)

log_action() {
  mkdir -p logs
  printf "%s - %s\n" "$(date)" "$1" >> "$LOG_FILE"
}

upload_file() {
  FILE_PATH="$1"

  if [ ! -f "$FILE_PATH" ]; then
    echo "File not found: $FILE_PATH"
    exit 1
  fi

  az storage blob upload \
    --account-name $STORAGE_ACCOUNT \
    --account-key $ACCOUNT_KEY \
    --container-name $CONTAINER_NAME \
    --file "$FILE_PATH" \
    --name "$(basename "$FILE_PATH")" \
    --overwrite true

  echo "File uploaded successfully."
  log_action "Uploaded file: $FILE_PATH"
}

list_files() {
  az storage blob list \
    --account-name $STORAGE_ACCOUNT \
    --account-key $ACCOUNT_KEY \
    --container-name $CONTAINER_NAME \
    --output table

  log_action "Listed files"
}

download_file() {
  FILE_NAME="$1"

  az storage blob download \
    --account-name $STORAGE_ACCOUNT \
    --account-key $ACCOUNT_KEY \
    --container-name $CONTAINER_NAME \
    --name "$FILE_NAME" \
    --file "downloads/$FILE_NAME"

  echo "File downloaded successfully to downloads/$FILE_NAME"
  log_action "Downloaded file: $FILE_NAME"
}

delete_file() {
  FILE_NAME="$1"

  az storage blob delete \
    --account-name $STORAGE_ACCOUNT \
    --account-key $ACCOUNT_KEY \
    --container-name $CONTAINER_NAME \
    --name "$FILE_NAME"

  echo "File deleted successfully."
  log_action "Deleted file: $FILE_NAME"
}

case "$1" in
  upload)
    upload_file "$2"
    ;;
  list)
    list_files
    ;;
  download)
    download_file "$2"
    ;;
  delete)
    delete_file "$2"
    ;;
  *)
    echo "Usage:"
    echo "./file_manager.sh upload <file_path>"
    echo "./file_manager.sh list"
    echo "./file_manager.sh download <file_name>"
    echo "./file_manager.sh delete <file_name>"
    exit 1
    ;;
esac
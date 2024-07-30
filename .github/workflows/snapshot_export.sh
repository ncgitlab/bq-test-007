#!/bin/bash

# Read arguments
PROJECT_ID=$1
DATASET=$2
GCS_BUCKET=$3
ENVIRONMENT=$4

# List the files in the schema directory
echo "Listing files in the schema directory:"
cd ../../
ls -l ${SCHEMA_DIR}


# Path to the directory containing schema files
SCHEMA_DIR="15-docqa-app-infra/env/${ENVIRONMENT}/bq-schema"
# Read table names from the schema files in the directory
for SCHEMA_FILE in ${SCHEMA_DIR}/*.json; do
  # Extract the table name from the file name
  TABLE_NAME=$(basename "${SCHEMA_FILE}" .json)

  SNAPSHOT_TABLE="${TABLE_NAME}_$(date +"%Y_%m_%d")"
  FILENAME="${SNAPSHOT_TABLE}"

  # Create a snapshot table
  echo -e "Creating snapshot for the table ${TABLE_NAME}.\n"
  #bq cp --snapshot --no_clobber ${DATASET}.${TABLE_NAME} ${DATASET}.${SNAPSHOT_TABLE}

  # Export the snapshot table to GCS
  echo -e "Exporting snapshot table to bucket ${GCS_BUCKET} and filename is ${FILENAME}.\n"
  #bq extract --destination_format=PARQUET "${PROJECT_ID}:${DATASET}.${SNAPSHOT_TABLE}" \
  #"gs://${GCS_BUCKET}/${FILENAME}"
done

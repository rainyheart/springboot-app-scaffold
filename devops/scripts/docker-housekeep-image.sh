#!/bin/bash

# This script is used to clean up old Docker images to prevent disk space issues
# It keeps only the latest N versions of each image

# Environment variables:
# DOCKER_IMAGE_NAME - The name of the Docker image to clean up
# KEEP_VERSIONS - Number of versions to keep (default: 3)

echo "> DOCKER HOUSEKEEP for ${DOCKER_IMAGE_NAME} begin"

if [[ ${DOCKER_IMAGE_NAME} == '' ]]; then
    echo "Please set DOCKER_IMAGE_NAME environment variable first"
    exit 1
fi

# Default to keeping 3 versions if not specified
KEEP_VERSIONS=${KEEP_VERSIONS:-3}
echo ">> Will keep ${KEEP_VERSIONS} latest versions"

# Get list of all image IDs for this image name, sorted by creation date
IMAGE_IDS=$(sudo docker images "${DOCKER_IMAGE_NAME}" --format "{{.ID}}" | sort -r)
TOTAL_VERSIONS=$(echo "${IMAGE_IDS}" | wc -l)

echo ">> Found ${TOTAL_VERSIONS} versions of ${DOCKER_IMAGE_NAME}"

if [ ${TOTAL_VERSIONS} -le ${KEEP_VERSIONS} ]; then
    echo ">> No cleanup needed, number of versions (${TOTAL_VERSIONS}) <= keep versions (${KEEP_VERSIONS})"
    exit 0
fi

# Calculate how many versions to remove
REMOVE_COUNT=$((TOTAL_VERSIONS - KEEP_VERSIONS))
echo ">> Will remove ${REMOVE_COUNT} old versions"

# Get the list of image IDs to remove (skip the first KEEP_VERSIONS)
REMOVE_IDS=$(echo "${IMAGE_IDS}" | tail -n ${REMOVE_COUNT})

# Remove each old image
for IMAGE_ID in ${REMOVE_IDS}; do
    echo ">>> Removing image ${IMAGE_ID}"
    sudo docker rmi -f "${IMAGE_ID}"
done

echo "> DOCKER HOUSEKEEP for ${DOCKER_IMAGE_NAME} completed successfully"
exit 0

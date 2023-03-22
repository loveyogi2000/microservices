#!/bin/bash

# Set the Docker Hub username
DOCKER_USERNAME="loveyogi2000"

# Get the IDs and names of all running containers
CONTAINERS=$(docker ps --format "{{.ID}}:{{.Names}}")

# Loop through each container and push it to Docker Hub
for CONTAINER in $CONTAINERS; do
    # Get the container ID and name
    ID=$(echo $CONTAINER | cut -d: -f1)
    NAME=$(echo $CONTAINER | cut -d: -f2)

    # Create a new tag for the container
    TAG="$DOCKER_USERNAME/$NAME"

    # Commit the container to a new image with the new tag
    docker commit $ID $TAG

    # Push the new image to Docker Hub
    docker push $TAG

    # Remove the local image
    docker rmi $TAG
done

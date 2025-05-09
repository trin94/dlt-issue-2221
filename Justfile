set dotenv-load := true

CONTAINER_NAME := 'raw-data'

@_list:
    just --list

# Start all docker compose services
[group('init')]
start-dev-env:
    mkdir -p dev-env/azurite
    docker compose -f dev-env/docker-compose.yml up -d

# Create container and batch upload a directory
[group('init')]
setup-dev-env UPLOAD_DIRECTORY:
    az storage container create --name {{ CONTAINER_NAME }}
    az storage blob upload-batch -d '{{ CONTAINER_NAME }}' -s '{{ UPLOAD_DIRECTORY }}'

# Stop all docker compose services
[group('init')]
stop-dev-env:
    docker compose -f dev-env/docker-compose.yml down

# Stop all docker compose services AND remove volumes and data
[group('init')]
clear-dev-env:
    docker compose -f dev-env/docker-compose.yml down --volumes
    rm -rf dev-env/azurite || true

# Regenerate lock file and install dependencies
[group('run')]
install-deps:
	poetry lock --regenerate
	poetry sync

# Run dlt pipeline
[group('run')]
run-dlt:
	poetry run python main.py

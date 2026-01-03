# cobalt-docker

This project provides a working docker-compose setup for both the cobalt API and web UI.

## Setup

1. Copy the provided `.env` file to the project root (or edit as needed):
	```sh
	cp .env cobalt-docker/
	```

2. Edit `.env` to set your API and web URLs/ports as needed.

3. Build and start the containers:
	```sh
	docker compose up -d --build
	```

## Repository

Source: [imputnet/cobalt](https://github.com/imputnet/cobalt)

## Notes

- The web UI container will always pull the latest code from GitHub during build.
- All configuration is handled via the `.env` file and docker-compose.yml.

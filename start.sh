#!/bin/bash
set -e
docker-compose down -v --remove-orphans
docker-compose up --build -d
#!/bin/bash
set -e
docker container prune -f
docker-compose -f $1 down -v --remove-orphans
docker-compose -f $1 up --build
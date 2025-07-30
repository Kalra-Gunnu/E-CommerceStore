#!/bin/bash
docker login

services=(user product cart order)

for svc in "${services[@]}"; do
  echo "Building and pushing $svc-service..."
  cd backend/${svc}-service || { echo "Directory backend/${svc}-service not found"; exit 1; }
  docker build -t kalra1994/${svc}-service:latest .
  docker push kalra1994/${svc}-service:latest
  cd - || exit
done

echo "Building and pushing frontend..."
cd frontend || { echo "Directory frontend not found"; exit 1; }
docker build -t kalra1994/frontend:latest .
docker push kalra1994/frontend:latest
cd - || exit
echo "All images built and pushed successfully."
read -p "Press Enter to exit..."

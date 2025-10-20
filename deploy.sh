#!/bin/bash
set -e

echo "Deploying all compose services..."

for folder in compose/*; do
  if [ -f "$folder/docker-compose.yml" ]; then
    echo ""
    echo "=== Deploying $(basename "$folder") ==="
    cd "$folder"
    
    echo "Stopping services..."
    doppler run -- docker compose down
    
    echo "Pulling latest images..."
    doppler run -- docker compose pull
    
    echo "Starting services..."
    doppler run -- docker compose up -d
    
    cd - > /dev/null
  fi
done

echo ""
echo "All services deployed successfully!"

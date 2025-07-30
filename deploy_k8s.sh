#!/bin/bash

K8S_DIR="./k8s"

echo "📦 Creating namespace..."
kubectl apply -f ${K8S_DIR}/namespace.yaml

echo "Applying MongoDB resources..."
kubectl apply -f ${K8S_DIR}/mongo.yaml -n ecommerce

echo "⏳ Waiting for MongoDB to be ready..."
kubectl wait --for=condition=ready pod -l app=mongo -n ecommerce --timeout=60s

echo "Applying User Service resources..."
kubectl apply -f ${K8S_DIR}/user-service.yaml -n ecommerce

echo "Applying Product Service resources..."
kubectl apply -f ${K8S_DIR}/product-service.yaml -n ecommerce

echo "Applying Cart Service resources..."
kubectl apply -f ${K8S_DIR}/cart-service.yaml -n ecommerce

echo "Applying Order Service resources..."
kubectl apply -f ${K8S_DIR}/order-service.yaml -n ecommerce

echo "Applying Frontend resources..."
kubectl apply -f ${K8S_DIR}/frontend.yaml -n ecommerce

echo "Done!"
echo
echo "Check status with: kubectl get pods -n ecommerce"
echo "Check services with: kubectl get svc -n ecommerce"

kubectl get pods -n ecommerce
read -p "Press Enter to exit..."

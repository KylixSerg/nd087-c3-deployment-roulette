#!/bin/sh

set -e


echo 'Deploying green ...'
kubectl apply -f starter/apps/blue-green/green.yml

echo 'green deployment in progress'
kubectl -n udacity rollout status deployment/green
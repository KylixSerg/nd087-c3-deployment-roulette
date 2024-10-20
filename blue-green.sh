#!/bin/sh

set -e


echo 'Deploying green ...'
kubectl apply -f starter/apps/blue-green/green.yml

echo 'green deployment in progress'
kubectl -n udacity rollout status deployment/green

echo 'checking green service reachable'
svc_hostname=$(kubectl get services \
   --namespace udacity \
    green-svc \
   --output jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo $svc_hostname
until curl --output /dev/null --silent --head --fail $svc_hostname; do
    printf 'service no ready yet ..'
    sleep 5
done

printf 'service ready!'
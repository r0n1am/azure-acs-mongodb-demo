#!/bin/sh
##
# Script to remove/undepoy all project resources from Azure AKS.
##

# Delete mongod stateful set + mongodb service + secrets + host vm configuer daemonset
kubectl delete statefulsets mongod
kubectl delete services mongodb-service
kubectl delete secret shared-bootstrap-data
kubectl delete daemonset hostvm-configurer
sleep 3

# Delete persistent volume claims
kubectl delete persistentvolumeclaims -l role=mongo
sleep 3

# Delete whole Kubernetes cluster
echo "Deleting AKS orchestrator"
az aks delete --name MongoK8sCluster --resource-group MongoResourceGroup --yes

# Delete the whole Azure resource group including all its asets
echo "Deleting Azure group"
az group delete --yes --name MongoResourceGroup


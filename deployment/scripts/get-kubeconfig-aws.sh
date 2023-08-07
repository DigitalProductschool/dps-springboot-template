CLUSTER_NAME=$1

aws eks update-kubeconfig --region eu-central-1 \
    --name $CLUSTER_NAME --kubeconfig $PWD/kubeconfig-$CLUSTER_NAME.yaml

chmod 600 kubeconfig-$CLUSTER_NAME.yaml
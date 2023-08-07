NAMESPACE=$1
CLUSTERNAME=$2

FILE_PATH=app-${NAMESPACE}/postgres.yaml


cp deployment/templates/postgres.yaml $FILE_PATH
yq --inplace ".metadata.namespace = \"${NAMESPACE}\"" $FILE_PATH
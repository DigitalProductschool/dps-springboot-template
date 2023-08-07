NAMESPACE=$1


FILE_PATH=deployment/app-${NAMESPACE}/postgres.yaml


cp deployment/templates/postgres.yaml $FILE_PATH
yq --inplace ".metadata.namespace = \"${NAMESPACE}\"" $FILE_PATH
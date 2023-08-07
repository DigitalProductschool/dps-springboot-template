NAMESPACE=$1
REPONAME=$2

FILE_PATH=deployment/app-${NAMESPACE}/postgres.yaml


cp deployment/templates/postgres.yaml $FILE_PATH
yq --inplace ".metadata.name = \"${REPONAME}-pg\"" $FILE_PATH
yq --inplace ".spec.id = \"${REPONAME}-pg\"" $FILE_PATH
yq --inplace ".spec.parameters.namespace = \"${NAMESPACE}\"" $FILE_PATH
yq --inplace ".spec.writeConnectionSecretToRef.name = \"${REPONAME}-pg\"" $FILE_PATH
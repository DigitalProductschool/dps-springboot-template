NAMESPACE=$1
REPONAME=$2

FILE_PATH=deployment/app-${NAMESPACE}/aws-rds.yaml


cp deployment/templates/postgres.yaml $FILE_PATH
yq --inplace ".metadata.name = \"${REPONAME}-${NAMESPACE}-pg\"" $FILE_PATH
yq --inplace ".spec.id = \"${REPONAME}-${NAMESPACE}-pg\"" $FILE_PATH
yq --inplace ".spec.writeConnectionSecretToRef.name = \"${REPONAME}-${NAMESPACE}-pg\"" $FILE_PATH
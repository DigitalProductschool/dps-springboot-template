ENV=$1
REPONAME=$2
PROVIDER=$3
VERSION=$4
SIZE=$5

FILE_PATH=deployment/app-${ENV}/${PROVIDER}-pg.yaml
RANDOM_NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 5 | head -n 1)
FILE_PATH2=deployment/app-${ENV}/${PROVIDER}-pg-secret.yaml
PASS_LENGTH=10
RANDOM_PASSWORD=$(openssl rand -base64 48 | tr -dc 'a-zA-Z0-9' | head -c $password_length)


cp deployment/templates/postgres.yaml $FILE_PATH
yq --inplace ".metadata.name = \"${RANDOM_NAME}-pg-${ENV}\"" $FILE_PATH
yq --inplace ".metadata.namespace = \"${ENV}\"" $FILE_PATH
yq --inplace ".spec.id = \"${RANDOM_NAME}-pg-${ENV}\"" $FILE_PATH
yq --inplace ".spec.compositionSelector.matchLabels.provider = \"${PROVIDER}\"" $FILE_PATH
yq --inplace ".spec.parameters.version = \"${VERSION}\"" $FILE_PATH
yq --inplace ".spec.parameters.size = \"${SIZE}\"" $FILE_PATH
yq --inplace ".spec.writeConnectionSecretToRef.name = \"${RANDOM_NAME}-pg-${ENV}\"" $FILE_PATH



cp deployment/templates/postgres-pass.yaml $FILE_PATH2
yq --inplace ".metadata.name = \"${RANDOM_NAME}-pg-${ENV}-password\"" $FILE_PATH2

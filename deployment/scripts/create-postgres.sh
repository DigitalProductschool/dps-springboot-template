ENV=$1
REPONAME=$2
PROVIDER=$3
VERSION=$4
SIZE=$5
ACCOUNT=$6

FILE_PATH=deployment/app-${ENV}/${ACCOUNT}-${PROVIDER}-pg.yaml

cp deployment/templates/postgres.yaml $FILE_PATH
yq --inplace ".spec.target.name = \"${REPONAME}-pg-${ENV}-password\"" $FILE_PATH
yq --inplace ".metadata.name = \"${REPONAME}-pg-${ENV}\"" $FILE_PATH
yq --inplace ".spec.id = \"${REPONAME}-pg-${ENV}\"" $FILE_PATH
yq --inplace ".spec.compositionSelector.matchLabels.provider = \"${PROVIDER}\"" $FILE_PATH
yq --inplace ".spec.parameters.version = \"${VERSION}\"" $FILE_PATH
yq --inplace ".spec.parameters.size = \"${SIZE}\"" $FILE_PATH
yq --inplace ".spec.parameters.providerName = \"${ACCOUNT}\"" $FILE_PATH
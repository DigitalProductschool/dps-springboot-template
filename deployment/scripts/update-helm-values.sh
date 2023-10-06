VERSION=$1
IMAGE=$2
PROVIDER=$3
ENV=$4
SIZE=$5
ACCOUNT=$6
HOST=$7

CHART_FILE=deployment/app-${ENV}/Chart.yaml
VALUES_FILE=deployment/app-${ENV}/values.yaml

DIRECTORY=deployment/app-${ENV}

cp -r deployment/templates/helm/app/* $DIRECTORY

yq --inplace ".version = \"${VERSION}\"" $CHART_FILE
yq --inplace ".image.tag = \"${VERSION}\"" $VALUES_FILE
yq --inplace ".image.repository = \"${IMAGE}\"" $VALUES_FILE
yq --inplace ".db.size = \"${SIZE}\"" $VALUES_FILE
yq --inplace ".db.providerName = \"${ACCOUNT}\"" $VALUES_FILE
yq --inplace ".ingress.host = \"${HOST}\"" $VALUES_FILE
yq --inplace ".db.id = \"${ACCOUNT}-pg-${ENV}\"" $VALUES_FILE
if [[ "$PROVIDER" == "aws-official" ]]; then
    yq --inplace ".db.enabled.crossplane.aws = \"true\"" $VALUES_FILE
elif [[ "$PROVIDER" == "azure-official" ]]; then
    yq --inplace ".db.enabled.crossplane.azure = \"true\"" $VALUES_FILE
elif [[ "$PROVIDER" == "google-official" ]]; then
    yq --inplace ".db.enabled.crossplane.google = \"true\"" $VALUES_FILE
fi
# Check if all required arguments are provided
if [ $# -ne 8 ]; then
    echo "Usage: $0 <VERSION> <IMAGE> <PROVIDER> <ENV> <SIZE> <ACCOUNT> <HOST> <CONTEXT>"
    exit 1
fi

# Assign arguments to variables
VERSION=$1
IMAGE=$2
PROVIDER=$3
ENV=$4
SIZE=$5
ACCOUNT=$6
HOST=$7
CONTEXT=$8

# Define the destination directory based on the environment
DIRECTORY=deployment/app-${ENV}

# Paths to Chart.yaml and values.yaml
CHART_FILE=$DIRECTORY/Chart.yaml
VALUES_FILE=$DIRECTORY/values.yaml

# Copy the contents of the app template to the destination directory
cp -r deployment/templates/helm/app/* $DIRECTORY

# Update values in values.yaml based on context and provider
if [[ "$CONTEXT" == "backend" ]]; then
    yq --inplace ".db.size = \"${SIZE}\"" $VALUES_FILE
    yq --inplace ".db.providerName = \"${ACCOUNT}\"" $VALUES_FILE
    yq --inplace ".db.id = \"${ACCOUNT}-pg-${ENV}\"" $VALUES_FILE
    case "$PROVIDER" in
        aws-official)    DB_ENABLED=".db.enabled.crossplane.aws" ;;
        azure-official)  DB_ENABLED=".db.enabled.crossplane.azure" ;;
        google-official) DB_ENABLED=".db.enabled.crossplane.google" ;;
    esac
    yq --inplace ".$DB_ENABLED = \"true\"" "$VALUES_FILE"
fi

# Update values in Chart.yaml and values.yaml
yq --inplace ".${CONTEXT}.enabled = \"true\"" $VALUES_FILE
yq --inplace ".version = \"${VERSION}\"" $CHART_FILE
yq --inplace ".${CONTEXT}.image.tag = \"${VERSION}\"" $VALUES_FILE
yq --inplace ".${CONTEXT}.image.repository = \"${IMAGE}\"" $VALUES_FILE
yq --inplace ".ingress.host = \"${HOST}\"" $VALUES_FILE
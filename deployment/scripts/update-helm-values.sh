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
cp -r deployment/templates/helm/$CONTEXT/* $DIRECTORY

# Update values in values.yaml based on context and provider
if [[ "$CONTEXT" == "backend" ]]; then
    yq --inplace ".db.size = \"${SIZE}\"" $VALUES_FILE
    yq --inplace ".db.providerName = \"${ACCOUNT}\"" $VALUES_FILE
    yq --inplace ".db.id = \"${ACCOUNT}-pg-${ENV}\"" $VALUES_FILE
    case "$PROVIDER" in
        aws-official)    yq --inplace ".db.enabled.crossplane.aws = \"true\"" "$VALUES_FILE" ;;
        azure-official)  yq --inplace ".db.enabled.crossplane.azure = \"true\"" "$VALUES_FILE" ;;
        google-official) yq --inplace ".db.enabled.crossplane.google = \"true\"" "$VALUES_FILE" ;;
    esac
fi

# Update values in Chart.yaml and values.yaml
yq --inplace ".version = \"${VERSION}\"" $CHART_FILE
yq --inplace ".image.tag = \"${VERSION}\"" $VALUES_FILE
yq --inplace ".image.repository = \"${IMAGE}\"" $VALUES_FILE
yq --inplace ".ingress.host = \"${HOST}\"" $VALUES_FILE
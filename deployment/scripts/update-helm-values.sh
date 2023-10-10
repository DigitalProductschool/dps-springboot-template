# Assign arguments to variables
VERSION=$1
IMAGE=$2
PROVIDER=$3
ENV=$4
SIZE=$5
ACCOUNT=$6
HOST=$7
CONTEXT=$8
REPO=$9

# Define the destination and source directories based on the environment and the context
SOURCE_DIR="deployment/templates/helm/${CONTEXT}"
DESTINATION_DIR="deployment/app-${ENV}/${CONTEXT}"

mkdir -p "$DESTINATION_DIR"

# Copy the helm chart to the destination directory
cp -r "$SOURCE_DIR"/* "$DESTINATION_DIR/"

# Paths to Chart.yaml and values.yaml
CHART_FILE=$DESTINATION_DIR/Chart.yaml
VALUES_FILE=$DESTINATION_DIR/values.yaml

VERSION_NO_DOTS=$(echo "$VERSION" | sed 's/\.//g')
REPO_MODIFIED=$(echo "$REPO" | sed 's/^[^-]*--//')

# Update values in values.yaml based on context and provider
if [[ "$CONTEXT" == "backend" ]]; then
    yq --inplace ".db.size = \"${SIZE}\"" $VALUES_FILE
    yq --inplace ".db.providerName = \"${ACCOUNT}\"" $VALUES_FILE
    yq --inplace ".db.id = \"${REPO_MODIFIED}-${ENV}-${VERSION_NO_DOTS}\"" $VALUES_FILE
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
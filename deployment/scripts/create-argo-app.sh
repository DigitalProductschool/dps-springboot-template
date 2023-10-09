# Assign arguments to variables
ENV=$1
CONTEXT=$2
REPO=$3

FILE_PATH=deployment/app-${ENV}/app-${CONTEXT}.yaml

DIRECTORY=deployment/app-${ENV}

cp  deployment/templates/argocd/app-${CONTEXT}.yaml $FILE_PATH


ENVIRONMENT="dev"
if [[ "$ENV" == "prod" ]]; then
    ENVIRONMENT="production"
fi

yq --inplace ".metadata.name = \"${CONTEXT}-${ENV}\"" $FILE_PATH
yq --inplace ".spec.project = \"${ENVIRONMENT}\"" $FILE_PATH
yq --inplace ".spec.source.repoURL = \"https://github.com/DigitalProductschool/${REPO}.git\"" $FILE_PATH
yq --inplace ".spec.source.path = \"${DIRECTORY}/${CONTEXT}\"" $FILE_PATH
yq --inplace ".spec.destination.namespace = \"${ENV}\"" $FILE_PATH
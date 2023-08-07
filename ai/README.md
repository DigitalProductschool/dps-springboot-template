# AI Project Template: `Bank Loan Classification`
<hr></hr>

### Goal:
This is a sample `Bank Loan Classification` project template where we are using a binary classification model to classify whether to grant loans to applicants or not. 

### Dataset
The `Bank Loan Classification` dataset used during the workshop is taken from Kaggle and can be found <a href='https://www.kaggle.com/sriharipramod/bank-loan-classification'>`here`</a>.

### Project Requirements 
```bash
- Python3.9
- git
- Docker
```
### Project Structure

```bash
Loan Classification Project
├── models
│   └── RF_Model_V1.pkl
├── Dockerfile
├── requirements.txt
├── deployment.yaml
├── model_api.py
└── streamlit_app.py
```
    
### Accessing Deployed App
After completing the tasks your deployed model **API** can be accessed from the ai service endpoint in your cluster. You can also append `/docs` to the endpoint to have access to the Swagger UI for API Testing.
  
### Project Steps

- `Step 1`: Cloning the repo

```bash
git clone https://github.com/DigitalProductschool/react-spring-template.git
```

 
- `Step 2`: Changing working directory to ai

```bash
cd react-spring-template/ai/
```
 
- `Step 3`: Installing dependencies using pip3
 
```bash
pip3 install -r requirements.txt
```
  
- `Step 4`: Running uvicorn server ***locally***

```bash
python3 model_api.py
```
**Note**: Go to `/docs` route to test the api. 

- `Step 5`: Building the runner container image ***locally***
```
docker build -t ai-run-image -f run.Dockerfile .
```
- `Step 6`: Building the container image for our ai app using the Google Cloud Run builder ***locally***

```
pack build ai:dev --env-file ./pack_envfile --builder gcr.io/buildpacks/builder:v1 --run-image ai-run-image  
```

> --env-file ./pack_envfile pass an env file to the build 

> --run-image ai-run-image  use the custom run image called ai-run-image 


- `Step 7`: Running the container ***locally***

```
docker run --rm -d -p 8000:8000 -p 8501:8501 ai:dev 
```
**Note**: Visit port `8501` to access Streamlit Application and `8000/docs` route to test the api. 

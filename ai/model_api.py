
import pandas as pd
from pycaret.classification import load_model, predict_model
from fastapi import FastAPI
import uvicorn

# Create the app
app = FastAPI()

# Load trained Pipeline
model = load_model('models/RF_Model_V1')

# Define predict function
@app.post('/predict')
def predict(Age, Experience, Income, Family, CCAvg, Education, Mortgage, SecuritiesAccount, CDAccount, Online, CreditCard):
    data = pd.DataFrame([[Age, Experience, Income, Family, CCAvg, Education, Mortgage, SecuritiesAccount, CDAccount, Online, CreditCard]])
    data.columns = ['Age', 'Experience', 'Income', 'Family', 'CCAvg', 'Education', 'Mortgage', 'SecuritiesAccount', 'CDAccount', 'Online', 'CreditCard']
    predictions = predict_model(model, data=data) 
    return {'prediction': list(predictions['Label'])}

if __name__ == '__main__':
    uvicorn.run(app, host='0.0.0.0', port=8000)

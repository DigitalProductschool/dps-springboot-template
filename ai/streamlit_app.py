# -*- coding: utf-8 -*-
"""
@author: Muhammad Ali
@github: @alihussainia
"""

import streamlit as st
import requests
import pandas as pd
import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)

st.set_page_config(page_title="Loan Classification", page_icon="dollar", layout='centered', initial_sidebar_state='auto')

st.title('Loan Classification Web App')
st.write('This is a web app to classify whether a person is eligible for a loan or not based on\
        several features that you can see in the sidebar. Please adjust the\
        value of each feature. After that, click on the Predict button at the bottom to\
        see the prediction.')

Age = int(st.sidebar.number_input(label = 'Age', value = 37))

Experience = int(st.sidebar.number_input(label = 'Experience', value = 13))

Income = int(st.sidebar.number_input(label = 'Income', value = 29))

Family = st.sidebar.selectbox(
    "Family",
    (1,2,3,4)
)

CCAvg = float(st.sidebar.number_input(label = 'CCAvg', value = 1.6))

CDAccount = st.sidebar.selectbox(
    "CDAccount",
    (0,1)
)

SecuritiesAccount = st.sidebar.selectbox(
    "SecuritiesAccount",
    (0,1)
)

Education = st.sidebar.selectbox(
    "Education",
    (1,2,3)
)

Mortgage = int(st.sidebar.number_input(label = 'Mortgage', value = 155))

Online = st.sidebar.selectbox(
    "Online",
    (0,1)
)

CreditCard = st.sidebar.selectbox(
    "CreditCard",
    (0,1)
)

features={
    'Age':Age, 
    'Experience':Experience,
    'Income':Income,
    'Family':Family,
    'CCAvg': CCAvg,
    'Education':Education,	
    'Mortgage':Mortgage,
    'SecuritiesAccount':SecuritiesAccount,	
    'CDAccount':CDAccount,	
    'Online':Online,
    'CreditCard':CreditCard}

features_df  = pd.DataFrame([features])

st.table(features_df)  

submit_button = st.button('Predict')
payload={}

if submit_button:
  payload = features

  response = requests.post("http://127.0.0.1:8000/predict", params=payload).json()
  
  response = response["prediction"][0]

  if response == 1:
        st.balloons()
        response = st.success("ACCEPTED")
  else:
        response = st.error("REJECTED")
  
st.write('')
st.write('')
st.write('')

st.markdown("App developed with 💖 by [@alihussainia](https://www.github.com/alihussainia)")

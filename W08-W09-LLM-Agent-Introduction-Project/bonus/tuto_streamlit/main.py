from langchain_openai import ChatOpenAI
from langchain_ollama import ChatOllama

import streamlit as st


st.title("🦜🔗 Quickstart App")

def generate_response(input_text):
    model = ChatOllama(model="llama3.2")
    st.info(model.invoke(input_text))

with st.form("my_form"):
    text = st.text_area(
        "Enter text:",
        "What are the three key pieces of advice for learning how to code?",
    )
    submitted = st.form_submit_button("Submit")
    if submitted:
        generate_response(text)
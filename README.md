# 🧠 Simplon AI Developer Training — Progress Tracking

Tracking my progress throughout the **Simplon AI Developer training** week by week.

---

## 🗕️ WEEK 1

**Teacher**: [Sengsathit](https://github.com/Sengsathit)

### 📚 Topics Covered

* Training program presentation
* Python refresher course
* UML concept introduction

### 🛠️ Miniprojects

* `library` (with command line controls)
* `hangman` game

### 🏱️ Bonus

* Unified Modeling Language presentation
  *(with [CSAADZIDI](https://github.com/CSAADZIDI) & [aruide](https://github.com/aruide))*

---

## 🗕 WEEK 2

**Teacher**: Salsabil

### 📚 Topics Covered

* Linux/VM command line
* Pandas & PostgreSQL introduction/exercises

### 🛠️ Miniproject

* Choose and explore a dataset from Kaggle

### 👨‍💻 Personal Sidework

* Setting up an Ubuntu/Windows 11 dual boot
* Dockerizing PostgreSQL to carry databases between the two
* PowerBI introductory course

---

## 🗕 WEEKS 3–4

**Teachers**: [Sengsathit](https://github.com/Sengsathit) / Salsabil

### 📚 Topics Covered

* Git introduction
* Group project over 2 weeks

### 🛠️ Miniprojects

* `defi-git` *(learn to work on a Git repo together)*
* `casse-tete` *(learn how to deal with conflicts)*

## 👥 Group Project

**Team**: [CSAADZIDI](https://github.com/CSAADZIDI) & [aruide](https://github.com/aruide)

### 🔬 Project: Wa-Tor

> The goal is to emulate an ecosystem of sharks and fishes, where sharks eat the fishes if they are next to them, and fishes avoid them if they can. Each species will reproduce if they live long enough. Everything will be output in a Python interface.

### 🌟 GOALS

* Create the algorithms that dictate the fishes/sharks behavior
* Create an interface for the user to interact with
* Manage persistence (simulations history)
* Work together through Git

### ✅ What We Ended Up With

* Fully functional simulation
* Interface with:

  * Simulation output
  * Simulation parameter inputs
  * Resizable grid
  * Real-time counters
  * History
  * Pause/resume/cycle through previous turns
* Fully operational persistence through PostgreSQL in 3 tables:

  * One for the simulation parameters and output
  * One for the state of each turn of the simulation
  * One for every entity that existed inside that simulation
* A PowerBI Desktop model using that database to show multiple metrics, globally and/or related to one simulation/parameter

> 📎 [See project README for full details](./W03-W04/wa-tor/Program/README.md)

---

## 🗕️ WEEK 5

**Teacher**: [Sengsathit](https://github.com/Sengsathit)

### 📚 Topics Covered

- Introduction to machine learning concepts and history  
- Linear regression exercise  
- Logistic regression exercise on a breast cancer dataset  
- Working with Numpy, Pandas, and Matplotlib libraries  

### 🛠️ Exercises

- Implementing a basic spam detector in Python (to explore expert systems and their limitations)  
- Jupyter notebooks covering Numpy, Pandas, and Matplotlib usage  
- Linear and logistic regression applied to real datasets  

### 🎓 Bonus

- Completed an additional course on data analysis and dataset cleaning on OpenClassrooms  

---

## 🗕️ WEEKS 6-7

**Teacher**: [Sengsathit](https://github.com/Sengsathit)

### 📚 Topics Covered

- Introduction to deep learning fundamentals  
- Hands-on exercise: binary classification of dogs vs. cats images  
- Working with convolutional neural networks (CNNs) and pretrained models  

### 🛠️ Exercises & Projects

- Building and training a deep learning model for dog vs. cat image classification  
- Experimentation with model fine-tuning and evaluation metrics  

### 🚀 Transfer Learning Project: Pneumonia Detection

- Implementation of a transfer learning pipeline using pretrained CNN architectures  
- Dataset preprocessing and augmentation for medical images  
- Model training, validation, and performance evaluation on pneumonia detection  
- Analysis of results with confusion matrices, ROC curves, and metric comparisons  
- Deployment considerations and integration within a machine learning workflow  

> 📎 [See project README for full details](./W06-07/projet/Transfer-Learning/README.md)

### 🎓 Bonus

- Completed an OpenClassrooms course on visual data classification and segmentation 

---

## 🗕️ WEEKS 8-9

**Teacher**: [Sengsathit](https://github.com/Sengsathit)

### 📚 Topics Covered

- Introduction to large language models (LLMs) and their architecture  
- Exploration of RAG (Retrieval-Augmented Generation) tools and AI agents  
- Introduction and hands-on practice with LangChain framework  

### 🛠️ Exercises & Projects

- Exercises using LangChain to build conversational flows  
- Prompt engineering for task-specific agents  
- Experimenting with memory, tools, and chaining in LangChain  

### 🚀 Final Project: ADA-ChatBot – Citizen AI Agent

- Developed a conversational assistant capable of answering questions on social and administrative rights  
- Integration of LangChain agents, tools, memory, and RAG pipeline (ChromaDB)  
- Clean and intuitive user interface with [Streamlit](https://streamlit.io)  
- Domain-specific tools: eligibility checkers, search filters, summaries  
- Modular Python architecture (agent manager, tool manager, vector DB handler)  

> 📎 [See project README for full details](./W08-W09/project/ai-agent-with-langchain/README.md)

### 🎓 Bonus

- Followed a Streamlit tutorial to enhance understanding of building simple AI app interfaces

---

## 🗕️ WEEK 10

**Teacher**: Salsabil

### 📚 Topics Covered

- Fundamentals of APIs and RESTful architecture  
- HTTP methods, routes, status codes, and authentication mechanisms  
- Using **Postman** for API testing and exploration  
- Automating API tests and workflows using Postman scripting  
- Validating responses and chaining requests in Postman collections  

### 🛠️ Exercises & Projects

- Practical exploration of real-world APIs with Postman  
- Automated validation scripts and environments  
- Secured request chaining with authentication  
- Created an individual project integrating data extraction and REST API exposure with FastAPI  

### 🚀 Final Project: GitHub Users Extractor & FastAPI API

- Built a pipeline to extract and filter user data from the GitHub API  
- Developed a secure REST API using **FastAPI** to expose the cleaned data  
- Implemented authentication with **Basic Auth** and protected endpoints  
- Included search, listing, and user detail features in the API  
- Designed and tested endpoints using Postman and **Pytest**  

> 📎 [See project README for full details](./W10/README.md)

---

### --- TO BE CONTINUED
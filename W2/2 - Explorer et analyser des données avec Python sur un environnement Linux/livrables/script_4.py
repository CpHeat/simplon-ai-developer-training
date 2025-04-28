import pandas as pd

csv_file_path= './Mental Health Dataset.csv'

data =  pd.read_csv(csv_file_path)
data['Days_Indoors']=data['Days_Indoors'].astype('category').cat.codes
data['Mood_Swings']=data['Mood_Swings'].astype('category').cat.codes

# Calcul de la corrélation
correlation = data['Mood_Swings'].corr(data['Days_Indoors'])
print(f"Corrélation: {correlation}")
import numpy as np
import pandas as pd
csv_file_path= '../Mental Health Dataset.csv'

data =  pd.read_csv(csv_file_path)
total_females = data[data['Gender'] == 'Female'].shape[0]
total_males = data[data['Gender'] == 'Male'].shape[0]

percentage_females = total_females / (total_males + total_females)

print("total_females :", total_females)
print("total_males :", total_males)
print(f"Les femmes représentent {percentage_females * 100}% de l'échantillon")
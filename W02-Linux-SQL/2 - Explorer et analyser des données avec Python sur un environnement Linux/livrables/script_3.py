import numpy as np
import pandas as pd
import re

def time_conversion(time):
    time_parts = time.split(":")    
    time_in_seconds = 0
    
    if len(time_parts) == 3:
        i = 0
        
        while i < 3:
            time_parts[i] = re.sub(r"[^\d\.]", "", time_parts[i])
            time_in_seconds += int(time_parts[i]) * (60 ** (2-i))
            i += 1            
    
    return time_in_seconds

def get_mode(results) -> list:

    values, counts = np.unique(results, return_counts=True)

    mode_index = np.argmax(counts)
    mode = values[mode_index]

    return [mode, max(counts)]

csv_file_path= 'Olympics Results.csv'

data =  pd.read_csv(csv_file_path)

# Résultats
male_condition = (data['event'] == '20 Kilometres Race Walk') & (data['sex'] == "M")
data.loc[male_condition, 'mark'] = data.loc[male_condition, 'mark'].apply(time_conversion)
male_results = data.loc[male_condition & (data['mark'] != 0)].copy()

female_condition = (data['event'] == '20 Kilometres Race Walk') & (data['sex'] == "W")
data.loc[female_condition, 'mark'] = data.loc[female_condition, 'mark'].apply(time_conversion)
female_results = data.loc[female_condition & (data['mark'] != 0)].copy()

# Moyenne
mean_male_results = male_results['mark'].mean()
mean_female_results = female_results['mark'].mean()

print(f"Le temps moyen des hommes en finale du 20km marche est de {mean_male_results} secondes")
print(f"Le temps moyen des femmes en finale du 20km marche est de {mean_female_results} secondes")

# Médiane
male_median = male_results['mark'].median()
female_median = female_results['mark'].median()

print(f"La médiane pour les hommes est de {male_median} secondes")
print(f"La médiane pour les femmes est de {female_median} secondes")

# Mode
male_mode = get_mode(male_results['mark'])
female_mode = get_mode(female_results['mark'])

print(f"Le mode pour les hommes est de {male_mode[0]} secondes avec {male_mode[1]} occurrences")
print(f"Le mode pour les femmes est de {female_mode[0]} secondes avec {female_mode[1]} occurrences")

# Variance
print(f"La variance pour les hommes est de {male_results['mark'].var()}")
print(f"La variance pour les femmes est de {female_results['mark'].var()}")

# Ecart type
print(f"L'écart-type' pour les hommes est de {male_results['mark'].std()}")
print(f"L'écart-type' pour les femmes est de {female_results['mark'].std()}")
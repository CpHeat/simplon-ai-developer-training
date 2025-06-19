import pandas as pd

# Chemin relatif (le fichier est dans le même dossier que le script)
csv_file_path = './Mental Health Dataset.csv'

# Chargement des données
data = pd.read_csv(csv_file_path)

every_filter = (
    (data['Country'] == 'United States') &
    (data['Changes_Habits'] == 'No') &
    (data['Mood_Swings'] == 'High') &
    (data['Work_Interest'] == 'Maybe') &
    (data['Social_Weakness'] == 'Yes')
)

us_residents = data[data["Country"] == "United States"]
unchanged_habits = data[data["Changes_Habits"] == "No"]
high_mood_swings = data[data["Mood_Swings"] == "High"]
maybe_work_interested = data[data["Work_Interest"] == "Maybe"]
social_weakness = data[data["Social_Weakness"] == "Yes"]

every_selected = data[every_filter]
male_selected = every_selected[data['Gender'] == 'Male']
female_selected = every_selected[data['Gender'] == 'Female']

print("us_residents :", len(us_residents))
print("unchanged_habits :", len(unchanged_habits))
print("high_mood_swings :", len(high_mood_swings))
print("maybe_work_interested :", len(maybe_work_interested))
print("social_weakness :", len(social_weakness))
print("every_selected :", len(every_selected))
print("male_selected :", len(male_selected))
print("female_selected :", len(female_selected))
import pandas as pd

csv_file_path='Mental Health Dataset.csv'
df =  pd.read_csv(csv_file_path)

df['Timestamp'] = pd.to_datetime(df['Timestamp'], errors='coerce')
df['Month'] = df['Timestamp'].dt.strftime('%B')

pays = ['United States', 'Poland', 'Australia', 'Canada', 'South Africa', 'Sweden', 'Netherlands']

female_df = df[(df['Gender'] == 'Female') & (df['Timestamp'].dt.year == 2014)]
grouped_female = female_df.groupby(['Country', 'Month']).size().reset_index(name='count').sort_values('Month')

male_df = df[(df['Gender'] == 'Male') & (df['Timestamp'].dt.year == 2014)]
grouped_male = male_df.groupby(['Country', 'Month']).size().reset_index(name='count').sort_values('Month')

self_employed_male_df = df[(df['Gender'] == 'Male') & (df['Timestamp'].dt.year == 2015) & (df['self_employed'] == 'Yes')]
self_employed_grouped_male = (self_employed_male_df
                              .groupby(['Country', 'Month'])
                              .size()
                              .unstack(fill_value=0)
                              .reindex(index=['August', 'September', 'October', 'November', 'December'])
                              .reindex(columns=pays, fill_value=0)
                              )

not_self_employed_male_df = df[(df['Gender'] == 'Male') & (df['Timestamp'].dt.year == 2015) & (df['self_employed'] == 'No')]
not_self_employed_grouped_male = not_self_employed_male_df.groupby(['Country', 'Month']).size().reset_index(name='count').sort_values('Month')

no_family_history_male_df = df[(df['Gender'] == 'Male') & (df['Timestamp'].dt.year == 2015) & (df['family_history'] == 'No')]
no_family_history_grouped_male = no_family_history_male_df.groupby(['Country', 'Month']).size().reset_index(name='count').sort_values('Month')

family_history_male_df = df[(df['Gender'] == 'Male') & (df['Timestamp'].dt.year == 2015) & (df['family_history'] == 'Yes')]
family_history_grouped_male = family_history_male_df.groupby(['Country', 'Month']).size().reset_index(name='count').sort_values('Month')

print(self_employed_grouped_male)

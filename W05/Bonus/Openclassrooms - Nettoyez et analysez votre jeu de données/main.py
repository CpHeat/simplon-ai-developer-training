import numpy as np
import pandas as pd

def handle_personnes():
    data = pd.read_csv("data/personnes.csv")
    data.head()
    print(data.isnull().sum())
    print(data.loc[data['email'].duplicated(keep=False),:])

    VALID_COUNTRIES = ['France', 'Côte d\'ivoire', 'Madagascar', 'Bénin', 'Allemagne'
        , 'USA']
    mask = ~data['pays'].isin(VALID_COUNTRIES)
    data.loc[mask, 'pays'] = np.nan

    data['email'] = data['email'].str.split(',', n=1, expand=True)[0]

    data['taille'] = data['taille'].str[:-1]
    data['taille'] = pd.to_numeric(data['taille'], errors='coerce')
    data.loc[data['taille'].isnull(), 'taille'] = data['taille'].mean()

    data['date_naissance'] = pd.to_datetime(data['date_naissance'], format='%d/%m/%Y', errors='coerce')

def handle_operations():
    data = pd.read_csv("data/operations.csv")
    df = pd.DataFrame(data)

    for col in df:
        print(f"{col} : {df[col].unique()}")

def handle_course():
    data = pd.read_csv("data/course-P2-V2.csv", sep=";")
    df = pd.DataFrame(data)

    print(data.isnull().sum())

    print(df[df.duplicated()])
    
    for col in df:
        pass
        #print(f"{col} : {df[col].unique()}")    


if __name__ == '__main__':
    handle_course()
    """
    une catégorie vide
    2 montants nuls
    libelé sans type de transaction

    """
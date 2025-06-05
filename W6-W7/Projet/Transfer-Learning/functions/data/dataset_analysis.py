import os

from matplotlib import pyplot as plt
import pandas as pd
from functions.img.get_images_info import get_images_info
from functions.img.show_images import show_images
from settings import folders


def dataset_analysis():
    df_train_images = get_images_info(folders["train"]["input"])
    df_train_valid = df_train_images[df_train_images["error"] == False]
    df_train_error = df_train_images[df_train_images["error"] == True]
    print("Nombre d'images en erreur :", len(df_train_error))

    # Identifier les images aux valeurs extrêmes
    extremes = pd.concat([
        df_train_valid.loc[df_train_valid["width"].idxmax()],
        df_train_valid.loc[df_train_valid["width"].idxmin()],
        df_train_valid.loc[df_train_valid["height"].idxmax()],
        df_train_valid.loc[df_train_valid["height"].idxmin()],
        df_train_valid.loc[df_train_valid["aspect_ratio"].idxmax()],
        df_train_valid.loc[df_train_valid["aspect_ratio"].idxmin()],
    ], axis=1).T.drop_duplicates()

    # Affichage des images aux valeurs extrêmes
    print("Aperçu des différents formats d'image")
    show_images(extremes.reset_index(drop=True), folder_path=folders["train"]["input"])

    base_path = folders["train"]["input"]

    # Dictionnaire {nom_du_dossier: nombre_d_images}
    image_counts = {}

    # Parcours des sous-dossiers
    for folder_name in os.listdir(base_path):
        folder_path = os.path.join(base_path, folder_name)
        if os.path.isdir(folder_path):
            count = len([
                f for f in os.listdir(folder_path)
            ])
            image_counts[folder_name] = count

    # Préparation des données pour le camembert
    labels = ["Normal", "Pneumonia"]
    sizes = list(image_counts.values())

    # Affichage du camembert
    fig, ax = plt.subplots(figsize=(6, 6))

    # Couleurs dark mode
    fig.patch.set_facecolor('#2e2e2e')
    ax.set_facecolor('#2e2e2e')

    # Texte blanc
    ax.tick_params(colors='white')
    ax.title.set_color('white')

    # Tracer le camembert
    wedges, texts, autotexts = ax.pie(
        sizes, labels=labels, autopct='%1.1f%%', startangle=90, textprops=dict(color='white')
    )

    ax.set_title("Répartition des classes")
    ax.axis('equal')
import os

import cv2
import numpy as np

from settings import params


def get_train_test(base_path: str):
    X = []  # liste pour stocker les images
    y = []  # liste pour stocker les étiquettes correspondantes

    # On parcourt les sous-dossiers du répertoire (un dossier par chiffre)
    for label in sorted(os.listdir(base_path)):

        if not label in ("NORMAL", "PNEUMONIA"):
            continue
        label_path = os.path.join(base_path, label)

        # On parcourt chaque image du dossier
        for file_name in os.listdir(label_path):
            file_path = os.path.join(label_path, file_name)
            if params["rgb"]:                
                img = cv2.imread(file_path, cv2.IMREAD_COLOR_RGB)
            else:
                img = cv2.imread(file_path, cv2.IMREAD_GRAYSCALE)

            if img is None:
                print("Corrupted image")
                continue
            
            X.append(img) # on ajoute l'image à la liste
            y.append(1 if label == "PNEUMONIA" else 0)

    # Conversion des listes en tableaux NumPy
    X = np.array(X)
    y = np.array(y)
    if not params["rgb"]:
        X = np.repeat(X[..., np.newaxis], 3, -1)
    return X, y
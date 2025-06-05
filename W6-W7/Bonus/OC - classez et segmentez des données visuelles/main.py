from PIL import Image
import numpy as np


# Charger l'image et la convertir en niveaux de gris
img = Image.open("img/ll_cool_j.jpg").convert('L')

# Récupérer et afficher la taille de l'image (en pixels)
w, h = img.size
print("Largeur : {} px, hauteur : {} px".format(w, h))

# Afficher son mode de quantification
print("Format des pixels : {}".format(img.mode))

# Récupérer et afficher la valeur du pixel à une position précise
px_value = img.getpixel((20,100))
print("Valeur du pixel situé en (20,100) : {}".format(px_value))

# Récupérer les valeurs de tous les pixels sous forme d'une matrice
mat = np.array(img)
mat

# Afficher la taille de la matrice de pixels
print("Taille de la matrice de pixels : {}".format(mat.shape))

# Charger l'image et la convertir en niveaux de gris
img = Image.open("img/overexposed_landscape.jpg")

img.show()
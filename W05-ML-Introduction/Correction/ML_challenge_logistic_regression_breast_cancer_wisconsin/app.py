import joblib
import numpy as np

model = joblib.load("models/model_logistic_regression.pkl")
scaler = joblib.load("models/scaler.pkl")

print("Bienvenue dans l'outil de prédiction du diagnostic cellulaire.")

while True:

    texture = float(input("Valeur de la texture de la cellule : "))
    smoothness = float(input("Degré de régularité du contour cellulaire : "))
    concave_points = float(input("Nombre de points de concavité sur le contour cellulaire : "))
    symmetry = float(input("Degré de symétrie du contour cellulaire : "))

    X_input = np.array([[texture, smoothness, concave_points, symmetry]])
    X_scaled = scaler.transform(X_input)

    y_pred = model.predict(X_scaled)
    prediction = "BENIN" if y_pred[0] == 0 else "MALIN"

    print(f"Résultat de la prédiction : {prediction}")

    continuer = input("Souhaitez-vous effectuer une autre prédiction ? (o/n) ").strip().lower()
    if continuer != "o":
        break
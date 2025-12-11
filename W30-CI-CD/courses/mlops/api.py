"""
FastAPI application pour servir le modèle de régression linéaire depuis MLflow
"""

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import mlflow
import mlflow.sklearn
import numpy as np
from typing import List
import logging

# Configuration du logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Initialisation de l'application FastAPI
app = FastAPI(
    title="Linear Regression Model API",
    description="API pour faire des prédictions avec le modèle de régression linéaire stocké dans MLflow",
    version="1.0.0"
)

# Configuration MLflow
# ATTENTION : il faut accéder à un registry distant pour rendre disponible votre modèle
MLFLOW_TRACKING_URI = "http://localhost:5000"
MODEL_NAME = "linear_regression_model"
MODEL_STAGE = "Production"  # Options: None, Staging, Production

# Variable globale pour stocker le modèle
model = None


class PredictionInput(BaseModel):
    """
    Schéma pour les données d'entrée de prédiction
    """
    features: List[List[float]]

    class Config:
        json_schema_extra = {
            "example": {
                "features": [
                    [1.0, 2.0, 3.0, 4.0, 5.0],
                    [0.5, 1.5, 2.5, 3.5, 4.5]
                ]
            }
        }


class PredictionOutput(BaseModel):
    """
    Schéma pour les résultats de prédiction
    """
    predictions: List[float]
    model_name: str
    model_version: str


def load_model_from_mlflow():
    """
    Charge le dernier modèle depuis MLflow
    """
    try:
        mlflow.set_tracking_uri(MLFLOW_TRACKING_URI)
        logger.info(f"Connexion à MLflow: {MLFLOW_TRACKING_URI}")

        # Chargement du dernier modèle enregistré
        model_uri = f"models:/{MODEL_NAME}/{MODEL_STAGE}"
        logger.info(f"Chargement du modèle depuis: {model_uri}")

        loaded_model = mlflow.sklearn.load_model(model_uri)
        logger.info("Modèle chargé avec succès")

        return loaded_model
    except Exception as e:
        logger.error(f"Erreur lors du chargement du modèle: {str(e)}")
        raise


@app.on_event("startup")
async def startup_event():
    """
    Charge le modèle au démarrage de l'application
    """
    global model
    try:
        model = load_model_from_mlflow()
        logger.info("Application démarrée avec succès")
    except Exception as e:
        logger.error(f"Erreur au démarrage: {str(e)}")
        logger.warning("L'application démarre sans modèle chargé. Utilisez /reload pour charger le modèle.")


@app.get("/")
async def root():
    """
    Route racine - Informations sur l'API
    """
    return {
        "message": "Bienvenue sur l'API de prédiction de régression linéaire",
        "status": "active" if model is not None else "no model loaded",
        "endpoints": {
            "/predict": "POST - Faire des prédictions",
            "/health": "GET - Vérifier l'état de l'API",
            "/reload": "POST - Recharger le modèle depuis MLflow",
            "/docs": "GET - Documentation Swagger"
        }
    }


@app.get("/health")
async def health_check():
    """
    Vérification de l'état de l'API et du modèle
    """
    if model is None:
        return {
            "status": "unhealthy",
            "message": "Modèle non chargé",
            "mlflow_uri": MLFLOW_TRACKING_URI
        }

    return {
        "status": "healthy",
        "message": "API et modèle opérationnels",
        "mlflow_uri": MLFLOW_TRACKING_URI,
        "model_name": MODEL_NAME
    }


@app.post("/predict", response_model=PredictionOutput)
async def predict(input_data: PredictionInput):
    """
    Effectue des prédictions avec le modèle chargé

    Args:
        input_data: Données d'entrée contenant les features

    Returns:
        PredictionOutput: Prédictions du modèle
    """
    if model is None:
        raise HTTPException(
            status_code=503,
            detail="Modèle non disponible. Utilisez /reload pour charger le modèle."
        )

    try:
        # Conversion des données en array numpy
        features_array = np.array(input_data.features)

        # Validation de la forme des données
        if features_array.shape[1] != 5:
            raise HTTPException(
                status_code=400,
                detail=f"Le modèle attend 5 features, mais {features_array.shape[1]} ont été fournies"
            )

        # Prédiction
        predictions = model.predict(features_array)

        logger.info(f"Prédictions effectuées pour {len(predictions)} échantillons")

        return PredictionOutput(
            predictions=predictions.tolist(),
            model_name=MODEL_NAME,
            model_version=MODEL_STAGE
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erreur lors de la prédiction: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Erreur lors de la prédiction: {str(e)}")


@app.post("/reload")
async def reload_model():
    """
    Recharge le modèle depuis MLflow
    """
    global model
    try:
        model = load_model_from_mlflow()
        return {
            "status": "success",
            "message": "Modèle rechargé avec succès",
            "model_name": MODEL_NAME
        }
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Erreur lors du rechargement du modèle: {str(e)}"
        )


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)

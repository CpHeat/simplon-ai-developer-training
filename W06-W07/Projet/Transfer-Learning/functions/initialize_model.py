from tensorflow.keras import layers, models
from keras.applications.vgg16 import VGG16
from keras.applications import ResNet50V2
from keras.applications import MobileNetV2
from keras.applications import DenseNet121
from keras.applications import EfficientNetV2B2
from tensorflow.keras.layers import Input
from tensorflow.keras.metrics import Recall, Precision

from settings import params, added_layers, model_name


MODEL_CLASSES = {
    "vgg16": VGG16,
    "resnet50v2": ResNet50V2,
    "mobilenetv2": MobileNetV2,
    "densenet121": DenseNet121,
    "efficientnetv2-b2": EfficientNetV2B2,
}

MODEL_SPECIFIC_PARAMS = {
    "mobilenetv2": {
        "alpha": params["alpha"],
    },
    "efficientnetv2-b2": {
        "include_preprocessing": params["include_preprocessing"],
    }
}

if params["input_tensor"]:
    input_tensor = Input(shape=params["input_tensor"])
else:
    input_tensor = None

COMMON_PARAMS = {
    "include_top": params["include_top"],
    "weights": params["weights"],
    "input_tensor": input_tensor,
    "input_shape": params["input_shape"],
    "pooling": params["pooling"],
    "classes": 1000,
    "classifier_activation": params["classifier_activation"],
    "name": params["model"],
}

def initialize_model():
    model_class = MODEL_CLASSES[params["model"].lower()]
    model_params = {**COMMON_PARAMS, **MODEL_SPECIFIC_PARAMS.get(params["model"], {})}   

    base_model = model_class(**model_params)

    # Ajuster à la strétagie de tuning choisie
    if params["strategy"] == "fine_tuning":
        for layer in base_model.layers:
            layer.trainable = True
    elif params["strategy"] == "partial_fine_tuning":
        base_model.trainable = True
        for layer in base_model.layers[:params["fixed_layers"]]:
            layer.trainable = False
    else:
        for layer in base_model.layers:
            layer.trainable = False

    model = models.Sequential()
    model.add(base_model)

    # Ajouter les couches de sortie
    for added_layer in added_layers:
        add_layer(model, added_layer["type"], added_layer["count"], added_layer["activation"])    

    # Compiler le modèle 
    model.compile(optimizer=params["optimizer"],
                loss=params["loss"],
                metrics=[
                    Recall(class_id=0, name='recall_normal'),
                    Recall(class_id=1, name='recall_pneumonia'),
                    Precision(class_id=0, name='precision_normal'),
                    Precision(class_id=1, name='precision_pneumonia'),
                    'accuracy',
                    'auc',
                    'mean_squared_error'
                ])
    
    return model

def add_layer(model, type, count, activation):
        layer = None
        if type == "flatten":
            model.add(layers.Flatten())
        elif type == "dense":
            model.add(layers.Dense(count, activation=activation))
        elif type == "dropout":
            model.add(layers.Dropout(count))

        return layer
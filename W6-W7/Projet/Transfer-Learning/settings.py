experiment_name = "TestUser Experiments"
params = {
    "rgb": False,
    "include_top": False,
    "input_tensor": None,
    "classifier_activation": "softmax",
    "alpha": 0.35,
    "weights": "imagenet",
    "strategy": "no_tuning",
    "fixed_layers": 100,
    "epochs": 1,
    "batch_size": 100,
    "img_size": 224,
    "input_shape": (224, 224, 3),
    "pooling": "max",
    "equilibrate": True,
    "optimizer": "adamw",
    "loss": "categorical_crossentropy",
    "data_augmentation": True,
    "include_preprocessing": False,
    "model": "mobilenetv2"
}
model_name = "TestModel - MobileNetV2"
testing_cycle = 2

added_layers = [
    {
        "type": "dropout",
        "count": 0.3,
        "activation": None
    },
    {
        "type": "dense",
        "count": 128,
        "activation": "relu"
    },
    {
        "type": "dropout",
        "count": 0.2,
        "activation": None
    },
    {
        "type": "dense",
        "count": 2,
        "activation": "softmax"
    },
]

folders = {
    "train": {
        "input": "data/2/chest_xray/train",
        "output": "data/processed/train"
    },
    "test": {
        "input": "data/2/chest_xray/test",
        "output": "data/processed/test"
    },
    "val": {
        "input": "data/2/chest_xray/val",
        "output": "data/processed/val"
    }
}
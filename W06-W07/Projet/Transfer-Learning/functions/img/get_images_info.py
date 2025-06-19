import os

from PIL import Image
import pandas as pd


def get_image_info(file_path):
    
    try:
        with Image.open(file_path) as img:
            width, height = img.size
            return {
                "filename": file_path,
                "width": width,
                "height": height,
                "aspect_ratio": round(width / height, 2),
                "mode": img.mode,
                "error": False
            }
    except Exception as e:
        return {
            "error": str(e)
        }
    
def get_images_info(folder_path):

    images_info = []

    for label in sorted(os.listdir(folder_path)):

        if not label in ("NORMAL", "PNEUMONIA"):
            continue
        label_path = os.path.join(folder_path, label)

        for file_name in os.listdir(label_path):
            file_path = os.path.join(label_path, file_name)

            info = get_image_info(file_path)
            images_info.append(info)

    df = pd.DataFrame(images_info)
    return df
from PIL import Image, ImageOps
from pathlib import Path

from settings import params


def prepare_data(input_folder:str, output_folder:str):
    
    input_folder = Path(input_folder)
    output_folder = Path(output_folder)
    output_folder.mkdir(parents=True, exist_ok=True)
    
    for file_path in input_folder.rglob("*"):
        if file_path.is_file():
            try:
                with Image.open(file_path) as img:
                    # Convert image to color profile
                    if params["rgb"]:
                        img = img.convert("RGB")
                    else:
                        img = img.convert("L")
                        
                    # Add black borders to square image
                    img = square_image(img)
                    # Resize image
                    img = img.resize((params["img_size"], params["img_size"]), resample=Image.BILINEAR)

                    # Save image
                    rel_path = file_path.relative_to(input_folder)
                    output_path = output_folder / rel_path
                    output_path.parent.mkdir(parents=True, exist_ok=True)
                    output_path = output_path.with_suffix(".jpeg")

                    img.save(output_path)

            except Exception as e:
                print(f"❌ Error processing {file_path.name}: {e}")

def square_image(image:Image):
    width, height = image.size
    size = max(width, height)

    border_w = size - width
    border_h = size - height

    padding = (
        border_w // 2,
        border_h // 2,
        border_w - (border_w // 2),
        border_h - (border_h // 2),
    )

    squared_img = ImageOps.expand(image, padding, fill="black")
    
    return squared_img
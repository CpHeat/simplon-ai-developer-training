from pathlib import Path

from PIL import Image
import matplotlib.pyplot as plt


def show_images(df_extremes, folder_path, ncols=3):
    
    folder = Path(folder_path)
    n = len(df_extremes)
    nrows = (n + ncols - 1) // ncols

    fig, axes = plt.subplots(nrows=nrows, ncols=ncols, figsize=(15, 5 * nrows))
    axes = axes.flatten()

    fig.patch.set_facecolor('#2e2e2e')  # Fond de la figure
    for ax in axes:
        ax.set_facecolor('#2e2e2e')  # Fond du graphique
        ax.tick_params(colors='white')  # Couleur des ticks
        ax.xaxis.label.set_color('white')  # Couleur du label X
        ax.yaxis.label.set_color('white')  # Couleur du label Y
        ax.title.set_color('white')       # Couleur du titre
        for spine in ax.spines.values():  # Couleur des bordures
            spine.set_color('white')

    for idx, row in df_extremes.iterrows():
        img_path = Path(row["filename"])
        with Image.open(img_path) as img:
            axes[idx].imshow(img)
            axes[idx].axis('off')

    # Cacher les cases vides si besoin
    for i in range(len(df_extremes), len(axes)):
        axes[i].axis('off')

    plt.tight_layout()
    plt.show()
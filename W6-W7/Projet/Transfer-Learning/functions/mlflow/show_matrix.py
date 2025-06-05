import os

from matplotlib import pyplot as plt
import matplotlib.image as mpimg


def show_matrix(runs, client):
    
    download_dir = "./tmp_confusions"
    os.makedirs(download_dir, exist_ok=True)

    # Préparer la grille
    n = len(runs)
    cols = 3
    rows = (n + cols - 1) // cols
    fig, axes = plt.subplots(rows, cols, figsize=(5 * cols, 5 * rows))
    axes = axes.flatten()
    
    fig.patch.set_facecolor('#2e2e2e')
    fig.suptitle("Matrices de confusion", fontsize=16, color='white')

    # Affichage des images
    for idx, run in enumerate(runs):
        run_id = run.info.run_id
        run_name = run.data.tags.get("mlflow.runName", run_id)
        artifact_path = "confusion_matrix/confusion_matrix.png"

        try:
            # Télécharger le fichier confusion_matrix.png dans le dossier local
            downloaded_path = client.download_artifacts(run_id, artifact_path, download_dir)
            img = mpimg.imread(downloaded_path)
            axes[idx].imshow(img)
            axes[idx].axis('off')
            axes[idx].set_title(run_name, color='white')
        except Exception as e:
            axes[idx].axis('off')
            axes[idx].set_title(f"{run_name}\n {str(e)}", color='white')

    # Cacher les cases vides
    for i in range(len(runs), len(axes)):
        axes[i].axis('off')

    plt.tight_layout(rect=[0, 0.03, 1, 0.95])
    plt.show()
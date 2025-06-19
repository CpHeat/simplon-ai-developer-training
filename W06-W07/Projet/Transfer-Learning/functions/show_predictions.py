def show_predictions(X, y_pred, y_true=None, class_names=None, n_images=15):
    import matplotlib.pyplot as plt
    import numpy as np
    import math

    n_images = min(n_images, len(X), 15)
    n_cols = 5
    n_rows = math.ceil(n_images / n_cols)

    fig, axes = plt.subplots(n_rows, n_cols, figsize=(4 * n_cols, 4 * n_rows))
    axes = axes.flatten()

    for i in range(n_images):
        ax = axes[i]
        img = X[i]

        pred_class_idx = np.argmax(y_pred[i])
        pred_class_name = class_names[pred_class_idx] if class_names else str(pred_class_idx)
        pred_prob = y_pred[i][pred_class_idx]

        if y_true is not None:
            true_class_idx = np.argmax(y_true[i])
            true_class_name = class_names[true_class_idx] if class_names else str(true_class_idx)
        else:
            true_class_name = None

        ax.imshow(img.astype('uint8'))
        ax.axis('off')

        title = f"Prédit: {pred_class_name} ({pred_prob:.2f})"
        if true_class_name is not None:
            title += f"\nVrai: {true_class_name}"
        ax.set_title(title, fontsize=10)

    # Désactive les axes inutilisés s'il y a moins que n_rows*n_cols images
    for j in range(n_images, n_rows * n_cols):
        axes[j].axis('off')

    plt.tight_layout()
    plt.show()

from matplotlib import pyplot as plt
import matplotlib


def show_metrics(runs, client):

    fig, axes = plt.subplots(2, 3, figsize=(18, 10))
    fig.suptitle("Etude comparative des modèles potentiels", fontsize=20, color='white')

    fig.patch.set_facecolor('#2e2e2e')
    for ax_row in axes:
        for ax in ax_row:
            ax.set_facecolor('#2e2e2e')  # Fond du graphique
            ax.tick_params(colors='white')  # Couleur des ticks
            ax.xaxis.label.set_color('white')  # Couleur du label X
            ax.yaxis.label.set_color('white')  # Couleur du label Y
            ax.title.set_color('white')       # Couleur du titre
            for spine in ax.spines.values():  # Couleur des bordures
                spine.set_color('white')

    recall_final = {}
    precision_final = {}
    auc_final = {}

    # Comparons leur évolution au cours de l'entraînement
    for run in runs:
        run_name = run.data.tags.get("mlflow.runName", run.info.run_id)

        val_recall_pneumonia_history = client.get_metric_history(run.info.run_id, "training val_recall_pneumonia")
        if val_recall_pneumonia_history:
            steps = [point.step + 1 for point in val_recall_pneumonia_history]
            values = [point.value for point in val_recall_pneumonia_history]
            axes[0, 0].plot(steps, values, label=run_name)

        val_precision_pneumonia_history = client.get_metric_history(run.info.run_id, "training val_precision_pneumonia")
        if val_precision_pneumonia_history:
            steps = [point.step + 1 for point in val_precision_pneumonia_history]
            values = [point.value for point in val_precision_pneumonia_history]
            axes[0, 1].plot(steps, values, label=run_name)

        val_auc_history = client.get_metric_history(run.info.run_id, "training val_auc")
        if val_precision_pneumonia_history:
            steps = [point.step + 1 for point in val_auc_history]
            values = [point.value for point in val_auc_history]
            axes[0, 2].plot(steps, values, label=run_name)

        recall_final[run_name] = run.data.metrics.get("recall_pneumonia", 0)
        precision_final[run_name] = run.data.metrics.get("precision_pneumonia", 0)
        auc_final[run_name] = run.data.metrics.get("auc", 0)

    metrics_names = ["Recall Pneumonia", "Precision Pneumonia", "AUC"]
    for i, ax in enumerate(axes[0]):
        ax.set_title(f"{metrics_names[i]} (évolution)")
        ax.set_xlabel("Epoch")
        ax.set_ylabel(metrics_names[i])
        ax.grid(True, color='black')
    axes[0, 2].legend()   

    plot_bars(axes[1, 0], recall_final, "Recall Pneumonia (final)", "Recall")
    plot_bars(axes[1, 1], precision_final, "Precision Pneumonia (final)", "Precision")
    plot_bars(axes[1, 2], auc_final, "AUC (final)", "AUC")

    plt.tight_layout(rect=[0, 0.03, 1, 0.95])
    plt.show()

def plot_bars(ax, data, title, xlabel):
    names = list(data.keys())
    values = list(data.values())

    cmap = matplotlib.colormaps.get_cmap('tab20')
    colors = [cmap(i) for i in range(len(names))]

    bars = ax.barh(names, values, color=colors)
    ax.set_title(title)
    ax.set_xlabel(xlabel)
    #ax.grid(False)

    for bar in bars:
        width = bar.get_width()
        y = bar.get_y() + bar.get_height() / 2
        ax.text(width - 0.02 * max(values), y, f'{width:.2f}', va='center', ha='right', fontsize=11, color='white')
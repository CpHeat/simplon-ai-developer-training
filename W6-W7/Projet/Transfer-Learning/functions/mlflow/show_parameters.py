import matplotlib.pyplot as plt
import pandas as pd
import math

def show_parameters(runs):

    # Spécifie ici les paramètres que tu veux masquer
    params_a_exclure = [
        "dataset_url",
        "alpha",
        "classifier_activation",
        "include_preprocessing",
        "include_top",
        "input_shape",
        "model",
        "weights"
    ]

    # Récupération des paramètres
    param_dict = {}
    param_names = set()

    for run in runs:
        run_name = run.data.tags.get("mlflow.runName", run.info.run_id)
        run_params = {k: v for k, v in run.data.params.items() if k not in params_a_exclure}
        param_dict[run_name] = run_params
        param_names.update(run_params.keys())

    # Créer le DataFrame principal
    df_full = pd.DataFrame(index=sorted(param_names), columns=sorted(param_dict.keys()))
    for run_name, params in param_dict.items():
        for param, value in params.items():
            df_full.loc[param, run_name] = value

    # Découper les colonnes en groupes de 3
    columns = df_full.columns.tolist()
    group_size = 3
    num_groups = math.ceil(len(columns) / group_size)

    for i in range(num_groups):
        group_cols = columns[i * group_size:(i + 1) * group_size]
        df_group = df_full[group_cols]

        fig_width = max(12, len(df_group.columns) * 4)  # Largeur augmentée pour plus d'espace
        fig_height = max(4, len(df_group.index) * 0.6)

        fig, ax = plt.subplots(figsize=(fig_width, fig_height))
        ax.axis('tight')
        ax.axis('off')

        table = ax.table(
            cellText=df_group.values,
            rowLabels=df_group.index,
            colLabels=df_group.columns,
            loc='center',
            cellLoc='center'
        )

        table.auto_set_font_size(False)
        table.set_fontsize(10)
        table.scale(1.2, 1.2)

        plt.title(f"Hyperparamètres des runs ({i * group_size + 1} à {min((i + 1) * group_size, len(columns))})", fontsize=16, pad=20)
        plt.show()
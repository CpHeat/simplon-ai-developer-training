import re
import mlflow


def get_run_name(experiment, model_name):
    
    experiment_id = experiment.experiment_id

    client = mlflow.tracking.MlflowClient()
    runs = client.search_runs(experiment_ids=[experiment_id])

    pattern = re.compile(rf"^{model_name}#(\d+)$")
    max_run_number = 0

    for run in runs:
        run_name = run.data.tags.get("mlflow.runName", "")
        match = pattern.match(run_name)
        if match:
            run_number = int(match.group(1))
            if run_number > max_run_number:
                max_run_number = run_number

    new_run_number = max_run_number + 1
    run_name = f"{model_name }#{new_run_number}"
    return run_name
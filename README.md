# Learn Effective MLOps: Model Development

My notes and materials while learning [Effective MLOps: Model Development](https://github.com/wandb/edu/tree/main/mlops-001).

## What the course offers?

* Best practice machine learning workflows
* Exploratory data analysis with Tables and Reports in W&B
* Versioning datasets and models with Artifacts and Model Registry in W&B
* Tracking and analyzing experiments
* Automating hyperparameter optimization with Sweeps
* Model evaluation techniques that ensure reproducibility and enterprise-level governance

## Assignments

1. [Baseline Report](https://wandb.ai/hasibzunair/mlops-course-001/reports/Baseline-Report--Vmlldzo0MDI1NDI1)
2. [Sweep Analysis](https://api.wandb.ai/links/hasibzunair/k4cz7i4d)


## Course notes

**[June 30, 2023]** Lesson 3. 

Data partitioning: Train, val, test

Partition drawn from same distribution. Val/test should be like production.

No leakage between partitions.

Group partition: 

camera 1 images -> train
camera 2, 3 images -> val
camera 4 -> test

Related data points should **not** cross the partition boundary. Otherwise it will be cheating 
as the model has seen the data before.

Data partitioning, choose evaluation metric, error case analysis, documentation.

**[June 30, 2023]** Lesson 2.

Hyperparam opt and collaborative model training: organize code for exps, conduct exps, analyze, share results.

Run 04_refactor_baseline.ipynb

Run `python train.py --batch_size 16`.

Run sweeps by `wandb sweep sweep.yaml` and `wandb agent hasibzunair/mlops-course-001/q6qjanng --count50`.

From sweep, best results:
`python train.py --arch=resnet18 --batch_size=4 --img_size=320 --log_preds=True --lr=0.00023256420282452968 --epochs 20`

**[April 10, 2023]** Lesson 1.

W&B Tables: Visualize data + model preds, quickly spot check rows from dataset

W&B Artifacts: Version datasets as well as models, save every step of pipeline, model tracking.

W&B Experiments: Record for model training, visualize and compare experiment, find re-run previous model checkpoints, moniotor compute, debug performance in real time.

Create reports and summarize findings.

**[April 3, 2023]** Lesson 1.

Workflow: Understand business context, frame the data science problem, explore and understand data, establish baseline metrics and models, communicate results

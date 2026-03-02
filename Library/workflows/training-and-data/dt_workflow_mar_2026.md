# Executive Summary
This document describes the data and training reference workflow. It describes the process of producing vetted model artifacts from raw data and third-party models through data validation, transformation, model training and model evaluation. 

The workflow is structured into two primary functional areas: **Data Engineering** and **Data Science**, both of which feed into a centralized **Observability & Attestations** layer.

The data lifecycle begins with the collection of data from different sources:
- **Data Ingestion**: Aggregates data from 3rd Party and Internal Sources into a **Raw Datasets** repository.
- **Data Validation**: A multi-step verification process that checks for **Data Quality & Bias**, **Compliance**, **Provenance**, and **Usage Requirements** that produces **Vetted Data**.
- **Data Transformation**: Converts validated data into **Processed Data** and **Features** (Feature Store) through a pipeline of cleaning, normalization, and labeling.

The model lifecycle focuses on the ingestion, training, and benchmarking of AI models:
- **Model Ingestion**: Imports external or 3rd party models into an **Unvetted Models** repository.
- **Model Training**: An iterative loop using features from the Data Platform and/or pre-trained models. It includes **Hyperparameter Selection**, **Training**, and **Metrics Validation**.
- **Model Evaluation**: Before graduation to a **Vetted Model**, candidates are tested against **Safety**, **Fairness**, and **Performance Benchmarks**.

Lastly, there is a transversal layer that captures logs, metrics, and attestations from every major process (Ingestion, Transformation, Training, and Evaluation). This ensures a full audit trail and lineage for both data and model artifacts.

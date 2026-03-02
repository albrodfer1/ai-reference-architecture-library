# Executive Summary
This reference architecture defines a modular, governed, and extensible data and training platform designed for enterprise environments. It provides a structural approach for ingesting data from different sources, vetting datasets, ingesting third-party models, vetting and evaluating them, and producing propietary AI models while enforcing a zero-trust security model that ensures safety, compliance, model traceability and observability.

The architecture is organized into two main sub-systems (Training and Data Platform) and one Observability and Lineage system:

- **Data Platform**: The part of the platform responsible to perform all the data related operations, it's managed by Data Engineers. This system is organized into different layers:
  - **Data Platform Orchestrator**: The layer the Data Engineers interact with for running diverse workflows, including *data ingestion*, *data vetting* and *data transformations*.
  - **Data Catalog Layer**: The layer in charge of data discovery. It's also used by Data Engineers to browse available datasets and consult its metadata.
  - **Data Presentation Layer**: The layer in charge of visualizing the data in the data management zone.
  - **Data Landing Layer**: A quarantined zone in which raw data is ingested, it contains untransformed datasets that are to be validated. Datasets in this layer can be federated or virtual, meaning that they are just a pointer to an external source of data.
  - **Data Management Layer**: A data storage layer in which datasets are approved to be used in the data domain. As well as in the previous layer, datasets can be federated or containing actual data.
  - **Data Processing Layer**: This layer contains all the compute resources for vetting and transforming data, as well as the code used by these processes.
- **Training Platform**: The part of the platform responsible to perform all the data science related operations, it's managed by Data Scientists and contains the following layers:
- **Training Platform Orchestrator**: The layer the Data Scientist interact with for running diverse workflows, including *model ingestion*, *model vetting* and *model training*.
  - **Model Registry Layer**: The layer that contains the model artifacts as well as their metadata and training hyperparameters. It contains at least two model repositories, one with unvetted models and another with vetted ones.
  - **Model Compute & Inference Layer**: The layer that serves both, model training and experimentation and model benchmark evaluation and vetting.
- **Observability and Lineage**: This sub-system is in charge of collecting all the logs, traces and metrics generated during data and training operations. In addition to that it stores all the processes attestation that ensures the lineage of the model artifacts and datasets to their original sources.

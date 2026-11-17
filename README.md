# Transparency-Aware Optimization of LLM-Driven Conversational Agents using Semantic and Graph-based RAG

> **Master's Thesis Codebase** | Osnabrück University & University of Bremen (virtUOS / Digital Media Lab)

This repository hosts the complete data pipelines, backend architectures, and statistical evaluations for an empirical study on Large Language Model (LLM) conversational agents. The research investigates how underlying retrieval mechanisms—specifically traditional **Semantic Retrieval-Augmented Generation (RAG)** versus **Knowledge Graph-based RAG (GraphRAG)**—impact the explainability and trustworthiness of these systems within a domain-specific academic context.

## 🔬 Research Scope & Methodology

To comprehensively evaluate the chatbots, this project employs a hybrid evaluation methodology:

* **Human-in-the-Loop Evaluation:** A controlled user study conducted via a custom Streamlit web application (*UniCompanion*) to capture subjective ratings on system explainability and user trust.

* **Automated LLM-as-a-Judge:** Leveraging frameworks like DeepEval alongside lexical metrics (BERTScore) to establish baseline RAG performance across standard benchmarks RAGBench (HotpotQA split) and custom academic datasets.

* **Statistical analyses:** Rigorous hypothesis testing, including Repeated Measures ANOVA, Aligned Rank Transform, and Spearman correlations, to assess evaluator bias and the interplay between transparency and trust.

## 📂 Codebase Architecture

The repository is modularized chronologically to reflect the pipeline of the experiment. Below is an overview of the main folders

```text
.
├── data
│   ├── pilot_study_data
│   ├── rag_corpora
│   └── user_study_exports
├── rag_pipelines
│   ├── semantic_rag_benchmark_data
│   ├── semantic_rag_academic_data
│   ├── graph_rag_benchmark_data
│   └── graph_rag_academic_data
├── streamlit_app
├── statistical_analysis
│   ├── rq1_automated_evaluations
│   ├── rq2_human_vs_llm_judge
│   └── rq3_trust_analysis
│       └── demographics_analysis
└── results
    ├── automated_evaluation
    └── human_evaluation
```


### 1. `data` : Core Datasets & Ground Truth

Stores the foundational data used throughout the study.

* `pilot_study_data/`: Exports and link documentation from initial pilot testing.

* `rag_corpora/`: Contains `academic_corpus_chunks_sample.json`, a structural 10-chunk sample demonstrating the proprietary Osnabrück University dataset schema, Human-crafted DeepEval Q&A benchmarks (e.g., `human_crafted_qa_ground_truth.json`).
  - **`01_rag_corpora/`**: Contains evaluation data split into two subdirectories:
  - **`01_benchmark_eval_data/`**: Includes the sampled HotpotQA benchmark datasets (`ragbench_hotpotqa_50_sampled.csv` and `ragbench_hotpotqa_50_sampled.jsonl`).
  - **`02_academic_eval_data/`**: Contains `academic_corpus_chunks_sample.json` (a structural 10-chunk sample demonstrating the proprietary Osnabrück University dataset schema), human-crafted DeepEval Q&A benchmarks (`human_crafted_qa_ground_truth.json`), and a `DATA_RESTRICTION_NOTICE.md` file.

* `user_study_exports/`: Contains the encrypted `ExperimentData.zip` securing the raw human-subject study data.

### 2. `rag_pipelines` : Backend Implementations

Contains the ingestion, chunking, and retrieval scripts for both tested architectures.

* `01_semantic_rag_benchmark/` & `02_semantic_rag_academic_data/`: Traditional vector-based RAG pipelines.

* `03_graph_rag_benchmark/` & `04_graph_rag_academic_data/`: Graph database architectures utilizing Neo4j, Memgraph, and Cypher query integrations.

### 3. `streamlit_app` : Frontend Evaluation

Contains the codebase for the **UniCompanion** interactive web application used to deploy the models and facilitate the human user study.

### 4. `statistical_analysis` : Analytical Scripts

A collection of R and Python scripts for data cleaning, processing, and visualization.

* `demographics_analysis/`: Computes participant age and gender distributions.

* `rq1_automated_evaluations/`: Executes automated metric computations.

* `rq2_human_vs_llm_judge/`: Analyzes evaluator bias alignments between human scores and LLM judges.

* `rq3_trust_analysis/`: Executes hypothesis testing for trust and explainability dimensions.

### 5. `results` : Computed Outputs

Stores all final generated artifacts, including tables, dumbbell plots, radar charts, and statistical summaries produced by the analysis scripts, separated into `automated_evaluation/` and `human_evaluation/`.

## 🚀 Reproducibility & Setup Guide

### 1. Data Access & GDPR Decryption

Due to data privacy regulations regarding human-subject research, the raw demographic and human evaluation data is secured in `01_data/03_user_study_exports/ExperimentData.zip`.

* **For Reviewers:** You must extract this archive using the password provided via email and ensure the unencrypted CSV is placed back into this directory before running any statistical scripts.

### 2. Backend Execution

Navigate to the `02_rag_pipelines/` directory to review or execute the ingestion and retrieval code for both the semantic and graph-based approaches. Ensure your local environment supports the necessary Graph Database instances (Neo4j/Memgraph).

### 3. Running the Analysis

Navigate to `04_statistical_analysis/` to review the data cleaning and evaluation logic. Scripts are numbered and should be executed sequentially (starting with demographics, proceeding to RQ1, RQ2, and concluding with RQ3) to successfully generate the figures found in `05_results/`.

## 📬 Contact

If you have questions regarding this research, the methodology, or the repository structure, please feel free to open an issue or reach out directly at mamini@uni-osnabrueck.de.

Thank you for your interest in this research!

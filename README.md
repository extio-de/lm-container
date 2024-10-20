# lm-container

**Program Name:** Custom ROCm and PyTorch Docker Image

**Purpose:** The program builds a custom Docker image for running PyTorch on an AMD GPU using ROCm (Radeon Open Compute). The image is designed to support high-performance deep learning workloads, specifically with the LLaMA transformer model.

**Key Features:**

* Installs necessary packages and sets environment variables for ROCm and PyTorch
* Clones and builds the PyTorch backend for ROCm (bitsandbytes) and installs it as a package
* Installs additional packages for transformer models (trl, peft, transformers, datasets, and huggingface-hub)
* Clones and builds the LLaMA transformer model (llama.cpp) with ROCm support
* Copies and makes executable two scripts: convert_to_gguf.sh and setup.sh

**Functionality:** The Docker image can be used to run PyTorch workloads on an AMD GPU, leveraging the performance of ROCm. The setup.sh script, which is run when the container is started, sets up the environment and prepares the image for use.

*["requests":2,"requestDuration":"PT6.158772608S","inTokens":733,"outTokens":376,"tps":62.666666666666664]*

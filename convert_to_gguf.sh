#!/bin/bash

if [[ $# -ne 2 ]] ; then
    echo 'Arguments: <path> <model name>'
    exit 1
fi

cd /workspace/llama.cpp
./convert_hf_to_gguf.py --model-name $2 $1
./llama-quantize $1/*-F16.gguf Q8_0
./llama-quantize $1/*-F16.gguf Q6_K
./llama-quantize $1/*-F16.gguf Q5_K_M
./llama-quantize $1/*-F16.gguf Q4_K_M
./llama-quantize $1/*-F16.gguf Q4_0_4_4
./llama-quantize $1/*-F16.gguf IQ3_M

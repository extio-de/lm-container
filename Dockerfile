FROM rocm/pytorch:rocm6.2.3_ubuntu22.04_py3.10_pytorch_release_2.3.0 AS base-builder

ENV DISTFILES_TAG=v1
ENV GPU_ARCHS="gfx1100"
ENV ROCM_TARGET="gfx1100"
ENV HIP_PLATFORM=amd
ENV DS_BUILD_CPU_ADAM=1 
ENV TORCH_HIP_ARCH_LIST="gfx1100"

RUN apt-get update
RUN apt-get install -y wget git build-essential ninja-build git-lfs libaio-dev cmake
RUN git lfs install
RUN apt-get install -y --allow-change-held-packages vim curl nano rsync s3fs
RUN apt-get install -y libjpeg-dev python3-dev python3-pip

WORKDIR /workspace
#RUN git clone --recurse https://github.com/ROCm/bitsandbytes.git
RUN git clone --depth 1 -b multi-backend-refactor https://github.com/bitsandbytes-foundation/bitsandbytes.git
WORKDIR /workspace/bitsandbytes
#RUN git checkout rocm_enabled
RUN pip install -r /workspace/bitsandbytes/requirements-dev.txt
RUN cmake -DBNB_ROCM_ARCH="gfx1100" -DCOMPUTE_BACKEND=hip -S .
RUN make
RUN git tag 0.44.2
RUN pip install .

WORKDIR /workspace
RUN pip install trl
RUN pip install peft
RUN pip install transformers datasets huggingface-hub scipy

RUN git clone https://github.com/ggerganov/llama.cpp.git
WORKDIR /workspace/llama.cpp
RUN make -j32 GGML_HIPBLAS=1 AMDGPU_TARGETS=gfx1100
RUN pip install -r requirements/requirements-convert_legacy_llama.txt

WORKDIR /workspace
COPY convert_to_gguf.sh /workspace/convert_to_gguf.sh
RUN chmod +x /workspace/convert_to_gguf.sh
COPY setup.sh /workspace/setup.sh
RUN chmod +x /workspace/setup.sh

ENTRYPOINT ["/workspace/setup.sh"]

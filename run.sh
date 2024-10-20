#!/bin/bash

docker run --device=/dev/kfd --device=/dev/dri --privileged --security-opt seccomp=unconfined --group-add video --shm-size 20g --rm -it --name axolotl --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 --mount type=bind,src="/home/sb/lm/",target=/workspace/data --mount type=bind,src="/home/sb/svn/lm-finetuner/",target=/workspace/lm-finetuner pytorch-rocm-exo:v1

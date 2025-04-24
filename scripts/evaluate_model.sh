#!/bin/bash
set -ex

export CUDA_VISIBLE_DEVICES=0,1,2,3
export NCCL_P2P_DISABLE="1"
export NCCL_IB_DISABLE="1"
export TOKENIZERS_PARALLELISM=false
MODEL_PATH="/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct"
TASK_NAMES=("gsm8k" "math" "math_hard" "math_500" "aime24" "amc23")
for TASK_NAME in "${TASK_NAMES[@]}"; do
    echo "Evaluating ${TASK_NAME}..."
    python evaluate_model.py --model ${MODEL_PATH} --task ${TASK_NAME}
done
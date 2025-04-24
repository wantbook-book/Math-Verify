set -ex
# Start time
start_time=$(date +%s)

MODEL_NAME_OR_PATH=/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct
PROMPT_TYPE="pure"
OUTPUT_DIR=${MODEL_NAME_OR_PATH}/math_eval_bon_32

NUM_TEST_SAMPLE=-1
DATA_DIR="/pubshare/fwk/code/Math-Verify/data"
SPLIT="test"
# DATA_NAME="gsm8k,math_500,math_hard,amc23,aime24"
DATA_NAME="math_500"

# export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
export CUDA_VISIBLE_DEVICES=0,1,2,3
TOKENIZERS_PARALLELISM=false \
python3 -u vllm_gen_outputs.py \
    --model_name_or_path ${MODEL_NAME_OR_PATH} \
    --data_name ${DATA_NAME} \
    --output_dir ${OUTPUT_DIR} \
    --split ${SPLIT} \
    --prompt_type ${PROMPT_TYPE} \
    --num_test_sample ${NUM_TEST_SAMPLE} \
    --seed 0 \
    --temperature 1 \
    --n_sampling 32 \
    --top_p 0.95 \
    --start 0 \
    --end -1 \
    --use_vllm \
    --save_outputs \
    --overwrite \
    --data_dir ${DATA_DIR} \

# End time
end_time=$(date +%s)

# Calculate and print the execution time
execution_time=$((end_time - start_time))
echo "Execution time: $execution_time seconds"
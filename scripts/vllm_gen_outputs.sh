set -ex

# MODEL_NAME_OR_PATH=/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct
# MODEL_NAME_OR_PATH=/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3-3b-500seed_gen7500_filtered_32maj8_random_bon_maj_bs16/global_step100_hf
# MODEL_NAME_OR_PATH=/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3-3b-math7_5k_random_gt_bs16
MODEL_NAME_OR_PATH="/pubshare/fwk/orlhf_checkpoints/checkpoint/0420_llama3-3b-math_7_5k_random_bon_maj_bs16/global_step400_hf"
PROMPT_TYPE="pure"
OUTPUT_DIR=${MODEL_NAME_OR_PATH}/math_eval

SPLIT="test"
NUM_TEST_SAMPLE=-1

# export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
export CUDA_VISIBLE_DEVICES=0,1,2,3
DATA_NAME="gsm8k,math_500,math_hard,amc23,aime24"
# DATA_NAME="math_500"
TOKENIZERS_PARALLELISM=false \
python3 -u vllm_gen_outputs.py \
    --model_name_or_path ${MODEL_NAME_OR_PATH} \
    --data_name ${DATA_NAME} \
    --output_dir ${OUTPUT_DIR} \
    --split ${SPLIT} \
    --prompt_type ${PROMPT_TYPE} \
    --num_test_sample ${NUM_TEST_SAMPLE} \
    --seed 0 \
    --temperature 0 \
    --n_sampling 1 \
    --top_p 1 \
    --start 0 \
    --end -1 \
    --use_vllm \
    --save_outputs \
    --overwrite \


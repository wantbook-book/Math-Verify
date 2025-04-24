set -ex
# Start time
# 7500 8a6000 start_time=1745456688s
start_time=$(date +%s)

MODEL_NAME_OR_PATH=/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct
# MODEL_NAME_OR_PATH=/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3-3b-500seed_gen7500_filtered_32maj8_random_bon_maj_bs16/global_step100_hf
# MODEL_NAME_OR_PATH=/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3-3b-math7_5k_random_gt_bs16
# MODEL_NAME_OR_PATH="/pubshare/fwk/orlhf_checkpoints/checkpoint/0420_llama3-3b-math_7_5k_random_bon_maj_bs16/global_step400_hf"
# INPUT_FILE="/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1_maj_eval_with_answer_codes.jsonl"
# INPUT_FILE="/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/test/test_bon_maj_eval_with_rule_rewards.jsonl"
# INPUT_FILE="/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math_500/test_pure_-1_seed0_t1.0_s0_e-1_maj_eval.jsonl"
INPUT_FILE="/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/0208_500seed_gen7500_pure_-1_seed0_t1.0_s0_e-1_maj_eval.jsonl"
# OUTPUT_FILE="/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1_maj_eval_with_answer_codes_self_rewarding.jsonl"
# OUTPUT_FILE="/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/test/test_bon_maj_eval_with_rule_rewards_with_self_rewards.jsonl"
# OUTPUT_FILE="/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math_500/test_pure_-1_seed0_t1.0_s0_e-1_maj_eval_with_self_rewards.jsonl"
OUTPUT_FILE="/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/0208_500seed_gen7500_pure_-1_seed0_t1.0_s0_e-1_maj_eval_with_self_rewards.jsonl"
N_SAMPLING=3
N_SAMPLING_PER_PROMPT=4
# 
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
# export CUDA_VISIBLE_DEVICES=0,1,2,3


# temperature 0.7, top_p 0.9
TOKENIZERS_PARALLELISM=false \
python3 -u 0423_gen_self_rewarding_resp_and_reward.py \
    --model_name_or_path ${MODEL_NAME_OR_PATH} \
    --input_file ${INPUT_FILE} \
    --output_file ${OUTPUT_FILE} \
    --seed 0 \
    --start 0 \
    --end -1 \
    --temperature 1 \
    --reward_n_sampling ${N_SAMPLING} \
    --n_sampling_per_prompt ${N_SAMPLING_PER_PROMPT} \
    --top_p 0.95 \
    --max_tokens_per_call 1024 \
    --use_vllm \
    --self_reward_prompt_file /pubshare/fwk/code/Math-Verify/prompts/self_rewarding.txt

# End time
end_time=$(date +%s)

# Calculate and print the execution time
execution_time=$((end_time - start_time))
echo "Execution time: $execution_time seconds"
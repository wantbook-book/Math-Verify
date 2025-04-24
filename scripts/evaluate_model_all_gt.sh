set -ex
# Start time
start_time=$(date +%s)
# INPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1.jsonl
# INPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1_maj_eval_with_answer_codes.jsonl
# INPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/test_all_gt.jsonl
# INPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/test/test_bon_maj_eval.jsonl
INPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math_500/test_pure_-1_seed0_t1.0_s0_e-1_maj_eval_with_self_rewards.jsonl
# INPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_test.jsonl
# OUTPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1_maj_eval_with_answer_codes_with_rule_rewards.jsonl
# OUTPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/test_all_gt_rule_rewards.jsonl
# OUTPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/test/test_bon_maj_eval_with_rule_rewards.jsonl
OUTPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math_500/test_pure_-1_seed0_t1.0_s0_e-1_maj_eval_with_self_rewards_with_rule_rewards.jsonl
# OUTPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_test_filtered_0_2_0_8.jsonl
python 0423_evaluate_model_outputs_json_all_gt.py --input_jsonl ${INPUT_JSONL} --output_jsonl ${OUTPUT_JSONL}

# End time
end_time=$(date +%s)

# Calculate and print the execution time
execution_time=$((end_time - start_time))
echo "Execution time: $execution_time seconds"
# Start time
start_time=$(date +%s)

# INPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1.jsonl
# INPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/test/test_bon_maj.jsonl
# INPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1.jsonl
# INPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/0208_500seed_gen7500_pure_-1_seed0_t1.0_s0_e-1.jsonl
INPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math_500/test_pure_-1_seed0_t1.0_s0_e-1.jsonl
# INPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_test.jsonl
# OUTPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1_eval.jsonl
# OUTPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/test/test_bon_maj_eval.jsonl
# OUTPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1_maj_eval.jsonl
# OUTPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/0208_500seed_gen7500_pure_-1_seed0_t1.0_s0_e-1_maj_eval.jsonl
OUTPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math_500/test_pure_-1_seed0_t1.0_s0_e-1_maj_eval.jsonl
# OUTPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_test_filtered_0_2_0_8.jsonl
# 0.2
L_MAJ_C=6
# 0.8
R_MAJ_C=26
# INPUT_CSV=/pubshare/fwk/code/Math-Verify/examples/model_outputs.csv
# OUTPUT_CSV=/pubshare/fwk/code/Math-Verify/examples/model_outputs_output.csv
python 0423_evaluate_model_outputs_json_bon.py --input_jsonl ${INPUT_JSONL} --output_jsonl ${OUTPUT_JSONL} --l_maj_c ${L_MAJ_C} --r_maj_c ${R_MAJ_C}

# End time
end_time=$(date +%s)

# Calculate and print the execution time
execution_time=$((end_time - start_time))
echo "Execution time: $execution_time seconds"
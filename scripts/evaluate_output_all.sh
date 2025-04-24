
# INPUT_JSONL=/pubshare/fwk/code/Qwen2.5-Math/evaluation/outputs/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3_1b_ft_rloo-random_template/math_eval/math/math500_pure_-1_seed0_t0.0_s0_e-1.jsonl
# OUTPUT_JSONL=/pubshare/fwk/code/Qwen2.5-Math/evaluation/outputs/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3_1b_ft_rloo-random_template/math_eval/math/math500_pure_-1_seed0_t0.0_s0_e-1_output.jsonl
# INPUT_CSV=/pubshare/fwk/code/Math-Verify/examples/model_outputs.csv
# OUTPUT_CSV=/pubshare/fwk/code/Math-Verify/examples/model_outputs_output.csv
# python evaluate_model_outputs_json.py --input_jsonl ${INPUT_JSONL} --output_jsonl ${OUTPUT_JSONL}

#!/bin/bash

# 设置根目录，包含多个子目录如 aime24, amc23
ROOT_DIR="/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval"  # 替换为你实际的路径
# ROOT_DIR="/pubshare/fwk/code/Math-Verify/outputs/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3-3b-500seed_gen7500_filtered_32maj8_random_bon_maj_bs16/global_step100_hf/math_eval"
# ROOT_DIR="/pubshare/fwk/code/Math-Verify/outputs/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3-3b-math7_5k_random_gt_bs16/math_eval"
# ROOT_DIR="/pubshare/fwk/code/Math-Verify/outputs/pubshare/fwk/orlhf_checkpoints/checkpoint/0420_llama3-3b-math_7_5k_random_bon_maj_bs16/global_step400_hf/math_eval"
EVAL_SCRIPT="0423_evaluate_model_outputs_json.py"
# SUBDIR=("aime24" "amc23" "gsm8k" "math_500" "math_hard")
SUBDIR=("math_500")
# SUBDIR=("amc23" "gsm8k")
# 遍历子目录
# for SUBDIR in "$ROOT_DIR"/*; do
for SUBDIR in "${SUBDIR[@]}"; do
    # 检查子目录是否存在
    SUBDIR="$ROOT_DIR/$SUBDIR"
    if [ ! -d "$SUBDIR" ]; then
        echo "Skipped $SUBDIR: Directory does not exist."
        continue
    fi
    INPUT_JSONL="$SUBDIR/test_pure_-1_seed0_t0.0_s0_e-1.jsonl"
    if [ -f "$INPUT_JSONL" ]; then
        OUTPUT_JSONL="${INPUT_JSONL%.jsonl}_output.jsonl"
        echo "Evaluating: $INPUT_JSONL"
        python "$EVAL_SCRIPT" --input_jsonl "$INPUT_JSONL" --output_jsonl "$OUTPUT_JSONL" --gold_is_latex
    else
        echo "Skipped $SUBDIR: test.jsonl not found."
    fi
done

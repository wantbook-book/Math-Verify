
INPUT_JSONL=/pubshare/fwk/code/Qwen2.5-Math/evaluation/outputs/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3_1b_ft_rloo-random_template/math_eval/math/math500_pure_-1_seed0_t0.0_s0_e-1.jsonl
OUTPUT_JSONL=/pubshare/fwk/code/Qwen2.5-Math/evaluation/outputs/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3_1b_ft_rloo-random_template/math_eval/math/math500_pure_-1_seed0_t0.0_s0_e-1_output.jsonl
# INPUT_CSV=/pubshare/fwk/code/Math-Verify/examples/model_outputs.csv
# OUTPUT_CSV=/pubshare/fwk/code/Math-Verify/examples/model_outputs_output.csv
python 0423_evaluate_model_outputs_json.py --input_jsonl ${INPUT_JSONL} --output_jsonl ${OUTPUT_JSONL}
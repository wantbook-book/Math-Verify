
INPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/500seed_gen7500_pure_-1_seed0_t1.0_s0_e-1.jsonl
OUTPUT_JSONL=/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/500seed_gen7500_pure_-1_seed0_t1.0_s0_e-1_output.jsonl
# INPUT_CSV=/pubshare/fwk/code/Math-Verify/examples/model_outputs.csv
# OUTPUT_CSV=/pubshare/fwk/code/Math-Verify/examples/model_outputs_output.csv
python evaluate_model_outputs_json_maj.py --input_jsonl ${INPUT_JSONL} --output_jsonl ${OUTPUT_JSONL}
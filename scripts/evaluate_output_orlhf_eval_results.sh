
INPUT_JSONL=/pubshare/fwk/code/MCGEP/train_eval_outputs_dir/0420_llama3-3b-test/2025-04-22_01-54-29/step_1/step_1_qa.jsonl
OUTPUT_JSONL=/pubshare/fwk/code/MCGEP/train_eval_outputs_dir/0420_llama3-3b-test/2025-04-22_01-54-29/step_1/step_1_qa_output.jsonl
# INPUT_CSV=/pubshare/fwk/code/Math-Verify/examples/model_outputs.csv
# OUTPUT_CSV=/pubshare/fwk/code/Math-Verify/examples/model_outputs_output.csv
python evaluate_model_outputs_json_orlhf_eval_results.py --input_jsonl ${INPUT_JSONL} --output_jsonl ${OUTPUT_JSONL}
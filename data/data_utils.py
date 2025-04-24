import re
import json
from collections import defaultdict, Counter
def extract_gsm8k_answer(solution_str):
    solution = re.search("#### (\\-?[0-9\\.\\,]+)", solution_str)
    assert solution is not None
    final_solution = solution.group(0)
    final_solution = final_solution.split('#### ')[1].replace(',', '')
    return final_solution

def preprocess_gsm8k(file_path, output_path):
    """
    Preprocess the GSM8K dataset to extract the final answer from the solution string.
    """
    data = []
    with open(file_path, 'r') as f:
        for line in f:
            entry = json.loads(line)
            # Extract the final answer from the solution string
            entry['answer'] = extract_gsm8k_answer(entry['answer'])
            if "boxed" not in entry['answer']:
                entry['answer'] = "\\boxed{" + entry['answer'] + "}"
            data.append(entry)

    # Save the preprocessed data to a new JSON file
    with open(output_path, 'w') as f:
        for entry in data:
            f.write(json.dumps(entry) + '\n')

def preprocess_amc23(file_path, output_path):
    """
    Preprocess the AMC23 dataset to extract the final answer from the solution string.
    """
    data = []
    with open(file_path, 'r') as f:
        for line in f:
            entry = json.loads(line)
            # Extract the final answer from the solution string
            entry['answer'] = str(entry['answer'])
            if "boxed" not in entry['answer']:
                entry['answer'] = "\\boxed{" + entry['answer'] + "}"
            data.append(entry)

    # Save the preprocessed data to a new JSON file
    with open(output_path, 'w') as f:
        for entry in data:
            f.write(json.dumps(entry) + '\n')

def preprocess_math_500(file_path, output_path):
    """
    Preprocess the Math Hard dataset to extract the final answer from the solution string.
    """
    data = []
    with open(file_path, 'r') as f:
        for line in f:
            entry = json.loads(line)
            # Extract the final answer from the solution string
            if "boxed" not in entry['answer']:
                entry['answer'] = "\\boxed{" + entry['answer'] + "}"
            del entry['solution']

            data.append(entry)

    # Save the preprocessed data to a new JSON file
    with open(output_path, 'w') as f:
        for entry in data:
            f.write(json.dumps(entry) + '\n')


def convert_bon_eval_results_to_filtered_data(file_path, output_path, origin_data_file):
    data_list = []
    idx2data = {}
    with open(origin_data_file, 'r') as f:
        for line in f:
            entry = json.loads(line)
            idx2data[entry['idx']] = entry

    with open(file_path, 'r') as f:
        for line in f:
            entry = json.loads(line)
            # Extract the final answer from the solution string
            data_list.append(idx2data[entry['idx']])

    with open(output_path, 'w') as f:
        for entry in data_list:
            f.write(json.dumps(entry) + '\n')

def append_answer(file_path, output_path, origin_data_file):
    idx2data = {}
    with open(origin_data_file, 'r') as f:
        for line in f:
            entry = json.loads(line)
            idx2data[entry['idx']] = entry

    data = []
    with open(file_path, 'r') as f:
        for line in f:
            entry = json.loads(line)
            # Extract the final answer from the solution string
            entry['answer'] = idx2data[entry['idx']]['answer']
            data.append(entry)

    # Save the preprocessed data to a new JSON file
    with open(output_path, 'w') as f:
        for entry in data:
            f.write(json.dumps(entry) + '\n')

def append_codes(file_path, output_path, origin_data_file):
    idx2data = {}
    with open(origin_data_file, 'r') as f:
        for line in f:
            entry = json.loads(line)
            idx2data[entry['idx']] = entry

    data = []
    with open(file_path, 'r') as f:
        for line in f:
            entry = json.loads(line)
            # Extract the final answer from the solution string
            entry['code'] = idx2data[entry['idx']]['code']
            data.append(entry)

    # Save the preprocessed data to a new JSON file
    with open(output_path, 'w') as f:
        for entry in data:
            f.write(json.dumps(entry) + '\n')

def create_dpo_datset(input_file, reward_key, output_file):
    data_list = []
    with open(input_file, 'r') as f:
        for line in f:
            entry = json.loads(line)
            rewards = entry[reward_key]
            # 找出最大的reward和最小的reward组成pair数据
            min_reward_index = rewards.index(min(rewards))
            max_reward_index = rewards.index(max(rewards))
            data_list.append({
                "idx": entry["idx"],
                "question": entry["problem"],
                "answer": entry["answer"],
                "min_reward": rewards[min_reward_index],
                "max_reward": rewards[max_reward_index],
                "chosen": entry['code'][max_reward_index],
                'rejected': entry['code'][min_reward_index],
            })
            
    # Save the preprocessed data to a new JSON file
    with open(output_file, 'w') as f:
        for entry in data_list:
            f.write(json.dumps(entry) + '\n')

def convert_to_sft_format(input_file, output_file):
    data_list = []
    with open(input_file, 'r') as f:
        for line in f:
            entry = json.loads(line)
            data_list.append({
                "instruction": entry["problem"],
                "input": "",
                "output": entry["solution"],
            })
            
    # Save the preprocessed data to a new JSON file
    with open(output_file, 'w') as f:
        for entry in data_list:
            f.write(json.dumps(entry) + '\n')

def group_pred(preds):
    cnt = Counter(preds)
    majority = cnt.most_common(1)[0][0]
    groups = defaultdict(list)
    for idx, pred in enumerate(preds):
        groups[pred].append(idx)
    return groups, majority

def offline_filter_maj(input_file, output_file, l_maj_c, r_maj_c):
    data_list = []
    with open(input_file, 'r') as f:
        for line in f:
            entry = json.loads(line)
            preds = entry['preds_group_idx']
            groups, maj_group_idx = group_pred(preds)
            if l_maj_c <= len(groups[maj_group_idx]) <= r_maj_c:
                data_list.append(
                    {
                        "idx": entry["idx"],
                        "problem": entry["problem"],
                        "answer": entry["answer"],
                        "solution": entry.get("solution", ""),
                    }
                )

    # Save the preprocessed data to a new JSON file
    with open(output_file, 'w') as f:
        for entry in data_list:
            f.write(json.dumps(entry) + '\n')


if __name__ == "__main__":

    # file_path = 'gsm8k/test_raw.jsonl'
    # # file_path = '/pubshare/fwk/code/Math-Verify/outputs/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3-3b-500seed_gen7500_filtered_32maj8_random_bon_maj_bs16/global_step100_hf/math_eval/gsm8k/test_pure_-1_seed0_t1.0_s0_e-1.jsonl'
    # output_path = 'gsm8k/test.jsonl'
    # # output_path = '/pubshare/fwk/code/Math-Verify/outputs/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3-3b-500seed_gen7500_filtered_32maj8_random_bon_maj_bs16/global_step100_hf/math_eval/gsm8k/test_pure_-1_seed0_t1.0_s0_e-1.jsonl'
    # preprocess_gsm8k(file_path, output_path)

    # file_path = 'amc23/test_raw.jsonl'
    # # file_path = '/pubshare/fwk/code/Math-Verify/outputs/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3-3b-500seed_gen7500_filtered_32maj8_random_bon_maj_bs16/global_step100_hf/math_eval/amc23/test_pure_-1_seed0_t1.0_s0_e-1.jsonl'
    # output_path = 'amc23/test.jsonl'
    # # output_path = '/pubshare/fwk/code/Math-Verify/outputs/pubshare/fwk/orlhf_checkpoints/checkpoint/llama3-3b-500seed_gen7500_filtered_32maj8_random_bon_maj_bs16/global_step100_hf/math_eval/amc23/test_pure_-1_seed0_t1.0_s0_e-1.jsonl'
    # preprocess_amc23(file_path, output_path)

    # file_path = 'aime24/test_raw.jsonl'
    # output_path = 'aime24/test.jsonl'
    # preprocess_amc23(file_path, output_path)

    # file_path = 'math_hard/test_raw.jsonl'
    # output_path = 'math_hard/test.jsonl'
    # preprocess_math_hard(file_path, output_path)

    # file_path = 'math_500/test_raw.jsonl'
    # file_path = "/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1_raw.jsonl"
    # output_path = '/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1.jsonl'
    # preprocess_math_500(file_path, output_path)

    # file_path = '/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_filter_0_2_0_8.jsonl'
    # output_path = '/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_filter_0_2_0_8_data.jsonl'
    # origin_data_file = '/pubshare/fwk/code/MCGEP_back/dataset/math/train_with_idx.jsonl'
    # convert_bon_eval_results_to_filtered_data(
    #     file_path=file_path,
    #     output_path=output_path,
    #     origin_data_file=origin_data_file
    # )

    # file_path = "/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1_maj_eval.jsonl"
    # origin_data_file = '/pubshare/fwk/code/MCGEP_back/dataset/math/train_with_idx.jsonl'
    # output_path = "/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1_maj_eval_with_answer.jsonl"
    # append_answer(
    #     file_path=file_path,
    #     output_path=output_path,
    #     origin_data_file=origin_data_file
    # )

    # file_path = "/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1_maj_eval_with_answer.jsonl"
    # output_path = "/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1_maj_eval_with_answer_codes.jsonl"
    # origin_data_file = "/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/train_with_idx_pure_-1_seed0_t1.0_s0_e-1.jsonl"
    # append_codes(
    #     file_path=file_path,
    #     output_path=output_path,
    #     origin_data_file=origin_data_file
    # )

    # file_path = '/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/test/test_bon_maj_eval_with_rule_rewards_with_self_rewards.jsonl'
    # reward_key = "self_reward_rewards"
    # # reward_key = 'rule_rewards'
    # output_file = f'/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/test/test_{reward_key}_dpo_dataset.jsonl'
    # create_dpo_datset(
    #     input_file=file_path,
    #     reward_key=reward_key,
    #     output_file=output_file
    # )

    # file_path = "/pubshare/fwk/code/MCGEP_back/dataset/math/train_with_idx.jsonl"
    # output_file = "/pubshare/fwk/code/MCGEP_back/dataset/math/train_sft.jsonl"
    # convert_to_sft_format(
    #     input_file=file_path,
    #     output_file=output_file
    # )

    input_file = "/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/0208_500seed_gen7500_pure_-1_seed0_t1.0_s0_e-1_maj_eval.jsonl"
    output_file = "/pubshare/fwk/code/Math-Verify/outputs/home/jovyan/share/LLMAgent/model/Llama-3.2-3B-Instruct/math_eval_bon_32/math/0208_500seed_gen7500_filtered_0208.jsonl"
    l_maj_c = 32*0.2
    r_maj_c = 32*0.8
    offline_filter_maj(
        input_file=input_file,
        output_file=output_file,
        l_maj_c=l_maj_c,
        r_maj_c=r_maj_c
    )
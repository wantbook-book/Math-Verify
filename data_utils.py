from pathlib import Path
import json
def merge_jsonl_files(input_files: list[str], output_file: str) -> None:
    """Merge multiple JSONL files into a single file."""
    data_list = []
    for input_file in input_files:
        with open(input_file, 'r') as f:
            data = f.read()
            data_json = json.loads(data)
            print(len(data_json))
            breakpoint()
            data_list.extend(json.loads(data))
    with open(output_file, 'w') as f:
        for item in data_list:
            f.write(json.dumps(item) + '\n')

if __name__ == '__main__':
    src_dir = Path(__file__).parent
    math_hard_dir = src_dir / 'data/math_hard'
    input_files = [
        math_hard_dir / 'algebra.jsonl',
        math_hard_dir / 'counting_and_probability.jsonl',
        math_hard_dir / 'geometry.jsonl',
        math_hard_dir / 'intermediate_algebra.jsonl',
        math_hard_dir / 'number_theory.jsonl',
        math_hard_dir / 'prealgebra.jsonl',
        math_hard_dir / 'precalculus.jsonl',
    ]
    output_file = math_hard_dir / 'test.jsonl'
    merge_jsonl_files(input_files, output_file)
    print(f"Merged {len(input_files)} files into {output_file}")
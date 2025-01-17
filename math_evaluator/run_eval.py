from datetime import timedelta
from lighteval.logging.evaluation_tracker import EvaluationTracker
from lighteval.models.vllm.vllm_model import VLLMModelConfig
from lighteval.models.transformers.transformers_model import TransformersModelConfig
from lighteval.pipeline import ParallelismManager, Pipeline, PipelineParameters
from lighteval.utils.utils import EnvConfig
from lighteval.utils.imports import is_accelerate_available

if is_accelerate_available():
    from accelerate import Accelerator, InitProcessGroupKwargs
    accelerator = Accelerator(kwargs_handlers=[InitProcessGroupKwargs(timeout=timedelta(seconds=3000))])
else:
    accelerator = None

def main():
    evaluation_tracker = EvaluationTracker(
        output_dir="./results",
        save_details=True,
        push_to_hub=True,
        hub_results_org="your user name",
    )

    pipeline_params = PipelineParameters(
        launcher_type=ParallelismManager.ACCELERATE,
        env_config=EnvConfig(cache_dir="tmp/"),
        # Remove the 2 parameters below once your configuration is tested
        override_batch_size=1,
        max_samples=1,
        custom_tasks_directory="./math_evaluator/tasks.py",
    )

    # model_config = VLLMModelConfig(
    #         pretrained="HuggingFaceH4/zephyr-7b-beta",
    #         dtype="float16",
    #         use_chat_template=True,
    # )
    model_config = TransformersModelConfig(
        pretrained="openai-community/gpt2",
        dtype="float16",
        use_chat_template=True,
    )

    task = "lighteval|math_hard_cot|4|0"

    pipeline = Pipeline(
        tasks=task,
        pipeline_parameters=pipeline_params,
        evaluation_tracker=evaluation_tracker,
        model_config=model_config,
    )

    pipeline.evaluate()
    pipeline.show_results()

if __name__ == "__main__":
    main()
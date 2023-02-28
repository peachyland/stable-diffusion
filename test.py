# from datasets import load_dataset
# ds = load_dataset("lambdalabs/pokemon-blip-captions", split="train")
# sample = ds[0]

# print(sample["text"])

# from huggingface_hub import login

# login("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")

# from huggingface_hub import hf_hub_download
# ckpt_path = hf_hub_download(repo_id="CompVis/stable-diffusion-v-1-4-original", filename="sd-v1-4-full-ema.ckpt", use_auth_token=True, cache_dir='/localscratch/renjie/huggingface/hub')

# print(ckpt_path)

BATCH_SIZE=4
N_GPUS=1
ACCUMULATE_BATCHES=1

gpu_list = ",".join((str(x) for x in range(N_GPUS))) + ","
print(f"Using GPUs: {gpu_list}")
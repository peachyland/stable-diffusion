ckpt_path="/localscratch/renjie/huggingface/hub/models--CompVis--stable-diffusion-v-1-4-original/snapshots/f0bb45b49990512c454cf2c5670b0952ef2f9c71/sd-v1-4-full-ema.ckpt"

python main.py -t --base configs/stable-diffusion/pokemon.yaml --gpus "6," --scale_lr False --num_nodes 1 --check_val_every_n_epoch 10 --finetune_from "$ckpt_path" data.params.batch_size="4" lightning.trainer.accumulate_grad_batches="1" data.params.validation.params.n_gpus="1"

# export HF_DATASETS_CACHE="/egr/research-dselab/renjie3/.cache"

# export HF_DATASETS_CACHE="/localscratch/renjie/huggingface"
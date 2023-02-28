JOB_ID=`cat job_id.log`
echo $JOB_ID
NEXT_JOB_ID=`expr $JOB_ID + 1`
echo $NEXT_JOB_ID > job_id.log

ckpt_path="/localscratch/renjie/huggingface/hub/models--CompVis--stable-diffusion-v-1-4-original/snapshots/f0bb45b49990512c454cf2c5670b0952ef2f9c71/sd-v1-4-full-ema.ckpt"

MY_CMD="python main.py -t --base configs/stable-diffusion/pokemon.yaml --gpus \"6,\" --scale_lr False --num_nodes 1 --check_val_every_n_epoch 10 --finetune_from \"$ckpt_path\" data.params.batch_size=\"4\" lightning.trainer.accumulate_grad_batches=\"1\" data.params.validation.params.n_gpus=\"1\""
MY_ROOT_PATH=`pwd`

echo "cd ${MY_ROOT_PATH}" > ./cmd/cmd_${JOB_ID}.sh
echo "MY_CMD=\"${MY_CMD} --job_id $JOB_ID \"" >> ./cmd/cmd_${JOB_ID}.sh
echo "\${MY_CMD}" >> ./cmd/cmd_${JOB_ID}.sh
echo "\nif [ \$? -eq 0 ];then" >> ./cmd/cmd_${JOB_ID}.sh
echo "echo -e \"grandriver JobID:${JOB_ID} \\\n Python_command: \\\n ${MY_CMD} \\\n \" | mail -s \"[Done] grandriver ${SLURM_JOB_ID}\" renjie2179@outlook.com" >> ./cmd/cmd_${JOB_ID}.sh
echo "else" >> ./cmd/cmd_${JOB_ID}.sh
echo "echo -e \"grandriver JobID:${JOB_ID} \\\n Python_command: \\\n ${MY_CMD} \\\n \" | mail -s \"[Fail] grandriver ${SLURM_JOB_ID}\" renjie2179@outlook.com" >> ./cmd/cmd_${JOB_ID}.sh
echo "fi" >> ./cmd/cmd_${JOB_ID}.sh

nohup sh ./cmd/cmd_${JOB_ID}.sh >./logfile/${JOB_ID}.log 2>./logfile/${JOB_ID}.err &

echo $MY_CMD

date >>./history_job.log
echo ${JOB_ID}>>./history_job.log
echo "GPU_ID=${GPU_ID}">>./history_job.log
echo ${MY_CMD}>>./history_job.log
echo "---------------------------------------------------------------" >>./history_job.log

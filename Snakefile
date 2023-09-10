from snakemake.remote.S3 import RemoteProvider as S3RemoteProvider
S3 = S3RemoteProvider(
    access_key_id=config["key"],
    secret_access_key=config["secret"],
    host=config["host"],
    stay_on_remote=False
)

prefix = config["prefix"]

rule makeMAE:
    input:
        "RADCURE_radiomic_MAE.rds"
    output:
        S3.remote(prefix + "RADCURE_radiomic_MAE.rds")
    shell:
        """
        s3 cp RADCURE_radiomic_MAE.rds s3://{prefix}RADCURE_radiomic_MAE.rds
        """

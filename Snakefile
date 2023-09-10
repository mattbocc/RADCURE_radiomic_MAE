import boto3

# Define your AWS credentials and S3 bucket name
aws_access_key_id = config["key"]
aws_secret_access_key = config["secret"]
s3_bucket_name = "bhklab_orcestra"  # Replace with your S3 bucket name
endpoint_url = config["host"]

# Print AWS credential values for debugging
print(f"AWS Access Key ID: {aws_access_key_id}")
print(f"AWS Secret Access Key: {aws_secret_access_key}")
print(f"Endpoint URL: {endpoint_url}")

# Create an S3 client
s3_client = boto3.client(
    's3',
    aws_access_key_id=aws_access_key_id,
    aws_secret_access_key=aws_secret_access_key,
    endpoint_url=endpoint_url
)

rule makeMAE:
    output:
        "RADCURE_radiomic_MAE.rds"
    run:
        # Upload the file to S3 using boto3
        local_file_path = "RADCURE_radiomic_MAE.rds"
        s3_key = "snakemake/RADCURE_radiomic_MAE/RADCURE_radiomic_MAE.rds"
        with open(local_file_path, "rb") as file:
            s3_client.upload_fileobj(file, s3_bucket_name, s3_key)

# Prerequisites

Before starting with this guide, check the list of prerequisites below, and make sure you have fullfilled them all:

- [ ] You have access to an AWS project
- [ ] You have an account [all set up](#account-setup) in your AWS project
- [ ] You have an S3 storage bucket all set up in your AWS project

# Local Setup

Once you have the prerequisites in place, you can check out this quickstart. This will enable you to deploy self-hosted Github runners from your local development machine:

1. clone the repository (or your fork)
2. `cd` to the repo root
3. install the various modules with `npm ci`
4. copy the GitHub App private key inside the project root, and rename it to `ghapp.pem`
5. create a file called `.env` in the project root and set the contents of the file to:
```sh
export APP_ID=<GitHub App ID>
export APP_PRIVATE_KEY="$(cat ghapp.pem)"
export PULUMI_BACKEND_URL=<path to the S3 bucket in format 's3://bucket_name'>
export PULUMI_CONFIG_PASSPHRASE=<a passphrase that will be used to encrypt secrets>
export AWS_ACCESS_KEY_ID=<your access key id received when account was created>
export AWS_SECRET_ACCESS_KEY=<your secret access key received when account was created>
export AWS_REGION=<AWS region, eg. eu-west-2>
```
6. create a file called `config.yaml` in the project root and set the contents of the file to:
```yaml
config:
  ephemeral-github-runner:bootDiskSizeInGB: "100"
  ephemeral-github-runner:bootDiskType: pd-balanced
  ephemeral-github-runner:labels: <comma-separated list of runner labels>
  ephemeral-github-runner:machineImage: <path to the AWS AMI machine image with Github runner installed>
  ephemeral-github-runner:machineType: <machine type of your choice>
  ephemeral-github-runner:owner: <GitHub org or username under which the repo is>
  ephemeral-github-runner:repo: <GitHub repo name>
  ephemeral-github-runner:runnersCount: "1"
```

# AWS setup

## Account setup
You will either get your account set up by someone else, and they will share the `AWS_ACCESS_KEY_ID` and `AWS_ACCESS_KEY_ID` with you, or if you are creating your own account follow the instructions as written [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console).
# Prerequisites

Before starting with this guide, check the list of prerequisites below, and make sure you have fullfilled them all:

- [ ] You have access to a GCP project
- [ ] You have a service account [all set up](#service-account-permissions) in your GCP project
- [ ] You have a service account key downloaded in `json` format
- [ ] You have a storage bucket all set up in your GCP project

# Local Setup

Once you have the prerequisites in place, you can check out this quickstart. This will enable you to deploy self-hosted Github runners from your local development machine:

1. clone the repository (or your fork)
2. `cd` to the repo root
3. install the various modules with `npm ci`
4. copy the service account key inside the project root, and rename it to `gcp.json`
5. copy the GitHub App private key inside the project root, and rename it to `ghapp.pem`
6. create a file called `.env` in the project root and set the contents of the file to:
```sh
export APP_ID=<GitHub App ID>
export APP_PRIVATE_KEY="$(cat ghapp.pem)"
export GOOGLE_CREDENTIALS="$(cat gcp.json)"
export GOOGLE_PROJECT=<GCP project ID>
export GOOGLE_REGION=<GCP region e.g. 'europe-west4'>
export GOOGLE_ZONE=<GCP zone e.g. 'europe-west4-a'>
export PULUMI_BACKEND_URL=<path to the GCP bucket in format 'gs://bucket_name'>
export PULUMI_CONFIG_PASSPHRASE=<a passphrase that will be used to encrypt secrets>
```
7. create a file called `config.yaml` in the project root and set the contents of the file to:
```yaml
config:
  ephemeral-github-runner:bootDiskSizeInGB: "100"
  ephemeral-github-runner:bootDiskType: pd-balanced
  ephemeral-github-runner:labels: <comma-separated list of runner labels>
  ephemeral-github-runner:machineImage: <path to the GCP machine image with Github runner installed>
  ephemeral-github-runner:machineType: <machine type of your choice>
  ephemeral-github-runner:owner: <GitHub org or username under which the repo is>
  ephemeral-github-runner:repo: <GitHub repo name>
  ephemeral-github-runner:runnersCount: "1"
```

# GCP setup

## Service account permissions

```
compute.disks.create
compute.images.get
compute.images.useReadOnly
compute.instanceGroupManagers.create
compute.instanceGroupManagers.delete
compute.instanceGroupManagers.get
compute.instanceGroups.create
compute.instanceGroups.delete
compute.instanceTemplates.create
compute.instanceTemplates.delete
compute.instanceTemplates.get
compute.instanceTemplates.useReadOnly
compute.instances.create
compute.instances.setLabels
compute.instances.setMetadata
compute.networks.create
compute.networks.delete
compute.networks.get
compute.networks.updatePolicy
compute.subnetworks.create
compute.subnetworks.delete
compute.subnetworks.get
compute.subnetworks.use
compute.subnetworks.useExternalIp
```
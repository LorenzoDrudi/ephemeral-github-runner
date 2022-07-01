# Prerequisites

Before starting with this guide, check the list of prerequisites below, and make sure you have fullfilled them all:

- [ ] You have [installed Pulumi](https://www.pulumi.com/docs/get-started/install/)
- [ ] You have installed [Node.js](https://nodejs.org/)
- [ ] You have access to a GCP project
- [ ] You have a service account [all set up](#service-account-permissions) in your GCP project
- [ ] You have a service account key downloaded in `json` format
- [ ] You have a storage bucket all set up in your GCP project
- [ ] You have a GitHub App [setup](#github-app-setup)
- [ ] You have the GitHub App private key downloaded in `pem` format

# Quickstart

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

# Deploying runners

To deploy runners from your local development machine, notice that there is a `Makefile` in the project root. It acts as a wrapper around several `pulumi` commands for deploying, destroying and loging in with pulumi. To deploy runners, make sure you are in the project root and execute:

```sh
source .env
make up
```
After running this, Pulumi will prompt with `yes` and `no` options, if you wish to confirm the changes. Selecting `yes`, Pulumi will start the deployment.

Assuming you have selected `yes` above, and the deployment is done, once ready to destroy runners, make sure you are in the project root, and execute:
```sh
make down
```

# A bit more complicated example

`Makefile` has several variables defined:

| Variable      | Required    | Default     | Description                                                                   | Possible values |
| ------------- | ----------- | ----------- | ----------------------------------------------------------------------------- | --------------- |
| stack         | no          | dev1        | Name of the Pulumi stack. This is native to Pulumi, imagine it as a namespace |                 |
| config        | no          | config.yaml | Path to the config file in `yaml` format                                      |                 |
| auto-approve  | no          |             | A flag that enables/disables the Pulumi command prompt                        |    [-n / -y]    |

To customise the behaviour of Pulumi, you can the use variables mentioned above. For example, let's deploy Pulumi stack with:
- name: `myFirstStack`
- config: `my-configuration.yaml` (assuming this file exists in your project root)
- auto-approve: `-y`

Your make command to deploy the stack would look like this:
```sh
make up stack=myFirstStack config=my-configuration.yaml auto-approve=-y
```

And your command to destroy the stack would look like this:
```sh
make down stack=myFirstStack config=my-configuration.yaml auto-approve=-y
```

Note: if `auto-approve` is set to `-n`, then you will just tell Pulumi not to do the action you already wanted it to do. If you leave out the `auto-approve` flag, Pulumi will prompt you if you wish you action to take place or not.

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

# GitHub App setup

TODO

## App permissions

```
admin:write
metadata:read
```
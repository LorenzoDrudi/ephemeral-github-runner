# Prerequisites

Before starting with this guide, check the list of prerequisites below, and make sure you have fullfilled them all. The following list is a must. In the Quickstart guid for each individual platform, there will be specific prerequisits needed according to the platform. General prerequisits are:

- [ ] You have [installed Pulumi](https://www.pulumi.com/docs/get-started/install/)
- [ ] You have installed [Node.js](https://nodejs.org/)
- [ ] You have a GitHub App [setup](#github-app-setup)
- [ ] You have the GitHub App private key downloaded in `pem` format
- [ ] You have setup your environment appropriatelly for a platform to which you want to deploy the runners
- [ ] You have read Installation guide for either:
    - [ ] [GCP](./gcp/INSTALLATION_GUIDE.md), or
    - [ ] [AWS](./aws/INSTALLATION_GUIDE.md)

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

# GitHub App setup

TODO

## App permissions

```
admin:write
metadata:read
```
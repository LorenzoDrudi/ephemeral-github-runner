SHELL:=/bin/bash
stack=dev1
config=../config.yaml
auto-approve?=
provider=

up:
	cd ${provider} && \
	pulumi stack init ${stack} && \
	pulumi update --diff --config-file ${config} ${auto-approve}

down:
	cd ${provider} && \
	pulumi stack select ${stack} && \
	pulumi destroy --config-file ${config} ${auto-approve} && \
	pulumi stack rm ${stack} ${auto-approve}
#!/usr/bin/env make
MAKEFLAGS += --silent
SHELL=/bin/bash

ifneq (,$(wildcard ./.env))
    include .env
    export
endif

.PHONY: init plan apply destroy genkey graph

init:
	terraform init
plan:
	terraform plan -out ${PLAN_NAME}
apply:
	terraform apply "${PLAN_NAME}"
destroy:
	terraform destroy
genkey:
	ssh-keygen -t rsa -f ${KEY_FILE} -P ""
	chmod 400 ${KEY_FILE}*
graph:
	terraform graph
# Golang Lambda Makefile
# Davy Jones 2017

all: test

aws_region ?= eu-west-1
s3_bucket ?=
s3_dir ?=
stack_name ?=

build:
	$(call yellow, "# Building Golang Binary...")
	docker run --rm -it -v "${GOPATH}":/gopath -v "$(CURDIR)":/app -e "GOPATH=/gopath" -w /app golang:1.8 sh -c 'GOOS=linux GOARCH=amd64 go build -o main'

test: build
	$(call yellow, "# Testing Function with SAM Local...")
	sam local invoke -e event.json GolangTester
	$(MAKE) clean

generate-event:
	$(call yellow, "# Generating Event for Testing...")
	sam local generate-event sns > event.json

package: build
	$(call yellow, "# Packaging Lambda for Deployment...")
	$(call check_defined, s3_bucket, S3 Bucket Name to Deploy To)
	$(call check_defined, s3_dir, S3 Bucket Directory to Deploy To)
	aws --region ${aws_region} cloudformation package --template-file template.yml --s3-bucket ${s3_bucket} --s3-prefix ${s3_dir} --output-template-file packaged-template.yml
	$(MAKE) clean

deploy: package
	$(call yellow, "# Deploying Lambda Package...")
	$(call check_defined, stack_name, Name of Cloudformation stack)
	aws --region ${aws_region} cloudformation deploy --template-file "$(CURDIR)"/packaged-template.yml --stack-name ${stack_name} --capabilities CAPABILITY_IAM
	$(MAKE) clean

clean: 
		@rm -f ${app} 


define yellow
	@tput setaf 3
	@echo $1
	@tput sgr0
endef

check_defined = \
    $(strip $(foreach 1,$1, \
      $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))
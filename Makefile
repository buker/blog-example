.DEFAULT_GOAL := help
BUCKET_NAME ?= "demo-blog.zulnowski.com"
SITE ?= "demo_blog"
build: ## Build image for development
	docker build -t $(SITE) .

run: ## Run docker with volume mount, Parameters: site, Usage: make run SITE=blog.example.com
	docker run --rm -p 4000:4000 --name $(SITE) -v "${PWD}/$(SITE)":/srv/jekyll $(SITE) serve

new: ## Create new jekyll page. Parameters: site, Usage: make new SITE=blog.example.com
	docker run --rm --name $(SITE) -v "${PWD}":/srv/jekyll $(SITE) new $(SITE)

build-site: ## Build statics files in docker image, Parameters: site, Usage: make build-site SITE=blog.example.com
	docker run --rm -p 4000:4000 --name $(SITE) -v "${PWD}/$(SITE)":/srv/jekyll $(SITE) build

deploy: build-site ## Deploy your static file to s3 bucket, Parameters: site, bucket_name, Usage: make deploy SITE=blog.example.com BUCKET_NAME=example-bucket
	aws s3 sync $(SITE)/_site s3://$(BUCKET_NAME)

help: ## Display this help. Default target
	@echo 'Variables:'
	@echo ' - SITE - name of your website'
	@echo ' - BUCKET_NAME - name of bucket'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

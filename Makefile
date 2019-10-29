

build: ## Build image for development
	docker build -t blog_example .

run: ## Run docker with volume mount
	docker run --rm -p 4000:4000 --name blog_example -v "${PWD}/$(SITE)":/srv/jekyll blog_example serve

new: ## Create new jekyll page 
	docker run --rm --name blog_example -v "${PWD}":/srv/jekyll blog_example new $(SITE)

help: ## Display this help. Default target
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "};

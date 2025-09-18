.PHONY: clean build

default: clean build

clean:
	@rm -rf ./public/
	@rm -f ./public.tar.gz

build: clean
	@mkdir -p ./public/
	@docker build -f Dockerfile --target exporter --output ./public/ .
	@tar zcvf public.tar.gz ./public/

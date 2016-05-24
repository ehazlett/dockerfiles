all: build

build:
	@docker build -t obfs4-build -f Dockerfile.build .
	@docker create --name obfs4-pkg obfs4-build ash
	@docker cp obfs4-pkg:/go/bin/obfs4proxy ./
	@docker rm -fv obfs4-pkg
	@docker build -t ehazlett/obfs4:latest .

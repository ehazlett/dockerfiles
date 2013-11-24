all:
	@cd python && docker build -t ehazlett/python .
	@cd django && docker build -t ehazlett/django .

clean:
	@docker rmi ehazlett/django
	@docker rmi ehazlett/python

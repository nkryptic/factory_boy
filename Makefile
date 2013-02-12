all: default


default:


clean:
	find . -type f -name '*.pyc' -delete


doc:
	$(MAKE) -C docs html


.PHONY: all default clean doc

sinclude buildvars.mk

ImageBuildMakefile: images.json
	puavo-build-image --images-config $< --output-makefile > $@.tmp
	mv $@.tmp $@

include ImageBuildMakefile

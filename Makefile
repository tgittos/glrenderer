# OSTYPE is not set by default on OS X
ifndef OSTYPE
	OSTYPE = $(shell uname -s)
endif

CC = g++
CFLAGS = -Wall -g
# Linux flags
LDFLAGS = -lGL -lGLU -lglut
# Override if we're in OS X
ifeq "$(OSTYPE)" "Darwin"
	LDFLAGS = -framework OpenGL -framework GLUT
endif
# Pass compiler preprocessor variables in
#-DFREEGLUT FREEGLUT # gcc
#/DFREEGLUT FREEGLUT # windows
EXECUTABLES = helloworld helloopengl chapter01
TARGETS = 

.PHONY: all
.DEFAULT: all

all: $(EXECUTABLES)

helloworld:	helloworld.o
	$(CC) $(LDFLAGS) $(CFLAGS) -o bin/$@ build/$<

helloopengl:	helloopengl.o
	$(CC) $(LDFLAGS) $(CFLAGS) -o bin/$@ build/$<

chapter01:	chapter01.o
	$(CC) $(LDFLAGS) $(CFLAGS) -o bin/$@ build/$<

%.cpp:
	mkdir -p build bin
	literati tangle -o build/. src/$@.lit

%.o: %.cpp
	$(CC) $(CFLAGS) -c -o build/$@ build/$<

clean:
	rm -Rf build
	rm -Rf bin
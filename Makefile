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

all: helloworld

helloworld:	build/helloworld.o
	$(CC) $(LDFLAGS) $(CFLAGS) -o bin/helloworld build/helloworld.o

helloopengl: build/helloopengl.o
	$(CC) $(LDFLAGS) $(CFLAGS) -o bin/helloopengl build/helloopengl.o

build/helloworld.cpp:
	mkdir -p build bin
	literati tangle src/helloworld.cpp.lit
	mv output/src/helloworld.cpp build/.

build/helloopengl.cpp:
	mkdir -p build bin
	literati tangle src/helloopengl.cpp.lit
	mv output/src/helloopengl.cpp build/.

build/helloworld.o: build/helloworld.cpp
	$(CC) $(CFLAGS) -c -o build/helloworld.o build/helloworld.cpp

build/helloopengl.o: build/helloopengl.cpp
	$(CC) $(CFLAGS) -c -o build/helloopengl.o build/helloopengl.cpp

clean:
	rm -Rf output
	rm -Rf build
	rm -Rf bin
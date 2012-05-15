# OSTYPE is not set by default on OS X
ifndef OSTYPE
	OSTYPE = $(shell uname -s)
endif

CC = g++
CFLAGS = -Wall -g
# Linux flags
LDFLAGS = -Ilib -lGL -lGLU -lglut -lGLEW
# Override if we're in OS X
ifeq "$(OSTYPE)" "Darwin"
	LDFLAGS = -framework OpenGL -framework GLUT -lGLEW
endif
# Pass compiler preprocessor variables in
#-DFREEGLUT FREEGLUT # gcc
#/DFREEGLUT FREEGLUT # windows
EXECUTABLES = helloworld helloopengl chapter01 chapter02a chapter02b chapter02c chapter03a

.PHONY: all
.DEFAULT: all

all: $(EXECUTABLES)

clean:
	rm -Rf build
	rm -Rf bin

%: %.o
	$(CC) build/$< $(LDFLAGS) $(CFLAGS) -o bin/$@

%.cpp:
	mkdir -p build bin
	literati tangle -o build/. src/$@.lit

%.o: %.cpp
	$(CC) $(CFLAGS) -c -o build/$@ build/$<
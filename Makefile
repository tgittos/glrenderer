# OSTYPE is not set by default on OS X
ifndef OSTYPE
	OSTYPE = $(shell uname -s)
endif

CC = g++
CFLAGS = -Wall -g
# Linux flags
LDFLAGS = -lGL -lGLU -lglut -lGLEW
IFLAGS = -Ilib -Iinclude
# Override if we're in OS X
ifeq "$(OSTYPE)" "Darwin"
	LDFLAGS = -framework OpenGL -framework GLUT -lGLEW
endif
# Pass compiler preprocessor variables in
#-DFREEGLUT FREEGLUT # gcc
#/DFREEGLUT FREEGLUT # windows
EXECUTABLES = helloworld helloopengl chapter01 chapter02a chapter02b chapter02c chapter03a chapter03b chapter04

.PHONY: all
.DEFAULT: all

all: includes $(EXECUTABLES)

clean:
	rm -Rf out
	rm -Rf bin

chapter04: utils.o chapter04.o
	$(CC) out/utils.o out/chapter04.o $(IFLAGS) $(LDFLAGS) $(CFLAGS) -o bin/$@

%: %.o
	$(CC) out/$< $(IFLAGS) $(LDFLAGS) $(CFLAGS) -o bin/$@

%.o: %.cpp
	$(CC) $(IFLAGS) $(CFLAGS) -c -o out/$@ src/$<

%.cpp:
	mkdir -p out bin
	literati tangle -o src/. lit/src/$@.lit

includes:
	literati tangle -o include/. lit/include
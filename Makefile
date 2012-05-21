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
EXECUTABLES = helloworld helloopengl chapter01 chapter02a chapter02b chapter02c chapter03a chapter03b

.PHONY: all
.DEFAULT: all

all: includes $(EXECUTABLES)

clean:
	rm -Rf out
	rm -Rf bin

%: %.o
	$(CC) out/$< $(LDFLAGS) $(CFLAGS) -o bin/$@

%.o: %.cpp
	$(CC) $(CFLAGS) -c -o out/$@ src/$<

%.cpp:
	mkdir -p out bin
	literati tangle -o src/. lit/src/$@.lit

includes:
	literati tangle -o include/. lit/include
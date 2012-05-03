CFLAGS=-Wall -g

all: build/helloworld.o
	g++ $(CFLAGS) -o bin/helloworld build/helloworld.o

build/helloworld.cpp:
	mkdir -p build bin
	literati tangle src/helloworld.cpp.lit
	mv output/src/helloworld.cpp build/.

build/helloworld.o: build/helloworld.cpp
	g++ $(CFLAGS) -c -o build/helloworld.o build/helloworld.cpp

clean:
	rm -Rf output
	rm -Rf build
	rm -Rf bin
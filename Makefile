CFLAGS = -std=c++17 -O2 -DNDEBUG

DBGCFLAGS = -std=c++17 -O0 -g -DNDEBUG

rayTracing: src/main.cpp
	g++ $(CFLAGS) -o rayTracing src/main.cpp $(LDFLAGS)

.PHONY: test clean 

test: rayTracing
	./rayTracing
clean:
	rm -f builds/$(NAME)


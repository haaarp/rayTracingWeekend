CXX = g++
CXXFLAGS = -std=c++17

RLSCXXFLAGS = -O2 -DNDEBUG
DBGCXXFLAGS = -O0 -g

SRCFILES = src/main.cpp

rayTracing: $(SRCFILES)
	g++ $(CXXFLAGS) $(RLSCXXFLAGS) -o rayTracing $(SRCFILES)

rayTracingDebug: $(SRCFILES)
	g++ $(CXXFLAGS) $(DBGCXXFLAGS) -o rayTracingDebug $(SRCFILES)

.PHONY: test clean debug

test: rayTracing
	./rayTracing > my_img.ppm
	gwenview my_img.ppm

debug: rayTracingDebug
	gdb rayTracingDebug

clean:
	rm -f rayTracing rayTracingDebug



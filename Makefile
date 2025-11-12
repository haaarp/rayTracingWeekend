CXX = g++
CXXFLAGS = -std=c++17

RLSCXXFLAGS = -O2 -DNDEBUG
DBGCXXFLAGS = -O0 -g

SRCFILES = src/main.cpp
OFILES = src/*.h

rayTracing: $(SRCFILES) $(OFILES)
	g++ $(CXXFLAGS) $(RLSCXXFLAGS) -o rayTracing $(SRCFILES)

rayTracingDebug: $(SRCFILES) $(OFILES)
	g++ $(CXXFLAGS) $(DBGCXXFLAGS) -o rayTracingDebug $(SRCFILES)

.PHONY: test clean debug

test: rayTracing
	./rayTracing > my_img.ppm && gwenview my_img.ppm

debug: rayTracingDebug
	gdb rayTracingDebug

clean:
	rm -f rayTracing rayTracingDebug



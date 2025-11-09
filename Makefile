CFLAGS = -std=c++17

RLSCFLAGS = -O2 -DNDEBUG
DBGCFLAGS = -std=c++17 -O0 -g

SRCFILES = src/main.cpp

rayTracing: $(SRCFILES)
	g++ $(CFLAGS) $(RLSCFLAGS) -o rayTracing $(SRCFILES) $(LDFLAGS)

rayTracingDebug: $(SRCFILES)
	g++ $(CFLAGS) $(DBGCFLAGS) -o rayTracing $(SRCFILES) $(LDFLAGS)

.PHONY: test clean debug

test: rayTracing
	./rayTracing > my_img.ppm
	gwenview my_img.ppm

debug: rayTracingDebug
	gdb rayTracingDebug

clean:
	rm -f builds/*



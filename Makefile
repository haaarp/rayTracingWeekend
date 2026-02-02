CXX = g++
CXXFLAGS = -std=c++17

RLSCXXFLAGS = -O1 -DNDEBUG
DBGCXXFLAGS = -O0 -g -fno-omit-frame-pointer

BUILDDIR= build
SRCFILES = src/main.cpp
OFILES = src/*.h

COMPILE= $(CXX) $(RLSCXXFLAGS)  $(SRCFILES) -o $(BUILDDIR)
COMPILEDEBUG= $(CXX) $(DBGCXXFLAGS) $(SRCFILES) -o $(BUILDDIR)

rayTracing: $(SRCFILES) $(OFILES)
	$(COMPILE)/rayTracing

rayTracingDebug: $(SRCFILES) $(OFILES)
	$(COMPILEDEBUG)/rayTracingDebug

.PHONY: test clean debug

test: rayTracing
	cd $(BUILDDIR); ./rayTracing > my_img.ppm ; gwenview my_img.ppm

debug: rayTracingDebug
	gdb $(BUILDDIR)/rayTracingDebug

profile: rayTracingDebug
	perf record ./$(BUILDDIR)/rayTracingDebug

clean:
	rm -f $(BUILDDIR)/*



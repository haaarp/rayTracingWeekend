CXX = g++
CXXFLAGS = -std=c++17

RLSCXXFLAGS = -O2 -DNDEBUG
DBGCXXFLAGS = -O0 -g -fno-omit-frame-pointer
PROFILEFLAGS = -O2 -g -fno-omit-frame-pointer

BUILDDIR = build
IMGDIR = images

SRCFILES = src/main.cpp
OFILES = src/*.h

BINNAME = rayTracing
DEBUGNAME = $(BINNAME)Debug
PROFILENAME = $(BINNAME)Profile

COMPILE = $(CXX) $(CXXFLAGS) $(SRCFILES)
COMPILEDEBUG = $(COMPILE) $(DBGCXXFLAGS)
COMPILERLS = $(COMPILE) $(RLSCXXFLAGS)
COMPILEPROFILE = $(COMPILE) $(PROFILEFLAGS)

.PHONY: all test debug profile clean

all: rayTracing

rayTracing: $(SRCFILES) $(OFILES)
	mkdir -p $(BUILDDIR)
	$(COMPILERLS) -o $(BUILDDIR)/$(BINNAME)

rayTracingDebug: $(SRCFILES) $(OFILES)
	mkdir -p $(BUILDDIR)
	$(COMPILEDEBUG) -o $(BUILDDIR)/$(DEBUGNAME)

rayTracingProfile: $(SRCFILES) $(OFILES)
	mkdir -p $(BUILDDIR)
	$(COMPILEPROFILE) -o $(BUILDDIR)/$(PROFILENAME)

test: rayTracing
	mkdir -p $(IMGDIR)
	TS=$$(date +%Y%m%d_%H%M%S); \
	./$(BUILDDIR)/$(BINNAME) > $(IMGDIR)/render_$(TS).ppm && \
	magick $(IMGDIR)/render_$(TS).ppm $(IMGDIR)/render_$(TS).png; \
	gwenview $(IMGDIR)/render_$(TS).ppm


debug: rayTracingDebug
	gdb $(BUILDDIR)/$(DEBUGNAME)

profile: rayTracingProfile
	perf record ./$(BUILDDIR)/$(PROFILENAME)

clean:
	rm -rf $(BUILDDIR) 


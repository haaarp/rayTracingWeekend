CXX = g++
CXXFLAGS = -std=c++17 -O2
BLDDIR = builds
TARGET = $(BLDDIR)/rayTracing
SRCFILES = src/main.cpp

$(BLDDIR):
	mkdir -p $(BLDDIR)

rayTracing: $(SRCFILES) | $(BLDDIR)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRCFILES)

test: rayTracing
	./$(TARGET) > $(BLDDIR)/my_img.ppm
	echo "Image saved to $(BLDDIR)/my_img.ppm"
	gwenview $(BLDDIR)/my_img.ppm 

clean:
	rm -rf $(BLDDIR)

.PHONY: test clean


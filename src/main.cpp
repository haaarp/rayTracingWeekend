#include <iostream>
#include <ostream>
int main() {
    // Image 
    int image_width = 256;
    int image_height = 256;
    int MAX_COLOR_VALUE = 255;

    // setting PPM header 
    std::cout<< "P3\n" << image_width << ' ' << image_height << "\n" << MAX_COLOR_VALUE << "\n";

    int helper = 256;
    for (int j = 0; j < image_height; j++) {
	std::clog << "Scanlines remaining" << (image_height-j) << ' ' << std::flush;
	for (int i = 0; i < image_width; i++) {
	    auto r = double(i) / (image_width - 1);
	    auto g = double(j) / (image_height - 1);
	    auto b = 0;

	    int ir = int(255.999 * r);
	    int ig = int(255.999 * g);
	    int ib = int(255.999 * b);

	    std::cout << ir << ' ' << ig << ' ' << ib << '\n';
	} 
    }
    std::clog << "\rDone.				\n";
    return 0;
}

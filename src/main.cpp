#include <iostream>
#include <ostream>
#include "color.h"
#include "vec3.h"
#include "ray.h"


// color of a ray
color ray_color(const ray& r) {
    vec3 unit_direction = unit_vector(r.direction());
    auto a = 0.5*(unit_direction.y() + 1.0);
    // linear interpolation between max color value of 1.0 (black) and min color
    // value (blue) 
    return (1.0-a)*color(0.0, 0.0, 0.0) + a*color(1.0, 1.0, 1.0);
}

int main() {
    // Image 
    int image_width = 50;
    double aspect_ratio = 16.0/9.0;

    // Calculate image height
    int image_height = int(image_width / aspect_ratio);
    // Check if above 1
    image_height = (image_height < 1) ? 1 : image_height;

    // Camera
    
    // Distance viewport and eye 
    auto focal_length = 1.0;
    auto viewport_height = 2.0;
    // Viewport scale same as window scale
    auto viewport_width = viewport_height * (double(image_width) / image_height);

    auto camera_center = vec3(0,0,0);

    auto viewport_u = vec3(viewport_width, 0, 0);
    auto viewport_v = vec3(0, -viewport_height, 0);

    auto pixel_delta_u = viewport_u / viewport_width;
    auto pixel_delta_v = viewport_v / viewport_height;

    // Calculate the location of the upper left pixel of the viewport 
    auto viewport_upper_left = camera_center
                                     - vec3(0, 0, focal_length) - viewport_u/2 - viewport_v/2;
    auto pixel00_loc = viewport_upper_left + 0.5 * (pixel_delta_u + pixel_delta_v);

    // Render
    
    // setting PPM header 
    std::cout<< "P3\n" << image_width << ' ' << image_height << "\n255\n";

    for (int j = 0; j < image_height; j++) {
        std::clog << "\rScanlines remaining: " << (image_height-j) << ' ' << std::flush;
        for (int i = 0; i < image_width; i++) {

            auto pixel_center = pixel00_loc + (i * pixel_delta_u) + (j * pixel_delta_v);
            auto ray_direction = pixel_center - camera_center;

            ray r(camera_center, ray_direction);
            color pixel_color = ray_color(r);

            write_color(std::cout, pixel_color);
        } 
    }
    std::clog << "\rDone.				\n";
    return 0;
}

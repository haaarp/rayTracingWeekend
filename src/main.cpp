#include "rtweekend.h"

#include "bvh.h"
#include "camera.h"
#include "hittable.h"
#include "hittable_list.h"
#include "material.h"
#include "sphere.h"
#include "texture.h"

int triple_spheres_checker() {
    hittable_list world;

    auto checker = make_shared<checker_texture>(0.32, color(0.2, 0.1, 0.3), color(.9,.9,.9));
    world.add(make_shared<sphere>(point3(0,-1000,0), 1000, make_shared<lambertian>(checker)));

    auto material_glass = make_shared<dielectric>(1.5);
    world.add(make_shared<sphere>(point3(0, 1, 0), 1.0, material_glass));

    auto lambertian_material = make_shared<lambertian>(color(1.0, 0.0, 0.0));
    world.add(make_shared<sphere>(point3(0, 1, 2.5), 1.0, lambertian_material));

    auto material_dielectric = make_shared<metal>(color(0.0, 0.7, 0.0), 0.0);
    world.add(make_shared<sphere>(point3(0, 1, -2.5), 1.0, material_dielectric));

    world = hittable_list(make_shared<bvh_node>(world));
    camera cam;

    cam.aspect_ratio      = 16.0 / 9.0;
    cam.image_width       = 1920;
    cam.samples_per_pixel = 500;
    cam.max_depth         = 50;

    cam.vfov     = 10;
    cam.lookfrom = point3(20, 1, 10);
    cam.lookat   = point3(0,1,0);
    cam.vup      = vec3(0,1,0);

    cam.defocus_angle = 0.6;
    cam.focus_dist    = 20.0;

    cam.render(world);
}

void checkered_spheres() {
    hittable_list world;

    auto checker = make_shared<checker_texture>(0.32, color(.2, .3, .1), color(.9, .9, .9));

    world.add(make_shared<sphere>(point3(0,-10, 0), 10, make_shared<lambertian>(checker)));
    world.add(make_shared<sphere>(point3(0, 10, 0), 10, make_shared<lambertian>(checker)));

    camera cam;

    cam.aspect_ratio      = 16.0 / 9.0;
    cam.image_width       = 400;
    cam.samples_per_pixel = 100;
    cam.max_depth         = 50;

    cam.vfov     = 20;
    cam.lookfrom = point3(13,2,3);
    cam.lookat   = point3(0,0,0);
    cam.vup      = vec3(0,1,0);

    cam.defocus_angle = 0;

    cam.render(world);
}

int main(){
    switch(2) {
        case 1: triple_spheres_checker(); break;
        case 2: checkered_spheres(); break;
    }

}
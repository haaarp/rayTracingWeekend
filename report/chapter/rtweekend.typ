// package imports
#import "@preview/lovelace:0.3.0": *

// own imports
#import "../customization/great-theorems-customized.typ": *

= Ray Tracing in a Weekend <chapter:rtweekend>

by #cite(<Shirley2025RTW1>, form: "prose") on the website
https://raytracing.github.io

== C++ Notes

- https://makefiletutorial.com/
- https://www.learncpp.com/cpp-tutorial
- Using #text(font: "hack", fill:orange)[auto] let's the compiler infer the
  type of the variable. Useful whenever the type changes somewhere else in the
  code.


== Ray calculation

1. Calculate the ray from the “eye” through the pixel,
2. Determine which objects the ray intersects, and
3. Compute a color for the closest intersection point.

- *Viewport*: The canvas of the camera view(Gray plane in @cameraModel)
- To make the image scalable, keep *aspect ratio* fixed, and calculate the
  height when the width changes. The *aspect ratio* can't always be achieved
  as the height can't be _real valued_ but an integer rounded down.
- *lerp*: short for _linear interpolation_
$ #text[blendedValue]=(1−a)⋅#text[startValue]+a⋅#text[endValue] $

Please *note* that the coordinate system between the _viewport_ and the
_image_ differ (@viewportGrid and @cameraModel). A way to calculate our
way out of this is presented in the code below.

The ray formula has the form $ bold(P)(t) = bold(A) dot.c t bold(b) $
<formulaLinearInterpolation> and can be seen in
@linearInterpolation.

#figure(
image("../images/linearInterpolation.jpg"),
caption: [ Ray formula: #text(font:"hack", fill: teal)[A] is the origin
position and #text(font: "hack", fill: teal)[b] is the direction. #text(font: "hack", fill: teal)[t] is the
scalar which scales #text(font: "hack", fill: teal)[b] @Shirley2025RTW1] 
) <linearInterpolation>


#figure(
image("../images/fig-1.04-pixel-grid.jpg"),
caption: [ Viewport as seen from the _origin_ or _eye_. The pixels are the green
dots. $v_u$ and $v_v$ are helper vectors to navigate the viewport better
@Shirley2025RTW1.] 
) <viewportGrid>


#set raw(theme: "/halcyon.tmtheme")
#show raw: it => block(
  fill: rgb("#1d2433"),
  inset: 8pt,
  radius: 5pt,
  text(fill: rgb("#a2aabc"), it)
)
```cpp
#include "color.h"
#include "ray.h"
#include "vec3.h"

#include <iostream>

color ray_color(const ray& r) {
    vec3 unit_direction = unit_vector(r.direction());
    auto a = 0.5*(unit_direction.y() + 1.0);
    // linear interpolation between max color value of eg. red: 1.0 = full red and 0.0 = white
    return (1.0-a)*color(1.0, 1.0, 1.0) + a*color(0.5, 0.7, 1.0);
}

int main() {

    // Image
    auto aspect_ratio = 16.0 / 9.0;
    int image_width = 400;

    // Calculate the image height, and ensure that it's at least 1.
    int image_height = int(image_width / aspect_ratio);
    image_height = (image_height < 1) ? 1 : image_height;

    // Camera
    auto focal_length = 1.0;
    auto viewport_height = 2.0;
    auto viewport_width = viewport_height * (double(image_width)/image_height);
    auto camera_center = point3(0, 0, 0);

    // Calculate the vectors across the horizontal and down the vertical viewport edges.
    auto viewport_u = vec3(viewport_width, 0, 0);
    auto viewport_v = vec3(0, -viewport_height, 0);

    // Calculate the horizontal and vertical delta vectors from pixel to pixel.
    auto pixel_delta_u = viewport_u / image_width;
    auto pixel_delta_v = viewport_v / image_height;

    // Calculate the location of the upper left pixel.
    auto viewport_upper_left = camera_center
                             - vec3(0, 0, focal_length) - viewport_u/2 - viewport_v/2;
    auto pixel00_loc = viewport_upper_left + 0.5 * (pixel_delta_u + pixel_delta_v);

    // Render

    std::cout << "P3\n" << image_width << " " << image_height << "\n255\n";

    for (int j = 0; j < image_height; j++) {
        std::clog << "\rScanlines remaining: " << (image_height - j) << ' ' << std::flush;
        for (int i = 0; i < image_width; i++) {
            auto pixel_center = pixel00_loc + (i * pixel_delta_u) + (j * pixel_delta_v);
            auto ray_direction = pixel_center - camera_center;
            ray r(camera_center, ray_direction);

            color pixel_color = ray_color(r);
            write_color(std::cout, pixel_color);
        }
    }

    std::clog << "\rDone.                 \n";
}
```

#figure(
image("../images/my_img.pdf"),
caption: [ Resulting image of the above code ] 
) <my_image>


== Adding a Sphere

$ x^2 + y^2 + z^2 = r^2 $

Is the equation for a sphere. If this equation is fulfilled, a _point_ $bold(P) =
(x,y,z)$ lies on the sphere with radius $r$. A point is inside the sphere if
$x^2 + y^2 + z^2 lt.eq r^2$ and outside the sphere if $x^2 + y^2 + z^2 gt.eq
r^2$.

Using arbitrary Point $bold(C)$ (and not $(0,0,0)$) for the center of the sphere
we get: $ (bold(C)_x−x)^2+(bold(C)_y−y)^2+(bold(C)_z−z)^2=r^2 $

Checking whether a ray hits our sphere, we need to check if the ray equation
@linearInterpolation holds for any $t$.

So for a point $bold(P)$ the formula is: $ (bold(C) - bold(P)) dot.c (bold(C) -
bold(P)) = r^2 $

Filling in the Formula @formulaLinearInterpolation 

#figure(
image("../images/raySphere.jpg"),
caption: [ Three solutions to the quadratic solution of a ray passing a sphere
@Shirley2025RTW1 ] 
) <raySphere>

#figure(
image("../images/normalSPhere.jpg"),
caption: [ The normal of a sphere @Shirley2025RTW1.] 
) <normalSPhere.jpg>


#figure(
image("../images/coloredNormals.jpg"),
caption: [ Using rays and calculating the normals from the hitting rays on the sphere we
can color in the surface according to the normalized surface vector. ]
) <coloredNormals>


#figure(
image("../images/greenBottomSphere.jpg"),
caption: [ Adding a 100 unit radius sphere at 100.5 units below. The blueish
sphere is sitting exactly on top of the green sphere (radius 0.5)] 
) <greenBottomSphere>


#figure(
image("../images/sphere_cropped_aa.jpg"),
caption: [ Antialiasing at work. ] 
) <sphere_cropped_aa>


== Diffuse Materials 
Creating a random point on a unit sphere is surprisingly
complicated. The method used for our approach is to generate a unit square, and
then discard any random vector that lies outside the sphere (see
@randomSampleSphere). 
#figure(
image("../images/randomSampleSphere.jpg", width: 60%),
caption: [ Two vectors were rejected before finding a good one
(pre-normalization) @Shirley2025RTW1. ] 
) <randomSampleSphere>

We then normalize the random vector (pointing on the surface of the unit sphere)
and check whether it points inside the material (using dot product pos or negative)

#figure(
image("../images/isVectorInSurface.jpg", width: 60%),
caption: [ Check if random vector points inside the surface. ] 
) <isVectorInSurface>


#figure(
image("../images/sphere_diffuse_gray.png"),
caption: [ Diffuse sphere using a normal distribution ] 
) <sphere_diffuse_gray>

#figure(
image("../images/sphere_lambertian.png"),
caption: [ Rendered sphere using lambertian distribution
@lambertianDistribution. Note the now blueish tainted spehere surfaces from the
sky and the more pronounced shadows. ] 
) <sphere_lambertian>

#remark(title: "Lambertian Distribution")[
  $ I = I_0 cos(theta) $<lambertianDistribution>
]

#figure(
image("../images/lamberitanDistribution.png"),
caption: [ Lambertian Distribution as in @lambertianDistribution by Inductiveload - Own work, Public Domain, https://commons.wikimedia.org/w/index.php?curid=5290437 ]  
) <lambertianDistributionWiki>

== Metals 

#figure(
image("../images/spheres_metallic_diffuse.png"),
caption: [ Adding a reflective sphere. ] 
) <spheres_metallic_diffuse>

#figure(
image("../images/reflectionVecotr.jpg"),
caption: [ Reflection vector for metallic surfaces by #cite(<Shirley2025RTW1>, form: "prose") ] 
) <reflectionVecotr>

#figure(
image("../images/spheres_metallic.png"),
caption: [ Prettier spheres ] 
) <spheres_metallic>

#figure(
image("../images/creating_fuzzingess.jpg"),
caption: [ Creating fuzziness by adding a random vector to our reflected ray. ] 
) <creating_fuzzingess>

#figure(
image("../images/spheres_fuzzed.png"),
caption: [ Fuzzed spheres ] 
) <spheres_fuzzed>

== Dielectrics

#figure(
image("../images/sphere_glass.png"),
caption: [ Fully reflective glass sphere with $eta = 1.4$ ] 
) <sphere_glass>

#figure(
image("../images/sphere_glass_with_air_bubble.png"),
caption: [ Glass sphere with an air bubble inside. Using refraction and internal
reflection. ] 
) <sphere_glass_with_air_bubble>


#figure(
image("../images/spheres_diff_view_fov.png"),
caption: [ Changing the fov to 20 instead of 60 ]
) <spheres_diff_view_fov>

#figure(
image("../images/spheres_blurry.png"),
caption: [ Using _defocus blur_ to simulate _depth of field_ ] 
) <spheres_blurry>
== Using own Camera Class

After moving the camera to an own class, we can use different angles and
focal points for our spheres.

#figure(
image("../images/spheres_different_view.png"),
caption: [ Different view of the spheres ] 
) <SpheresDiffView>

== Final Image

#figure(
image("../images/final_image.png"),
caption: [ Final Image  ] 
) <final_image>

= Ray Tracing the Next Week

== Adding Movement

#figure(
image("../images/spheres_moving.png"),
caption: [ Moving spheres. ] 
) <spheres_moving>


== Bounding Volume Hierarchies

To speed things up we introduce bounding volumes. With these the ray-object
intersection calculations. We can reduce the time to search for an object
by introducing these bounding volumes. With this we can bring down the search
to a logarithmic time.
#figure(
image("../images/fig-2.01-bvol-hierarchy.jpg"),
caption: [ Bounding Volumes Hierarchy. Note that the bounding volumes can
overlap. ] 
) <bounding_volumes>

== Axis-Aligned Bounding Boxes (AABBs)

For this scene we will use AABBs. They split up the scene nicely in 
Depending on the scene, we can decide how to efficiently split up the scene. For
example when we want to render a world where there are sticks just pointing
vertically in the sky, we might want to split the scene in vertical stripes,
without a horizontal component. 



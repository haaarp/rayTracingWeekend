// package imports
#import "@preview/lovelace:0.3.0": *

// own imports
#import "../customization/great-theorems-customized.typ": *

== The student should prepare a written report about his topic following the following schema:

- Start with the introduction: *What is your topic and what have other researchers done in that topic, with references*
- Add a 2nd section with *In detail description of the algorithms you want to implement*
- Implement your algorithms in your engine of choice
- Start testing and document the issues you have *this will become section 3*
- Fix the issues and document your solution *this will become section 4*
- Document further possible work which could enhance your results *This will become section 5: Future work.*

= Ray Tracing in a Weekend <chapter:rtweekend>

by #cite(<Shirley2025RTW1>, form: "prose") on the website
https://raytracing.github.io

The book series are a tutorial to create a ray tracer from scratch in C++.


== C++ References

The project was written in C++ for performance reasons. I opted for Makefiles
instead of CMake to additionally learn Makefile creation. I used the following
references to understand both topics better.

- https://makefiletutorial.com/
- https://www.learncpp.com/cpp-tutorial

== Ray calculation

A ray tracer generates am image by shooting rays into a scene, see if a ray
intersects with an object, create additional rays from there on, and finally
calculate the color if the ray does not propagate further. Depending on the
material the ray hits, different colors and ray bounce directions will be taken.
If the ray goes to infinity (or a specified maximum distance), the color will be the background color of the scene.

#remark(title: "PPM Image Format")[
  A simple way to generate images is to use the .ppm image format. An RGB value
  is specified for each pixel in plain text form. A simple header will set the
  dimension and bit values. ]

The ray can be implemented as a simple vector in 3 dimensions. By using an
additional value `t` as a scalar the ray can simply be extended in the scene
(see @linearInterpolation).

#figure(
  image("../images/linearInterpolation.jpg"),
  caption: [ Ray formula: #text(font:"hack", fill: teal)[A] is the origin
  position and #text(font: "hack", fill: teal)[b] is the direction. #text(font: "hack", fill: teal)[t] is the scalar which scales #text(font: "hack", fill: teal)[b] @Shirley2025RTW1] 
) <linearInterpolation>

#remark(title: "Linear Interpolation")[
  (Abbr.: _lerp_'). Interpolates between two values:
  $ #text[blendedValue]=(1−a)⋅#text[startValue]+a⋅#text[endValue] $
  Using this together with RGB values creates a fade, as seen in @my_image.
]

- *Viewport*: The canvas of the camera view(Gray plane in @cameraModel)
- To make the image scalable, keep *aspect ratio* fixed, and calculate the
height when the width changes. The *aspect ratio* can't always be achieved
as the height can't be _real valued_ but an integer rounded down.
- *lerp*: short for _linear interpolation_
$ #text[blendedValue]=(1−a)⋅#text[startValue]+a⋅#text[endValue] $

Please *note* that the coordinate system between the _viewport_ and the
_image_ differ (@viewportGrid and @cameraModel). This can be accounted for and
is simple vector arithmetic

#figure(
  image("../images/fig-1.04-pixel-grid.jpg", width: 60%),
  caption: [ Viewport as seen from the _origin_ or _eye_. The pixels are the green
  dots. $v_u$ and $v_v$ are helper vectors to navigate the viewport better
  @Shirley2025RTW1.] 
) <viewportGrid>


The ray formula as in @linearInterpolation has the form $ bold(P)(t) = bold(A) dot.c t bold(b) $
<formulaLinearInterpolation> 


#figure(
  image("../images/my_img.pdf"),
  caption: [ Using `lerp` between blue and white to create a faded background ] 
) <my_image>


== Spheres

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
- spheres 
- remark: sphere formula

===

= Materials 

Materials can be fairly straight forward calculated with ray tracing. The
following

== Diffuse Surfaces

With deffuse surfaces, any incoming ray will either be absorbed or reflected.
The darker a material the more often the ray will be absorbed than reflected.

Any reflected ray will bounce of in a random direction. But creating a random point on a unit sphere is surprisingly complicated. The method used for our approach is to generate a unit square, and then discard any random vector that lies outside the sphere (see
@randomSampleSphere). 

#figure(
  image("../images/randomSampleSphere.jpg", width: 60%),
  caption: [ Two vectors were rejected before finding a good one
  (pre-normalization) @Shirley2025RTW1. ] 
) <randomSampleSphere>

We then normalize the random vector (pointing on the surface of the unit sphere)
and check whether it points inside the material (using dot product positive or negative)

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

#remark(title: "Shadow Acne")[

When a ray bounces of the material it might happen, that rounding
errors in the floating point arithmetic cause a ray to bounce inside the
material. This may cause the material to appear darker than it really is as the
rays bounce too often inside the material. This effect is called shadow acne and
can be prevented by adding _padding_.

]

== Metals 

Similarly to lambertian materials, metals also either reflect or absorb any ray.
But instead of reflecting the ray according to the @lambertianDistribution, rays
will have the same angle as the incoming ray (see @reflectionVecotr). This makes
the material shiny and reflects like a mirror.


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

=== Fuzziness

To create brushed off or fuzzy metallic surfaces we additionally add a new
random vector from the reflected ray like in @creating_fuzzingess. The higher
the fuzz value, the bigger the vector will get. This effect causes the materials
to appear like in @spheres_fuzzed.

It is important to also account for when a ray comes from which refractive
index. 

#figure(
  image("../images/creating_fuzzingess.jpg", width: 60%),
  caption: [ Creating fuzziness by adding a random vector to our reflected ray. ] 
) <creating_fuzzingess>

#figure(
  image("../images/spheres_fuzzed.png", width: 60%),
  caption: [ Fuzzed spheres ] 
) <spheres_fuzzed>

== Dielectrics 

If rays hit dielectric materials like glass, the rays won't get absorbed but
will get refracted. The new ray calculation upon material hit will take on the
form of Snells laws.

#figure(
  image("../images/sphere_glass.png", width: 60%),
  caption: [ Fully reflective glass sphere with $eta = 1.4$ ] 
) <sphere_glass>

#figure(
  image("../images/sphere_glass_with_air_bubble.png", width: 60%),
  caption: [ Glass sphere with an air bubble inside. Using refraction and internal
  reflection. ] 
) <sphere_glass_with_air_bubble>



== Defocus Blur

#figure(
  image("../images/spheres_diff_view_fov.png", width: 60%),
  caption: [ Changing the fov to 20 instead of 60 ]
) <spheres_diff_view_fov>

#figure(
  image("../images/spheres_blurry.png", width: 60%),
  caption: [ Using _defocus blur_ to simulate _depth of field_ ] 
) <spheres_blurry>
== Using own Camera Class

After moving the camera to an own class, we can use different angles and
focal points for our spheres.

#figure(
  image("../images/spheres_different_view.png", width: 60%),
  caption: [ Different view of the spheres ] 
) <SpheresDiffView>

== Final Image

#figure(
  image("../images/final_image.png"),
  caption: [ Final Image  ] 
) <final_image>

= Ray Tracing the Next Week

== Adding Movement

By choosing yet again a random value for each ray between an interval of the
sphere we can create motion blur. 

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



= Introduction<chap:introduction>

#v(2cm)

The book series are a tutorial to create a ray tracer from scratch in C++. My
work implemented this tutorial and documented the progress with graphics of the
rendered images. 

== Overview

I present simple explanations of algorithms implemented. The main code will be
in C++. 

- remark
- ppm image format
- viewport
  - bottom top left to bottom right
  - u, v helper vectors

== Ray tracing from Eye

- take ray and calculate where it will hit something
- if hit calculate color
  - depending on material the color will have a different value
  - either bounce or apply color
- if ray goes to infinity then use background color

- Linear interpolation
  - Remark


== Object Creation

=== Adding a Sphere

- spheres 
- remark: sphere formula

===

== Materials 
 
=== Lambertian Surfaces

- any incoming ray will either be absorbed or reflected
- if reflected new ray in random direction with cosine 
- if absorbed color at that point
- more bounce = more dark
- depending on material

=== Shadow Acne

  When a ray bounces of the material it might happen, that rounding
  errors in the floating point arithmetic cause a ray to bounce inside the
  material. This may cause the 

=== Metals 

- either absorb the ray or reflect
- this time reflection is always incoming ray angle = outgoing ray angle

- when creating fuzziness we adjust the outgoing ray angle
- create a new random vector from outgoing vector and add them figi
- more fuzz = larger vector

=== Glass

- if ray hits glass ray will be refracted
- depends on angle of refraction
- Snells law 
- if putting air bubble inside glass there is even inter reflection


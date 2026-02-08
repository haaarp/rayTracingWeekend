#import "../customization/great-theorems-customized.typ": *
#set heading(numbering: none)  // Heading numbering
#set math.equation(numbering: "(1)")

= Appendix: Lecture Notes
#counter(heading).update(1)

#set heading(numbering: "A.1", supplement: [Appendix])  // Defines Appendix numbering

#remark(title: "What to do")[
  For each material, write a small comment (e.g. one paragraph) regarding 
- Most interesting parts for you
- Parts you did not understand
- References you'd like to explore in more depth
- Any further observations
]

== Rainbows<sec:rainbows>
@rainbows

While being around for a long time, rainbows are still not fully understood, especially the rare _twinned rainbow_ which
can be seen in @twinnedRainbow. However, advancements have been
made by #cite(<rainbows>, form: "prose"), by ray tracing non-spherical water
drops. The provided @dropVisualization is helpful to understand the rainbow
creation process. 

The work extends Lorenz-Mie theory by ray tracing non-spherical water drops. A
simulation needs to include the following aspects:

- _Diffraction_ (scattering of light, white band)
- _Geometric optics_ (primary and secondary arc)
- _Interference_ (supernumerary arcs)
- _Polarization_ (polarization of primary and secondary arc)

=== Supernumerary arcs<subsec:supernumaryArcs>

Because of different path length there are additional rays which result in
supernumerary arcs (See @dropVisualization (c)). This can not be explained
with purely geometric optics.

In @leeDiagram are the primary and secondary arc clearly visible, together with
the Alexander band (dark area between rainbows).

#figure(
  image("../images/leeDiagram.png", width: 60%),
  caption: [ Lee diagram showing the variation in appearance of primary and
  secondary rainbows caused by scattering of sunlight by a spherical water
  drop as a function of radius (Lorenz-Mie theory calculations). ] 
) <leeDiagram>

#figure(
  image("../images/waterdropVisualizationRay.png", width: 100%),
  caption: [Generation of rainbows from the point of view of geometric
  optics and wave optics: (a) primary rainbow angle, after a single internal
  reflection; (b) secondary rainbow angle, after two internal reflections; (c)
  supernumerary rainbows are generated from constructive and destructive
  interference patterns (inspired by #cite(<lee2001rainbow>, form: "prose"); (d) diffraction extends the wavefront
  and avoids abrupt intensity changes. ] 
) <dropVisualization>

#figure(
  image("../images/pairRainbow.png", width: 50%),
  caption: [ Twinned rainbows ] 
) <twinnedRainbow>

#figure(
  image("../images/nonsphericalWaterdropGrid.png", width: 60%),
  caption: [ Steps of the Algorithm ] 
) <nonsphericalWaterdropGrid>



== Birefringence and Iridescence<sec:birefringence> by #cite(label("DBLP:journals/cgf/Steinberg19"), form: "prose")


#remark(title: "Note")[
- Math is way above me
- I should look into "Electrodynamics and Optics" by
#cite(<demtroder2019electrodynamics>, form: "prose") again...
]


When polarized light waves have different paths through an
_anisotropic_ optically transmissive
medium (transparent) depending on their polarization it is called
_birefringence_. Color changes based on viewing angle is called _iridescence_.
Light creates iridescence when it interferes which each other inside the medium.
Iridescence is most drastic when seen through a polarization filter.

#figure(
  image("../images/birefringence.png", width: 60%),
  caption: [ Birefringence-induced iridescence due to deformations under
  non-uniform mechanical stress ] 
) <birefringenceImg>


#figure( image("../images/randomlyPolarizedWavehittingMaterial.png", width: 60%), caption: [
  Randomly polarized light wave, incident to an anisotropic material, refracted
  into linearly-polarized ordinary and extraordinary rays. Note that the
  extraordinary Poynting vector leaves the plane of incidence (Y Z) and is
  detached from its wave’s direction of propagation. The incident parameter K
  and the normal modes $q^−_o$, $q_e^−$ for the (not normalized) ordinary and
  extraordinary waves are marked. The incidence parameter remains constant
  across surface boundaries for all participating waves. ]
)<randomlyPolarizedWavehittingMaterial>



#figure(
  image("../images/birefringenceCristal.png", width: 60%),
  caption: [ Crystal where two different polarized waves split up on different
  paths. ] 
) <birefringenceCrystal>


#figure(
  image("../images/coherenceInterference.png", width: 60%),
  caption: [ Coherence of $200 mu m$. Interference with itself? ] 
) <coherenceInterference>



== Ray Tracing Special Relativity 

by #cite(label("DBLP:journals/tvcg/MullerGW10"), form: "prose"). The methods in
the paper render polygons while
taking special relativistic effects into account. Vectors in 3D have one
additional vector in the time dimension (Minkowsky spacetime). $(c t,x,y,z)^T$ and
$(c t, x', y', z')^T$. The time is multiplied by c to have the same units in
both systems.

#figure(
  image("../images/relativeCoordinates.png", width: 60%),
  caption: [ Two coordinate system $S$ and $S'$ with relative to each other.
  $S$ travels with velocity $v$. ] 
) <relativeCoordinates>


When using Polygons instead of ray tracing, some parts of a model render
incorrectly (see @clipRelativistic). The method of this paper can render
the _Doppler effect_, _color shifts_ and the _searchlight effect_.

#figure(
  image("../images/clipRelativistic.png", width: 60%),
  caption: [ Clipped part because of polygons (Top). Correctly ray traced
  (Bottom) ] 
) <clipRelativistic>

Cannot be applied to moving objects why?



== General Relativity<sec:GeneralRelativity>


by #cite(<James_2015>, form: "prose"). 


#remark(title: "Website with Black Hole Simulations")[
  https://jila.colorado.edu/~ajsh/insidebh/schw.html
]

Previous work has been done on Black holes that are far away. This paper is
interested in a more close up and moving camera setting. I did not notice
before, that the black hole in the movie _Interstellar_ is a spinning black
hole, and is therefore not symmetric (see @paintSwatch).

#figure(
  image("../images/paintSwatch.png", width: 60%),
  caption: [ Paint-swatch ] 
) <paintSwatch>

#figure(
  image("../images/celestailSphere.png", width: 60%),
  caption: [ The mapping of the camera's local sky ($theta_("cs"),phi_("cs")$) onto the celestial
  sphere ($theta',phi'$) via a backward directed light ray; and the evolution of a
  ray bundle, that is circular at the camera, backward along the ray to its
  origin, an ellipse on the celestial sphere. ] 
) <celestailSphere>


#figure(
  image("../images/twoLightRays.png", width: 60%),
  caption: [ Two light rays from a star hitting the camera's sky. ] 
) <twoLightRays>


== Tetrachromatic Vision

The human eye has two types of photoreceptors. While rods are used for low light
scenarios and are used mostly for our peripheral vision, cones are used for
color vision (phototropic vision) and are mostly concentrated in the middle of
our FOV. 

There exist three cones the human vision responsible for respectively
blue, green and red light (see @Cones_SMJ2_E). Human vision is so called
trichromatic vision due to the three cones. 

Tetrachromatic vision extends the trichromatic vision. While humans generally
don't have this type of vision, there has been one case, where another cone sat
between the green and red cone. 

#remark(title: "Mesopic Vision")[
  In low light situations the human brain uses both rods and cones to see
  better. While rods are not used for color vision per se, due to their
  sensitivity being highest at the blue/green frequency, blue and green color is
  perceived stronger in low light situations, as for example red light.
]

#figure(
  image("../images/Cones_SMJ2_E.svg", width: 60%),
  caption: [ Normalized responsivity spectra of human cone cells, S, M, and L
  types. By Vanessaezekowitz at en.wikipedia, CC BY 3.0, https://commons.wikimedia.org/w/index.php?curid=10514373 ] 
) <Cones_SMJ2_E>





== ScratchAPixel's Ray Tracing Introduction

- Path tracing: Advanced ray tracing including _global illumination_ and _monte_
  _carlo_ rays with multiple bounces. *Very accurate*. And better for offline
  simulation.

#figure(
image("../images/reflectionrefraction.gif"),
caption: [ Reflection and refraction on a sphere. ] 
) <ReflactionRefraction>


== Setup VNC

Install `tigervnc` client: `pacman -Syu tigervnc`

Same on the server: `pacman -Syu tigervnc`

Open the necessary ports on the server:

`firewall-cmd --add-service=vnc-server`

`firewall-cmd --add-port=5900`


== Error Correction in Photon Mapping

For some reason there exists an error in literature, where the k-th photon is
included in the irradiance calculation. By ignoring this last photon the bias
disappears #cite(label("DBLP:journals/cgf/GarciaUS12")).

#figure(
image("../images/mathematicakminus1.png"),
caption: [ Mathematica code calculating the bias of the k-th photon. Second term
uses the k-1-th photon for the correct result. ] 
) <kminusone>

== Estimates for Ray Tracing Runtimes

As ray tracing uses recursive functions for each ray, computation of a full
picture can be quite expensive with naive algorithms.

=== Ray Tracing (from Eye)

#remark(title: "Pseudocode")[
```python
  for x in width:
    for y in height:
      sendRay(direction)
      if intersectWithObject:
        if depth < maxDepth:
          color = updateColor(point, intensity)
          sendRay(direction * distribution)
        else return color
```
]

== Text 2 Image with ComfyUI

Install the UI from the ComfyUI GitHub page. When choosing a model template, you
need to install the downloaded `.safetensor` files in the `/models/checkpoints/`
directory. 

The model used was only 2GB in download size. When trying out the
bigger models, my system ran out of RAM and crashed. 

#figure(
  grid(
    columns: 2,
    gutter: 2mm,
    image("../images/Chalet1.png"),
    image("../images/Chalet2.png")
  ),
  caption: [ Prompt: "Chalet in Swiss". The right image additionally
  contains the word _snow_ in the _negative prompt_ ] 
) <Chalets>

#figure(
image("../images/birdHut.png"),
caption: [ Prompt: "Two birds in the sky with a hut in the woods". ]
) <birdHut>


= Notes from Computer Graphics 1

Course from summer semester 2025: https://moodle.lmu.de/course/view.php?id=39021

#figure(
  image("../images/cameraModel.png", width: 60%),
  caption: [ Convention for z-axis to be negative to keepx and y positive.] 
) <cameraModel>

#figure(
  image("../images/projectionmatrix.png", width: 60%),
  caption: [ One possibility for a projection matrix. Where $w_("sicht")$ is the
  negative z axis from @cameraModel.] 
) <projectionmatrix>

To get perspective with a matrix we use _perspective division_ which divides
each point by its 4th coordinate $w$

== Rendering Equation

#figure(
  image("../images/RenderingEquation.jpg"),
) <RenderingEquation>


= Vulkan Tutorial

Vulkan can be very fast because everything is done implicit. This means to do
basic things you also have to be implicit about the whole thing. Meaning
setup of graphic cards and so on. This leads to a lot of boilerplate code.

== Triangle Tutorial

From https://vulkan-tutorial.com/

#remark(title: "Steps to draw a triangle:")[
- Create a VkInstance
- Select a supported graphics card (VkPhysicalDevice)
- Create a VkDevice and VkQueue for drawing and presentation
- Create a window, window surface and swap chain
- Wrap the swap chain images into VkImageView
- Create a render pass that specifies the render targets and usage
- Create frame buffers for the render pass
- Set up the graphics pipeline
- Allocate and record a command buffer with the draw commands for every possible swap chain image
- Draw frames by acquiring images, submitting the right draw command buffer and returning the images back to the swap chain
]


#shellcommands(title: "Prerequisites Vulkan for OpenSUSE Linux")[ `$ sudo zypper in glm-devel vulkan-devel shaderc libXi-devel libglfw-devel libXxf86vm-devel` ]

=== Coding Conventions

Functions are written with lowercase `vk`, while structs and enums are `Vk` and
enumerations have a `VK_` prefix.

Structs are very heavily used in Vulkan. To create a C++ struct first initialize
an empty struct with `VkCreateInfo createInfo{};` (note the `Vk` prefix). 

=== Validation Layers

Vulkan does not check for any errors to be as fast as possible.
Validation Layers provide access to some debug functionality. When in debug mode
one can activate these layers with a small performance impact. But they can be
ignored otherwise.

#set raw(theme: "/halcyon.tmtheme")
#show raw: it => block(
  fill: rgb("#1d2433"),
  inset: 8pt,
  radius: 5pt,
  text(fill: rgb("#a2aabc"), it)
)
```cpp
const std::vector<const char*> validationLayers = {
    "VK_LAYER_KHRONOS_validation"
};

#ifdef NDEBUG
    const bool enableValidationLayers = falsespecific // As Vulkan uses queues,
    we need to check whether our GPU supports a queues
#else
Using optional as the indices could be anything, and we need to provide a way to
say "Nothing found!"const bool enableValidationLayers = true;
#endif
```

= OpenGL Tutorial

OpenGL is the predecessor of Vulkan also by Khronos Group. 

#remark(title: "Dependencies needed")[

  Similar to Vulkan, OpenGL also uses glfw3. So for window creation we need to
  compile our C++Code with `-lglfw3 -lGL -lX11 -lpthread -lXrandr -lXi -ldl` ]

== Triangle Tutorial

From https://learnopengl.com/Getting-started/Hello-Triangle


The rendering pipeline can be used to create 2D object from a 3D system.
With a shader we can modify objects (e.g. color).

1. Vertex shader:

Takes a single vertex as input and performs transformations. (Maybe used for
rotation? Together with a matrix?) OpenGL supports at least 16 #text(fill:
olive)[vertex attributes]. 

You can't modify shaders from another shader perse, they always take an input
and give out an output. These are the primary ways to pass information between
shaders. There is however a way of accessing shader variables and so on with the 
#text(font: "hack")[uniform] keyword.

#remark(title: "C Programming Note")[
  There is no function overloading in native c (OpenGL shader language).
]

#table(
columns: 3,
column-gutter: 3em,
stroke: none,
[VBO], [Vertex Buffer Object], [ Stores raw vertex data ],
[VAO], [Vertex Array Object], [ Stores state and configuration in an array on
how to interpret the VBOs],
[EBO], [Element Buffer Object], [ Stores list of indices for vertexes that can
be reused (two triangle give a rectangle, they share 2 vertices)],
)

Buffer objects load objects in the GPUs RAM. 

1. Generate VBOs and EBOs
2. Configure how they should be read in the VAO
3. Bind VAO in render loop to draw

#figure(
image("../images/openGLpipeline.png", width: 70%),
caption: [ OpenGL Pipeline ] 
) <openGLpipeline>

#figure(
image("../images/triangleCoordinates.png", width: 70%),
caption: [ Normalized Device Coordinates (NDC). Note that everything outside of
[(-1,-1), (1,1)] will be clipped ]
) <triangleCoordinates>

#figure(
image("../images/openGL_triangle.png"),
caption: [ My first triangle! ] 
) <openGL_triangle>

#figure(
box(image("../images/linesTriangle.png", width: 50%))+
box(image("../images/triangle_lineloop.png", width: 50%)),
caption: [ Using GL_LINE_STRIP and GL_LINE_LOOP instead of GL_TRIANGLE as a parameter in glDrawElements ] 
) <lines_triangle>

#figure(
box(image("../images/prettier_color.png", width: 50%))+
box(image("../images/rgbTriangle.png", width: 50%)),
caption: [ Prettier colors and RGB triangle using shaders ] 
) <lines_triangle>


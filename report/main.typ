// global
#import "@preview/clean-math-thesis:0.4.0": template

//local
#import "customization/colors.typ": *


#show: template.with(
  author: "Kasimir Rothbauer",
  title: "Writing Your Own Ray Tracer",
  supervisor1: "Dr. Rubén Jesús García-Hernández",
  supervisor2: "",
  program: "Advanced Topics in Computer Graphics",
  university: "Ludwig-Maximilians-Universität München",
  institute: "Kommunikationssysteme und Systemprogramierung",
  deadline: datetime.today().display(),
  city: "Munich",
  degree: "",

  // file paths for logos etc.
  uni-logo: image("images/LMU_logo.png", width: 50%),

  // formatting settings
  body-font: "Libertinus Serif",
  cover-font: "Libertinus Serif",

  // equation settings
  equate-settings: (breakable: true, sub-numbering: true, number-mode: "label"),
	equation-numbering-pattern: "(1.1)",

  // colors
  cover-color: color3,
  heading-color: color1,
  link-color: color2
)

// ------------------- content -------------------

#include "chapter/introduction.typ"
#include "chapter/algorithm_overview.typ"
#include "chapter/rtweekend.typ"
#include "chapter/lectureNotes.typ"
#include "chapter/presentation.typ"

// ------------------- bibliography -------------------
#bibliography("References.bib")


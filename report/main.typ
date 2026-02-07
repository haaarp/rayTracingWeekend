// global
#import "@preview/clean-math-thesis:0.4.0": template

//local
#import "customization/colors.typ": *


#show: template.with(
  author: "Kasimir Rothbauer",
  title: "Writing Your Own Ray Tracer",
  supervisor1: "Dr. Rubén Jesús García-Hernández",
  program: "Advanced Topics in Computer Graphics",
  university: "LMU",
  institute: "Kommunikationssysteme und Systemprogramierung",
  deadline: datetime.today().display(),

  // file paths for logos etc.
  uni-logo: image("images/LMU_logo.png", width: 50%),
  institute-logo: image("images/LMU_full_logo.png", width: 50%),

  // formatting settings
  body-font: "Libertinus Serif",
  cover-font: "Libertinus Serif",

  // equation settings
  equate-settings: (breakable: true, sub-numbering: true, number-mode: "label"),
	equation-numbering-pattern: "(1.1)",

  // colors
  cover-color: color1,
  heading-color: color2,
  link-color: color3
)

// ------------------- content -------------------

#include "chapter/rtweekend.typ"
#include "chapter/lectureNotes.typ"

// ------------------- bibliography -------------------
#bibliography("References.bib")


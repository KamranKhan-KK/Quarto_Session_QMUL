<<<<<<< HEAD
# quarto-qmul session
=======
# quarto- session QMUL 
>>>>>>> 62ee0a8bafdeb2eb8ec75fd8198d3c95e8c50955

Quarto: An Introduction

## Setup notes

R version 4.4.1 (2024-06-14)
Platform: aarch64-apple-darwin20
Running under: macOS Sonoma 14.7

Matrix products: default
BLAS:   /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib 
LAPACK: /Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.0

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

time zone: Europe/London
tzcode source: internal

attached base packages:
[1] stats     graphics 
[3] grDevices utils    
[5] datasets  methods  
[7] base     

loaded via a namespace (and not attached):
[1] compiler_4.4.1   
[2] tools_4.4.1      
[3] rstudioapi_0.16.0
> 
- Packages: tidyverse, palmerpenguins, gt

## Demo

### Documents

- Open the simple Quarto document called `index.qmd` and edit it using the RStudio Visual Editor.
- Bold palmerpenguins and add link to https://allisonhorst.github.io/palmerpenguins/.
- Add code chunk options:
  - `fig-alt`
  - `echo: false` in `execute` in the YAML
  - `code-fold`
  - teaching tip: `echo: fenced`
- Add a figure and a table and cross reference them
- Add a citation: 10.1371/journal.pone.0090081

### Slides

- Change `format: revealjs`
- Add section headings: First level headings Introduction and Analysis, under Analysis a second level heading called Modeling
- Incremental lists
- Add columns and tabsets
- Reveal code with `echo: true`
  - teaching-tip: `code-line-numbers`
- Change `output-location` of figure
- Logo and footer
- Making things fit on a slide
- Chalkboard
- Publishing your presentation to Quarto Pub
- Printing to PDF

### Websites

- Add `quarto.yml` 

```
project:
  type: website

website:
  title: "Hello Quarto"
  navbar:
    left:
      - index.qmd
      - talk.qmd
```

- Render
- Add other formats to index.qmd:

```
format:
  html: default
  pdf: default
```

- Navigation
- Add one more document with R chunk
- Freeze
- Themes and dark theme toggle
- `publish quarto`

### Journal articles (time permitting)

- Go to https://quarto.org/docs/journals/templates.html

- Click on Quarto journals repo

- Create one with JASA template

my-awesome-paper

- Add a citation

First from Zotero
Welcome to the tidyverse

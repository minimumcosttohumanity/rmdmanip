# RMDmanip works for plain md files

    Code
      rmd
    Output
      [1] "---\nparams:\n  placeholder: 1.0\n---\n# Rmarkdown body\n# More body\n"

# Setting yaml items works

    Code
      rmd
    Output
      [1] "---\ntitle: Amended RMD\noutput: html_document\nparams:\n  brilligness: slither tove\n  gyre: 1.0\n  wabe:\n  - 1.0\n  - 2.0\n  momerats:\n  - out\n  - grabe\n  beware:\n    value:\n      jabberwock:\n        jaws: bite\n        claws: catch\n  heed:\n    value:\n      bandersnatch: frumious\n---\n# Rmarkdown body\n"

# Setting yaml items as list works

    Code
      rmd
    Output
      [1] "---\ntitle: Test RMD\noutput: html_document\nparams:\n  brilligness: slither tove\n  gyre: 1.0\n  wabe:\n  - 1.0\n  - 2.0\n  momerats:\n  - out\n  - grabe\n  beware:\n    value:\n      jabberwock:\n        jaws: bite\n        claws: catch\n  heed:\n    value:\n      bandersnatch: frumious\n---\n# Rmarkdown body\n"


test_that("Parsing works", {
  basetext = '---\ntitle: "Test RMD"\noutput: html_document\n---\n# Rmarkdown body\n'
  rmd = rmdmanip$new(basetext)$getHead()

  expect_equal(rmd, list(title = "Test RMD", output = "html_document"))
})

test_that("Building works", {
  basetext = '---\ntitle: "Test RMD"\noutput: html_document\n---\n# Rmarkdown body\n'
  rmd = rmdmanip$new(basetext)$build()

  expect_equal(rmd, "---\ntitle: Test RMD\noutput: html_document\n---\n# Rmarkdown body\n")
})

test_that("Setting yaml items works", {
  basetext = '---\ntitle: "Test RMD"\noutput: html_document\n---\n# Rmarkdown body\n'
  rmd = rmdmanip$new(basetext)$put('title', 'Amended RMD')$build()
  rmd = rmdmanip$new(basetext
    )$putParam('brilligness', 'slither tove'
    )$putParam('gyre', 1
    )$putParam('wabe', c(1,2)
    )$putParam('momerats', c('out', 'grabe')
    )$putParam('beware', list('jabberwock'= list('jaws' = 'bite', 'claws' = 'catch') )
    )$putParam('heed', list('bandersnatch'= 'frumious' )
    )$build()

  expect_snapshot(rmd)
})

test_that("File builds", {
  fol = tempdir(check=T)
  fn = paste0(fol, '/temp.Rmd')
  fn2 = paste0(fol, '/temp.html')
  basetext = '---\ntitle: "Test RMD"\noutput: html_document\n---\n# Rmarkdown body\n'
  rmd = rmdmanip$new(basetext
    )$put('title', 'Amended RMD'
    )$putParam('brilligness', 'slither tove'
    )$putParam('gyre', 1
    )$putParam('wabe', c(1,2)
    )$putParam('momerats', c('out', 'grabe')
    )$putParam('beware', list('jabberwock'= list('jaws' = 'bite', 'claws' = 'catch') )
    )$putParam('heed', list('bandersnatch'= 'frumious' )
    )$build()

  lines = stringr::str_split(rmd, '\n')
  fileConn<-file(fn)
  for (x in lines){
    writeLines(x, con = fileConn, sep='\n')
  }
  close(fileConn)

  rmarkdown::render(fn, output_file = fn2)

  expect_snapshot_file(fn2)

})


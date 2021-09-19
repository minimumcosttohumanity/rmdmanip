test_that("Parsing works", {
  basetext = '---\ntitle: "Test RMD"\noutput: html_document\n---\n# Rmarkdown body\n'
  rmd = read.rmds(basetext)$getHead()

  expect_equal(rmd, list(title = "Test RMD", output = "html_document"))
})

test_that("Building works", {
  basetext = '---\ntitle: "Test RMD"\noutput: html_document\n---\n# Rmarkdown body\n'
  rmd = read.rmds(basetext) %>% dumps()

  expect_equal(rmd, "---\ntitle: Test RMD\noutput: html_document\n---\n# Rmarkdown body\n")
})

test_that("Roundtrip works also with multiple --- lines", {
  basetext = '---\ntitle: Test RMD\noutput: html_document\n---\n# Rmarkdown body\n---\n# More body\n'
  rmd = read.rmds(basetext) %>% dumps()
  expect_equal(rmd, basetext)
})

test_that("RMDmanip works for plain md files", {
  basetext = '# Rmarkdown body\n# More body\n'
  rmd = read.rmds(basetext) %>% dumps()
  expect_snapshot(rmd)
})



test_that("Saving works", {
  fol = tempdir(check=T)
  fn = paste0(fol, '/test_temp_1.txt')

  basetext = '---\ntitle: Test RMD\noutput: html_document\n---\n# Rmarkdown body\n'
  read.rmds(basetext) %>% dumpf(fn)
  rmd = read.rmd(fn) %>% dumps()

  expect_equal(rmd, basetext)
})


test_that("Setting yaml items works", {
  basetext = '---\ntitle: "Test RMD"\noutput: html_document\n---\n# Rmarkdown body\n'
  rmd = read.rmds(basetext) %>%
    put_param('brilligness', 'slither tove') %>%
    put_param('gyre', 1) %>%
    put_param('wabe', c(1,2)) %>%
    put_param('momerats', c('out', 'grabe')) %>%
    put_param('beware', list('jabberwock'= list('jaws' = 'bite', 'claws' = 'catch') )) %>%
    put_param('heed', list('bandersnatch'= 'frumious' )) %>%
    put('title', 'Amended RMD') %>%
    dumps()

  expect_snapshot(rmd)
})

test_that("File builds", {
  fol = tempdir(check=T)
  fn = paste0(fol, '/temp.Rmd')
  fn2 = paste0(fol, '/temp.tex')
  basetext = '---\ntitle: "Test RMD"\noutput: latex_fragment\n---\n# Rmarkdown body\n'
  rmd = read.rmds(basetext) %>%
    put_param('brilligness', 'slither tove') %>%
    put_param('gyre', 1) %>%
    put_param('wabe', c(1,2)) %>%
    put_param('momerats', c('out', 'grabe')) %>%
    put_param('beware', list('jabberwock'= list('jaws' = 'bite', 'claws' = 'catch') )) %>%
    put_param('heed', list('bandersnatch'= 'frumious' )) %>%
    put('title', 'Amended RMD') %>%
    dumpf(fn)

  rmarkdown::render(fn, output_file = fn2)

  expect_snapshot_file(fn2)

})


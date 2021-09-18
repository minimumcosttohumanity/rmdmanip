# rmdmanip

![Tests](https://github.com/minimumcosttohumanity/rmdmanip/actions/workflows/r.yml/badge.svg)

Provides a simple class interface to set and change headers of .Rmd files. 

## Goal

R markdown files start with a preamble header that provides metadata and which allows the setting of parameters. The format of this header is a (modified) yaml, structured as follows:

```
---
title : Doc title
output: pdf_document
params:
  sword: 'vorpal'
  gallumphto: 'back'
---
```

`rmdmanip` allows a user to load, edit and save the header using simple commands:

## Usage

A file can be loaded through `read.rmd(file)` or `read.rmds(string)`, which provides and `rmdmanip` object. 

```
rmdfile = read.rmd('brillig.Rmd')
```

The header of the file can then be amended using `put(item, value)`

```
rmdfile = rmdfile %>% put('title', 'Beware the Jabberwock')
```

and parameters can be set using `putParam(item, value)`

```
rmdfile = rmdfile %>% putParam('borogroves', 'mimsy')
```

the final result can be extracted using `dump` to write to file, or `dumps` to write to a long string:

```
rmdfile %>% dump('billig.Rmd')
rmdstring = rmdfile %>% dumps()
```


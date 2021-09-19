#Private R6 class for loading and manipulating rmd files

rmdmanip = R6::R6Class(
  "RMDFile",
  public = list(

    initialize = function(rmdString){
      blocks = stringr::str_split(rmdString, '---\n')[[1]]
      if(length(blocks) > 1){
        private$lead = blocks[1]
        private$head = yaml::yaml.load(blocks[2])
        private$body = blocks[3:length(blocks)]
      } else {
        private$lead = ''
        private$head = list(params = list(placeholder = 1))
        private$body = blocks
      }
    },

    getHead = function(){
      private$head
    },

    put = function(rootItem, value){
      private$head[rootItem] = value
      return(self)
    },

    putParam = function(paramName, paramValue){

      if(class(paramValue)=='numeric'| class(paramValue)=='character'){
        private$head$params[paramName] = list(value = paramValue)
      } else {
        private$head$params[paramName] = list(value = list('value' = paramValue))
      }


      return(self)
    },


    build = function(){
      headernew = yaml::as.yaml(private$head)

      # Merge back with original text body
      fileitems = c(private$lead, headernew, private$body)
      fileitems = fileitems[!is.na(fileitems)]
      newfile = paste0(fileitems, collapse='---\n')

    }

  ),

  private = list(
    lead = NA,
    head = NA,
    body = NA
  )

)

#' Reads R markdown file
#' @param file  File path
#' @return rmdmanip object
#' @export
read.rmd = function(file){
  rmdmanip$new(readtext::readtext(file)$text)
}

#' Imports R markdown file from loaded string
#' @param string String representation of R markdown file
#' @return rmdmanip object
#' @export
read.rmds = function(string){
  rmdmanip$new(string)
}

#' Set root-level variable
#' @param rmdob rmdmanip object
#'
#' @param entry_name preamble yaml entry key
#' @param entry_value preamble yaml entry value
#'
#' @return rmdmanip object
#' @export
put = function(rmdob, entry_name, entry_value){
  rmdob$put(entry_name, entry_value)
  return(rmdob)
}

#' Set value in params block of R markdown preamble
#' @param rmdob rmdmanip object
#'
#' @param param_name key of the parameter
#' @param param_value value of the parameter
#'
#' @export
put_param = function(rmdob, param_name, param_value){
  rmdob$putParam(param_name, param_value)
  return(rmdob)
}

#' Set value in params block of R markdown preamble
#' @param rmdob rmdmanip object
#'
#' @param param_name key of the parameter
#' @param param_value value of the parameter
#'
#' @export
put_param_list = function(rmdob, param_list){
  for (key in names(param_list)){
    rmdob$putParam(key, param_list[[key]])
  }
  return(rmdob)
}

#' Write updated R markdown file to disk
#' @param rmdob rmdmanip object
#'
#' @param file Output file name
#'
#' @export
dumpf = function(rmdob, file){
  rmd = rmdob$build()
  lines = stringr::str_split(rmd, '\n')

  fileConn<-file(file)
  for (x in lines){
    writeLines(x, con = fileConn, sep='\n')
  }
  close(fileConn)
}

#' Convert updated R markdown to string
#' @param rmdob rmdmanip object
#'
#' @export
dumps = function(rmdob){
  rmdtext = rmdob$build()
  return(rmdtext)
}


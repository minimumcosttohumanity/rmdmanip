#Private R6 class for loading and manipulating rmd files

rmdmanip = R6::R6Class(
  "RMDFile",
  public = list(

    initialize = function(rmdString){
      blocks = stringr::str_split(rmdString, '---\n')[[1]]
      private$lead = blocks[1]
      private$head = yaml::yaml.load(blocks[2])
      private$body = blocks[3]
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
      newfile = paste0(c(private$lead, headernew, private$body), collapse='---\n')

    }

    write = function(fn){
      lines = stringr::str_split(rmd, '\n')
      fileConn<-file(fn)
      for (x in lines){
        writeLines(x, con = fileConn, sep='\n')
      }
      close(fileConn)
    }

  ),

  private = list(
    lead = NA,
    head = NA,
    body = NA
  )

)

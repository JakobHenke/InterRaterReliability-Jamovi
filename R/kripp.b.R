
# This file is a generated template, your changes will not be overwritten

krippClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "krippClass",
    inherit = krippBase,
    private = list(
        
        .run = function() {
            
            ready <- FALSE
            
            if (!is.null(self$options$vals) && !is.null(self$options$CID) && !is.null(self$options$CaID)){
                
                if(any(is.na(self$data[[self$options$CID]])) || any(is.na(self$data[[self$options$CaID]]))){ ##throw error message if any ID vars contain NAs. This could probably be fixed, but bit tricky.
                    
                    ready <- FALSE
                    message <- paste0("One or more ID variables contain missing values. Reliability could not be calculated.")
                    
                    self$results$krippAlph$setError(message)
                    
                }else{ ## set ready when all options filled and no NAs in ID vars.
                    ready <- TRUE
                }
            }
            
            if (ready) { ## start
                private$.compute()
            }
        },
        
        
        
        .compute = function() {
            
           meth <- as.character(self$options$level) ## prepare note for table
           methstr <- paste("Variable level: ", meth)
            
            
            table <- self$results$krippAlph ## set up table
            table$setNote("Note", methstr) ## add note
            
            
             for (val in self$options$vals) { ## calculate for each var in values
                 
                 rater <- self$options$CID ## short names
                 case <- self$options$CaID
                 value <- val
                 data <- self$data
                 
                 tmpdat <- matrix(nrow = length(unique(data[[case]])), ncol = length(unique(data[[rater]]))) ##set up matrix for reliability analysis with
                                                                                                            ## 1 cell for each unique rater/case combination
                 

                 indimat <- matrix(nrow = length(data[[value]]), ncol = 2) ## set up index matrix
                 
                 indimat[,1] <- data[[case]] ## col 1 are cases
                 indimat[,2] <- data[[rater]] ## col 2 are raters
                 
                 tmpdat[indimat] <- data[[value]] ## assigns values to matrix for reliability estimation.
                 
                 results <- krippendorffsalpha::krippendorffs.alpha(tmpdat, level = meth, confint = FALSE) ## calculate result
                 
           
                table$setRow(rowKey=val, values=list(  
                  Raters = results$coders))
                                
                table$setRow(rowKey=val, values=list(  
                  Cases = results$units))
                                 
                table$setRow(rowKey=val, values=list(  
                  alpha = results$alpha.hat))
                
            }
            

        })
)

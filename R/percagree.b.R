
# This file is a generated template, your changes will not be overwritten

percAgreeClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "percAgreeClass",
    inherit = percAgreeBase,
    private = list(
     
         
         .agreement = function(data){  ## function to calculate percent agreement
           
           if(self$options$omitNA && self$options$naMethod == "listwise"){  ## omit NAs listwise
             data <- na.omit(data)
           }
           
           if(self$options$omitNA && self$options$naMethod == "pairwise"){  ## omit NAs pairwise
             res <- apply(data, 1, function(x) length(unique(na.omit(x))) == 1)
           }else{
             res <- apply(data, 1, function(x) length(unique(x)) == 1) ##check if each row contains only the same element, i.e. if all raters agree
           }

           agree <- length(which(res))/length(res) ##proportion of rows which contain only the same element out of all rows
           
           raters <- dim(data)[2] ## save number of raters to var
           cases <- dim(data)[1] ## save number of cases to var
           
           out <- list(Agreement = agree*100, Raters = raters, Cases = cases) ## prepare list of output
           
           return(out) ## return output
           
         },
         
         
         
         .holsti = function(data){ ## Define function for Holsti coefficient
           
           if(!self$options$omitNA){ ## calculate Holsti if NAs should be kept. This treats NAs as containing information and allows comparisons.
             
             data[is.na(data)] <- sum(data, na.rm = T) ## replace NAs with an arbitrary unique value
             
             similarity.matrix <- apply(data, 2, function(x) colSums(x==data)) ## calculate similarity between coders
             
             n_comparisons <- apply(data, 2, function(x) colSums(!is.na(x==data))) ## total number of comparisons for each coder pair
             
             pairs <- similarity.matrix[upper.tri(similarity.matrix)]/n_comparisons[upper.tri(n_comparisons)] ## agreement between pairs of coders
             
            }
           
           
           if(self$options$omitNA && self$options$naMethod == "listwise"){  ## remove NAs listwise on demand
             data <- na.omit(data)
            }
            
           ## same calculation as above but without replacing NAs. Only difference is "na.rm = T" in apply call for similarity matrix.
          
           similarity.matrix <- apply(data, 2, function(x) colSums(x==data, na.rm = T))  ## calculate similarity matrix of coders. 
                                                                             ## i.e. what is the %-agreement between each pair of coders.
           
           n_comparisons <- apply(data, 2, function(x) colSums(!is.na(x==data))) ## total number of comparisons. denomenator for holsti, 
           
           pairs <- similarity.matrix[upper.tri(similarity.matrix)]/n_comparisons[upper.tri(n_comparisons)] ## agreement between pairs of coders
           
           holsti_cr <- sum(pairs)/length(pairs) ## compute Holsti CR
           
           return(holsti_cr)
           
         },
         
      
      .run = function() {
        
        ready <- FALSE
        
        if (!is.null(self$options$vals) && !is.null(self$options$CID) && !is.null(self$options$CaID)){
          
          if(any(is.na(self$data[[self$options$CID]])) || any(is.na(self$data[[self$options$CaID]]))){ ##throw error message if any ID vars contain NAs. This could probably be fixed, but bit tricky.
            
            ready <- FALSE
            message <- paste0("One or more ID variables contain missing values. Reliability could not be calculated.")
            
            self$results$agree$setError(message)
            
          }else{ ## set ready when all options filled and no NAs in ID vars.
            ready <- TRUE
            }
        }
        
        if (ready) { ## start
          private$.compute()
        }
      },
      

        .compute = function() {

            table <- self$results$agree ##set up reuslts table

            if(self$options$rat){
                table$addColumn(name = "Raters") ##add column for raters on demand
            }
            
            if(self$options$cas){
                table$addColumn(name = "Cases") ##add column for cases on demand
            }
            
            if(self$options$percAgree){
                table$addColumn(name = "Agreement") ##add column for simple %-agreement on demand
            }
            
            if(self$options$hol){
                table$addColumn(name = "Holsti", format = "zto") ##add column for Holsti coefficient on demand
            }

            
            message <- vector(mode = "character") ## set up container for warnings
            
            for (val in self$options$vals) { ##repeat calculation for each variable in values
                
                
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
                                                 ## doing this via the index matrix ensures we can work with messy data! 
                                                 ##e.g. if 1 coder forgot to code 1 item, it'll end up as an NA here
                

                
                if(any(is.na(tmpdat))){
                  
                  message <- paste0(message, "Codings for ", val, " contain ", length(which(is.na(tmpdat))), " missing value(s).",
                                              "\n", "Consider omitting NAs or checking ID variables for incongruencies. \n")
                  
                  self$results$warning$setContent(message)
                }
                
                
                results <- private$.agreement(tmpdat)  ##run agreement function on matrix; must be outside if to get rater/ case numbers
                
                if(self$options$percAgree){
                  
                  table$setRow(rowKey=val, values=list(  ## fill percent agreement column
                    Agreement = paste0(round(results$Agreement, 2), "%")))
                }
                
                
                if(self$options$hol){
                  
                  holsti <- private$.holsti(tmpdat)
                  
                  table$setRow(rowKey=val, values=list(  ## fill holsti column
                    Holsti = holsti))
     
                }
                
                
                if(self$options$rat){
                  table$setRow(rowKey=val, values=list(  ## fill raters column
                    Raters = results$Raters)) 
                }
                
                if(self$options$cas){
                  table$setRow(rowKey=val, values=list(  ## fill cases column
                    Cases = results$Cases))
                }
                
                
  
            }

        })
)

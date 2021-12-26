#' Retrieve the dictionary definition of an English word
#'
#' @name define
#'
#' @usage define(word)
#' @param word The word you wish to define
#'
#' @return A data.frame with as many rows as distinct meanings, and columns for
#'     word, phonetic, phonetics, origin, and meanings
#'
#' @export
#' @import jsonlite
#'
#' @examples
#' \dontrun{
#'   Get the definition of "hello"
#'   define("hello") # Returns a 1 row data.frame
#'
#'   Homonyms (words with >1 meaning)
#'   define("bark") # Returns a 4 row data.frame
#'
#'   # Unknown words will error
#'   define("sdfsdfsdfsdfsdf")
#'
#' }
#'




# Get the definition of a word (English)

define <- function(word) {
  base_url <- "https://api.dictionaryapi.dev/api/v2/entries/en/"
  url <- paste0(base_url, word)
  out <- tryCatch(fromJSON(url), error = function(e) { e } )

  if("error" %in% class(out)) {

    error_message <- paste(out)

    if(grepl("404", error_message)) {
      # A 404 is typically because the word isn't found
      # Technically could be a legitimate 404, but it still
      # means that the word's definition couldn't be provided
      # and so makes little difference to the user of the function
      stop("Sorry, word not found")
    } else {
      # provide any errors other than 404s to expediate debugging
      stop(out)
    }
  }

  # Complete pronunciation URLs

  if(!is.null(out$phonetics)) {

    urls <- out$phonetics[[1]]$audio

    out$phonetics[[1]]$audio <- ifelse(
      is.na(urls),
      NA,
      paste0("https:", urls)
      )
  }

  out
}

















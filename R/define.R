#' Retrieve the dictionary definition of an English word
#'
#' @name define
#'
#' @usage define(word)
#' @param word The word you wish to define
#'
#' @return A tibble with a row for each unique combination of word, meaning,
#'     part of speech, and definition. And a column for:
#'     \itemize{
#'      \item{"original"}{ The original word input. }
#'      \item{"word" }{ The word found in the dictionary (may have alternative
#'      spelling to the original word input). }
#'      \item{"meaning_number"}{ Integer column; each meaning is numbered. }
#'      \item{"part_of_speech"}{ The word's part of speech. }
#'      \item{"phonetic"}{ The pronunciation of the word as expressed in the
#'      \href{https://www.ipachart.com/}{International Phonetic Alphabet}.}
#'      \item{"audio"}{ A link to an mp3 audio file providing the word's
#'      pronunciation. }
#'      \item{"origin"}{ The word's origin. }
#'      \item{"definition"}{ The word's definition. }
#'      \item{"example"}{ An example of the word's usage. }
#'      \item{"synonyms"}{ A list of synonyms, if available. }
#'      \item{"antonyms"}{ A list of antonyms, if available. }
#'     }
#'
#' @export
#' @import jsonlite tibble
#'
#' @examples
#' \dontrun{
#'   # Get the definition of "hello"
#'   define("hello") # Returns a 3 row data.frame
#'
#'   # Homonyms (words with >1 meaning)
#'   define("bark") # Returns a 9 row data.frame
#'
#'   # Unknown words will return a 0 row data.frame and message
#'   define("sdfsdfsdfsdfsdf")
#'   # No definition found for sdfsdfsdfsdfsdf
#'
#' }
#'




# Get the definition of a word (English)

define <- function(word) {

  make_df <- function(nrow) {
    if (missing(nrow)) {
      nrow <- 0
    }

    temp_df <- data.frame(
      original = character(),
      word = character(),
      meaning_number = integer(),
      part_of_speech = character(),
      phonetic = character(),
      audio = character(),
      origin = character(),
      definition = character(),
      example = character(),
      synonyms = structure(list(), class = "AsIs"),
      antonyms = structure(list(), class = "AsIs"),
      stringsAsFactors = FALSE
    )

    if (nrow > 0) {
      temp_df[1:nrow, ] <- NA
    }

    temp_df
  }


  base_url <- "https://api.dictionaryapi.dev/api/v2/entries/en/"
  url <- paste0(base_url, word)
  api_response <- tryCatch(fromJSON(url), error = function(e) { e } )

    if("error" %in% class(api_response)) {

    error_message <- paste(api_response)

    if(grepl("404", error_message)) {
      # A 404 is typically because the word isn't found
      # Technically could be a legitimate 404
      final_df <- make_df()
      message(paste0("No definition found for ", word))
      final_df <- as_tibble(final_df)
      return(final_df)
    } else {
      # provide any errors other than 404s to expediate debugging
      stop(api_response)
    }
  }




  # Make data 'tidy'
  # word, meaning_group (1, 2, 3, etc), part_of_speech, phonetic, audio, origin, definition, examples, synonyms, antonyms

  final_df <- make_df()

  # We will have as many output rows as we have combinations of
  # i) meanings
  # ii) part of speech
  # iii) definitions per meaning and part of speech combo
  # EXAMPLE
  # The first of four meanings of 'bark' consists of 2 parts of speech
  # (houn and verb), and the first meaning has one definition, whereas the
  # second has 2 meanings, totaling 3 output rows for that first meaning
  # of 'bark'

  # in api_response, each row is a 'meaning'
  for(i in 1:nrow(api_response)){
    row <- api_response[i, ]

    # Assumes as many rows as sum of definitions across all parts of speech
    # for a single meaning

    num_rows_mini <- sum(sapply(row$meanings[[1]]$definitions, function(x) { nrow(x) }))

    mini_df <- make_df(num_rows_mini)


    # The word returned from the dictionary could be an alternate spelling
    # Hence we store and return both the original input and the word found in
    # the dictionary when looking up the original
    mini_df$original <- rep(word, num_rows_mini)

    # # word, meaning_group (1, 2, 3, etc), part_of_speech, phonetic, audio, origin, definition, examples, synonyms, antonyms
    mini_df$word <- rep(row$word, num_rows_mini)
    mini_df$meaning_number <- rep(i, num_rows_mini)

    mini_df$phonetic <- rep(row$phonetic, num_rows_mini)

    # NOTE: this takes the first item of audio, there may be times when more than one is returned (I haven't seen any cases yet)
    mini_df$audio <- if(is.null(row$phonetics[[1]]$audio[1])) { NA } else { row$phonetics[[1]]$audio[1] }
    mini_df$origin <- rep(row$origin, num_rows_mini)

    # The more tricky ones..

    definitions_per_meaning <- sapply(row$meanings[[1]]$definitions, function(x) {nrow(x)})

    mini_df$part_of_speech <- rep(row$meanings[[1]]$partOfSpeech, definitions_per_meaning)


    mini_df$definition <-  c(unlist(sapply(row$meanings[[1]]$definitions, function(x) {x$definition}))) # c(sapply(row$meanings[[1]]$definitions, function(x) {x$definition}))



    # EXAMPLE column
    # Lots of pain here for a few reasons regarding lists, vectors and NULL
    # But TL;DR we want to loop through and perform some checks, generate some
    # missing values, swap out NULL for NA, and ensure it comes together
    # properly in the main data.frame

    for(meaning_part_of_speech_combo in 1:length(row$meanings[[1]]$definitions)) {

      # Examples col can be missing altogether
      # and I presume any example value can also be NULL

      # If example col doesn't exist, create it
      if(is.null(row$meanings[[1]]$definitions[meaning_part_of_speech_combo][[1]]$example)){
        row$meanings[[1]]$definitions[meaning_part_of_speech_combo][[1]]$example <- NA
      }

      # Since example column is not a column of lists, and since a vector
      # Cannot contain NULL, we know it cannot contain any NULLs
      # So the above should be enough to handle for the example column

    }

    mini_df$example <- c(unlist(sapply(row$meanings[[1]]$definitions, function(x) {x$example})))




    # SYNONYMS and ANTONYMS columns
    # Since lists can contain NULL, and synonyms and antonyms cols are cols
    # of lists, we can rely on those columns being there
    # Hence, we just need to sweep through and convert any individual
    # NULLs into NA

    synonyms_list_of_vectors <- unlist(lapply(row$meanings[[1]]$definitions, function(x) { x$synonyms }), recursive = FALSE)
    antonyms_list_of_vectors <- unlist(lapply(row$meanings[[1]]$definitions, function(x) { x$antonyms }), recursive = FALSE)

    # This changes a list of empty 'list()' items into a list of lists containing NA
    synonyms <- lapply(synonyms_list_of_vectors, function(x) {if(length(x) == 0){ as.character(c(NA)) } else {x}})
    antonyms <- lapply(antonyms_list_of_vectors, function(x) {if(length(x) == 0){ as.character(c(NA)) } else {x}})


    # Now place the list of lists into the data.frame column for synonyms and antonyms respectively

    mini_df$synonyms <- I(synonyms)
    mini_df$antonyms <- I(antonyms)
    # I() keeps the data 'As.is' (i.e. forces it to stay as a list)
    # See here: https://stackoverflow.com/a/9547594/5783745
    # Example:
    # data.frame(a=1:3,b=I(list(1,1:2,1:3)))



    final_df <- rbind(final_df, mini_df)

  }

  # Complete pronunciation URLs

  final_df$audio <- ifelse(
    is.na(final_df$audio),
    NA,
    paste0("https:", final_df$audio)
    )

  final_df <- as_tibble(final_df)
  final_df
}

















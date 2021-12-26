
# dictionary <a href='https://github.com/stevecondylios/dictionary'></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/dictionary)](https://cran.r-project.org/package=dictionary)
<!-- badges: end -->

`dictionary` gives the ability to get the dictionary definition,
phonetics, and origin of English words.

### Installation

Installation via CRAN `install.packages("dictionary")`

``` r
install.packages("dictionary")
```

### Usage

Load library

``` r
library(dictionary)
```

Get dictionary definition of “hello”, view its **definition(s)** and
**part(s) of speech**:

``` r
word <- "hello"
word_info <- define(word)

word_info$meanings
```

    ## [[1]]
    ##   partOfSpeech
    ## 1  exclamation
    ## 2         noun
    ## 3         verb
    ##                                                                                definitions
    ## 1                used as a greeting or to begin a phone conversation., hello there, Katie!
    ## 2 an utterance of ‘hello’; a greeting., she was getting polite nods and hellos from people
    ## 3                            say or shout ‘hello’., I pressed the phone button and helloed

View a word’s **phonetic**:

``` r
word_info$phonetic
```

    ## [1] "həˈləʊ"

Hear a word’s **pronunciation**:

``` r
word_info$phonetics[[1]]$audio[1]
```

    ## [1] "https://ssl.gstatic.com/dictionary/static/sounds/20200429/hello--_gb_1.mp3"

To hear the word pronounced out loud, visit the provided url(s):
<https://ssl.gstatic.com/dictionary/static/sounds/20200429/hello--_gb_1.mp3>

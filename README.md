
# dictionaRy <img src="man/figures/dark-logo.png" align="right" height="139" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/dictionaRy)](https://cran.r-project.org/package=dictionaRy)
<!-- badges: end -->

`dictionary` gives the ability to get the dictionary definition,
phonetics, and origin of English words.

<a href='https://github.com/stevecondylios/dictionaRy'></a>

### Installation

Installation via GitHub
`devtools::install_github("stevecondylios/dictionaRy")`

``` r
# install.packages("devtools")
devtools::install_github("stevecondylios/dictionaRy")
```

Future: Installation via CRAN `install.packages("dictionaRy")`

``` r
install.packages("dictionaRy")
```

## Usage

Load library

``` r
library(dictionaRy)
```

### Definitions

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

### Phonetics

View a word’s **phonetic** with:

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

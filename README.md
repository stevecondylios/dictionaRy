
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

Get dictionary definition of “hello”

``` r
library(dictionary)
hello <- define("hello")
```

View a word’s **part(s) of speech** and **definition(s)**:

``` r
hello$meanings
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
hello$phonetic
```

    ## [1] "həˈləʊ"

Hear a word’s **pronunciation**:

``` r
hello$phonetics
```

    ## [[1]]
    ##     text
    ## 1 həˈləʊ
    ## 2 hɛˈləʊ
    ##                                                                        audio
    ## 1 https://ssl.gstatic.com/dictionary/static/sounds/20200429/hello--_gb_1.mp3
    ## 2                                                                       <NA>

To hear the word pronounced out loud, visit the provided url(s):
<https://ssl.gstatic.com/dictionary/static/sounds/20200429/hello--_gb_1.mp3>

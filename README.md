
# <a href='https://github.com/stevecondylios/dictionaRy'>dictionaRy <img src="man/figures/light-logo.png" align="right" height="139" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/dictionaRy)](https://cran.r-project.org/package=dictionaRy)
<!-- badges: end -->

Retrieve the dictionary definition of an English word, along with its
phonetics, origins, examples, synonyms, and antonyms.

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

Get definition of “hello”:

``` r
word <- "hello"
as_tibble(define(word))
```

    ## # A tibble: 3 x 10
    ##   word  meaning_number part_of_speech phonetic audio  origin  definition example
    ##   <chr>          <int> <chr>          <chr>    <chr>  <chr>   <chr>      <chr>  
    ## 1 hello              1 exclamation    həˈləʊ   https… early … used as a… hello …
    ## 2 hello              1 noun           həˈləʊ   https… early … an uttera… she wa…
    ## 3 hello              1 verb           həˈləʊ   https… early … say or sh… I pres…
    ## # … with 2 more variables: synomyms <I<lgl>>, antonyms <I<lgl>>

### On the relationship between word meanings, parts of speech, and definitions

-   A **word** that is found in the English dictionary may have one or
    more meanings
    -   each meaning can have one or more **parts of speech**.
    -   each combination of meaning and part of speech will have one or
        more definitions.

For example, the word *bark* has 4 meanings. Let’s take the firs
meaning: a dog’s bark. This meaning has 2 parts of speech (*noun* and
*verb*). The noun has 1 definition
`the sharp explosive cry of a dog, fox, or seal`.  
The verb has 2 definitions `(of a dog, fox, or seal) give a bark` and
`utter (a command or question) abruptly or aggressively`. So we have a
total of 3 definitions just for the first of four meanings of ‘bark’
(and more for the second, third, and fourth). Language is complicated :)

-   If a word cannot be found in the English dictionary a 0-row
    data.frame will be rturned, and message to that effect printed to
    the console (e.g.  `define("sdlkfjsldkjf")`).

### Bug reports, suggestions, pull requests

-   Please reports bugs on the
    [issues](https://github.com/stevecondylios/dictionaRy/issues) page.
-   Please make suggestions on the
    [issues](https://github.com/stevecondylios/dictionaRy/issues) page.
-   Please open an issue before making a pull request, unless it’s for a
    typo.
-   Thank you!

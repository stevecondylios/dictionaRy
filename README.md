
# dictionaRy <a href='https://github.com/stevecondylios/dictionaRy'><img src="man/figures/light-logo.png" align="right" height="139" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/dictionaRy)](https://cran.r-project.org/package=dictionaRy)
<!-- badges: end -->

Retrieve the dictionary definition of English words in tidy format,
along with their phonetics, audio pronunciation, parts of speech,
origins, examples, synonyms, and antonyms.

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
library(tidyverse)
```

Get information for the word “hello”:

``` r
word <- "hello"
(word_info <- define(word))
```

    ## # A tibble: 3 x 10
    ##   word  meaning_number part_of_speech phonetic audio  origin  definition example
    ##   <chr>          <int> <chr>          <chr>    <chr>  <chr>   <chr>      <chr>  
    ## 1 hello              1 exclamation    həˈləʊ   https… early … used as a… hello …
    ## 2 hello              1 noun           həˈləʊ   https… early … an uttera… she wa…
    ## 3 hello              1 verb           həˈləʊ   https… early … say or sh… I pres…
    ## # … with 2 more variables: synonyms <I<list>>, antonyms <I<list>>

### Definitions and parts of speech

``` r
word_info %>% 
  select(part_of_speech, definition)
```

    ## # A tibble: 3 x 2
    ##   part_of_speech definition                                          
    ##   <chr>          <chr>                                               
    ## 1 exclamation    used as a greeting or to begin a phone conversation.
    ## 2 noun           an utterance of ‘hello’; a greeting.                
    ## 3 verb           say or shout ‘hello’.

### Word origins

``` r
word_info %>% 
  select(origin)
```

    ## # A tibble: 3 x 1
    ##   origin                                                          
    ##   <chr>                                                           
    ## 1 early 19th century: variant of earlier hollo ; related to holla.
    ## 2 early 19th century: variant of earlier hollo ; related to holla.
    ## 3 early 19th century: variant of earlier hollo ; related to holla.

### Example word usage

``` r
word_info %>% 
  select(example)
```

    ## # A tibble: 3 x 1
    ##   example                                           
    ##   <chr>                                             
    ## 1 hello there, Katie!                               
    ## 2 she was getting polite nods and hellos from people
    ## 3 I pressed the phone button and helloed

### Phonetics

``` r
word_info %>% 
  select(phonetic)
```

    ## # A tibble: 3 x 1
    ##   phonetic
    ##   <chr>   
    ## 1 həˈləʊ  
    ## 2 həˈləʊ  
    ## 3 həˈləʊ

### Audio pronunciation

Visit the urls to hear the word spoken.

``` r
word_info %>% 
  select(audio)
```

    ## # A tibble: 3 x 1
    ##   audio                                                                     
    ##   <chr>                                                                     
    ## 1 https://ssl.gstatic.com/dictionary/static/sounds/20200429/hello--_gb_1.mp3
    ## 2 https://ssl.gstatic.com/dictionary/static/sounds/20200429/hello--_gb_1.mp3
    ## 3 https://ssl.gstatic.com/dictionary/static/sounds/20200429/hello--_gb_1.mp3

<hr>

### Technical details on the relationship between word meanings, parts of speech, and definitions

-   A **word** that is found in the English dictionary may have one or
    more **meaning**s

    -   each **meaning** can have one or more **parts of speech**.
    -   each combination of **meaning** and **part of speech** will have
        one or more **definitions**.

-   Example: the word *bark* has 4 meanings. Take the first meaning: a
    dog’s bark. This meaning has 2 parts of speech (*noun* and *verb*).
    The noun has 1 definition
    `the sharp explosive cry of a dog, fox, or seal`.  
    The verb has 2 definitions `(of a dog, fox, or seal) give a bark`
    and `utter (a command or question) abruptly or aggressively`. So we
    have a total of 3 definitions just for the first of four meanings of
    ‘bark’ (and more for the second, third, and fourth).

-   If a word cannot be found in the English dictionary a 0-row
    data.frame will be rturned, and message to that effect printed to
    the console (e.g.  `define("sdlkfjsldkjf")`).

<hr>

### More examples

“hello”

``` r
define("hello")
```

    ## # A tibble: 3 x 10
    ##   word  meaning_number part_of_speech phonetic audio  origin  definition example
    ##   <chr>          <int> <chr>          <chr>    <chr>  <chr>   <chr>      <chr>  
    ## 1 hello              1 exclamation    həˈləʊ   https… early … used as a… hello …
    ## 2 hello              1 noun           həˈləʊ   https… early … an uttera… she wa…
    ## 3 hello              1 verb           həˈləʊ   https… early … say or sh… I pres…
    ## # … with 2 more variables: synonyms <I<list>>, antonyms <I<list>>

“bark”

``` r
define("bark")
```

    ## # A tibble: 9 x 10
    ##   word   meaning_number part_of_speech phonetic audio  origin definition example
    ##   <chr>           <int> <chr>          <chr>    <chr>  <chr>  <chr>      <chr>  
    ## 1 bark                1 noun           bɑːk     https… Old E… the sharp… <NA>   
    ## 2 bark                1 verb           bɑːk     https… Old E… (of a dog… a dog …
    ## 3 bark                1 verb           bɑːk     https… Old E… utter (a … he beg…
    ## 4 bark                2 noun           bɑːk     https… Middl… the tough… beaver…
    ## 5 bark                2 noun           bɑːk     https… Middl… thin shee… white …
    ## 6 bark                2 verb           bɑːk     https… Middl… strip the… they h…
    ## 7 bark                2 verb           bɑːk     https… Middl… tan or dy… <NA>   
    ## 8 bark                3 noun           bɑːk     https… late … a ship or… <NA>   
    ## 9 barque              4 noun           bɑːk     https… Middl… a sailing… <NA>   
    ## # … with 2 more variables: synonyms <I<list>>, antonyms <I<list>>

“set” (..is said to have more meanings than any other English word!)

``` r
define("set")
```

    ## # A tibble: 25 x 10
    ##    word  meaning_number part_of_speech phonetic audio  origin definition example
    ##    <chr>          <int> <chr>          <chr>    <chr>  <chr>  <chr>      <chr>  
    ##  1 set                1 verb           sɛt      https… Old E… put, lay,… Delane…
    ##  2 set                1 verb           sɛt      https… Old E… put or br… the Ho…
    ##  3 set                1 verb           sɛt      https… Old E… adjust (a… set yo…
    ##  4 set                1 verb           sɛt      https… Old E… harden in… cook f…
    ##  5 set                1 verb           sɛt      https… Old E… (of the s… the su…
    ##  6 set                1 verb           sɛt      https… Old E… (of a tid… a fair…
    ##  7 set                1 verb           sɛt      https… Old E… start (a … the sc…
    ##  8 set                1 verb           sɛt      https… Old E… (of bloss… wait u…
    ##  9 set                1 verb           sɛt      https… Old E… sit.       the re…
    ## 10 set                2 noun           sɛt      https… late … a group o… a set …
    ## # … with 15 more rows, and 2 more variables: synonyms <I<list>>,
    ## #   antonyms <I<list>>

“lead” is an example of a
[heteronym](https://en.wikipedia.org/wiki/Heteronym_(linguistics)) (a
word that has a different pronunciation and meaning from another word
but the same spelling)

``` r
define("lead") %>% 
  group_by(meaning_number) %>% 
  slice(1)
```

    ## # A tibble: 2 x 10
    ## # Groups:   meaning_number [2]
    ##   word  meaning_number part_of_speech phonetic audio  origin  definition example
    ##   <chr>          <int> <chr>          <chr>    <chr>  <chr>   <chr>      <chr>  
    ## 1 lead               1 verb           liːd     https… Old En… cause (a … she em…
    ## 2 lead               2 noun           lɛd      https… Old En… a soft, h… <NA>   
    ## # … with 2 more variables: synonyms <I<list>>, antonyms <I<list>>

Visit the audio links for the first and second meanings of “lead”:

1.  <https://ssl.gstatic.com/dictionary/static/sounds/20200429/lead--_gb_1.mp3>
2.  <https://ssl.gstatic.com/dictionary/static/sounds/20200429/lead--_gb_2.mp3>

### Advanced usage

Iterate over many words

``` r
words <- c("hello", "bark", "set", "lead")

map_df(words, ~ define(.x))
```

    ## # A tibble: 53 x 10
    ##    word  meaning_number part_of_speech phonetic audio  origin definition example
    ##    <chr>          <int> <chr>          <chr>    <chr>  <chr>  <chr>      <chr>  
    ##  1 hello              1 exclamation    həˈləʊ   https… early… used as a… hello …
    ##  2 hello              1 noun           həˈləʊ   https… early… an uttera… she wa…
    ##  3 hello              1 verb           həˈləʊ   https… early… say or sh… I pres…
    ##  4 bark               1 noun           bɑːk     https… Old E… the sharp… <NA>   
    ##  5 bark               1 verb           bɑːk     https… Old E… (of a dog… a dog …
    ##  6 bark               1 verb           bɑːk     https… Old E… utter (a … he beg…
    ##  7 bark               2 noun           bɑːk     https… Middl… the tough… beaver…
    ##  8 bark               2 noun           bɑːk     https… Middl… thin shee… white …
    ##  9 bark               2 verb           bɑːk     https… Middl… strip the… they h…
    ## 10 bark               2 verb           bɑːk     https… Middl… tan or dy… <NA>   
    ## # … with 43 more rows, and 2 more variables: synonyms <I<list>>,
    ## #   antonyms <I<list>>

Note that words which aren’t found in the English dictionary will return
0 row data.frames, and hence will have no affect on the resulting
data.frame

``` r
words <- c("hi", "sldkfjlsdjkf")

map_df(words, ~ define(.x))
```

    ## No definition found for sldkfjlsdjkf

    ## # A tibble: 2 x 10
    ##   word  meaning_number part_of_speech phonetic audio  origin  definition example
    ##   <chr>          <int> <chr>          <chr>    <chr>  <chr>   <chr>      <chr>  
    ## 1 hi                 1 exclamation    hʌɪ      https… natura… used as a… ‘Hi th…
    ## 2 HI                 2 abbreviation   <NA>     <NA>   <NA>    Hawaii (i… <NA>   
    ## # … with 2 more variables: synonyms <I<list>>, antonyms <I<list>>

### Bug reports, suggestions, pull requests

-   Please reports bugs on the
    [issues](https://github.com/stevecondylios/dictionaRy/issues) page.
-   Please make suggestions on the
    [issues](https://github.com/stevecondylios/dictionaRy/issues) page.
-   Please open an issue before making a pull request, unless it’s for a
    typo.
-   Thank you!

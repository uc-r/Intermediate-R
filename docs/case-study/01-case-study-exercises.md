Day 1 Case Study Exercises
================

## Prerequisites

Download this folder and save it as “Intermediate-R-Case-Study-Day-1” (I
know, I couldn’t think of a longer name). This folder will contain a
“data” subfolder that contains all the data required for this case
study and a .Rmd file with the exercises.

## Exercise 1

Create a self-contained R Project for this case study. When creating the
R Project, you should choose the option to create in an “Existing
Directory”.

## Exercise 2

Open the R notebook saved as “01-case-study.Rmd”. An R notebook
functions very similarly to an R Markdown file. In fact, you will see
two files in the directory, a 01-case-study.Rmd file and a
01-case-study.nb.html file. Be sure to open the .Rmd file.

After you’ve opened the .Rmd file, go ahead and click the “Preview”
button at the top of the RStudio window (next to the round settings
wheel where the knit button used to be). As you edit this document,
rather than pressing the knit but, you can just hit save and your
preview file will be automatically updated. As you add a code chunk, run
the code chunk and hit save and you will see the results instantly
updated in your preview.

## Exercise 3

Change the author of the .Rmd file to your name and add today’s date.

## Exercise 4

Run the following code chunk. This will automatically import all the
data files and convert to a single data frame titled `df`. Don’t worry
if you don’t understand all the code, we’ll discuss this more tomorrow.

``` r
# create empty data frame
df <- data.frame(NULL)

# import all data files into one data frame titled "df"
for(i in 1:11) {
  file_name <- paste0("../data/Month-", stringr::str_pad(i, 2, pad = "0"), ".csv")
  df_import <- readr::read_csv(file_name, progress = FALSE)
  df <- rbind(df, df_import)
  rm(df_import, file_name)
}

glimpse(df)
```

## Exercise 5

The “Factor\_D” variable contains 15 unique values (i.e. 10, 15, 20, 21,
…, 85, 90). There is at least one single observation where `Factor_D
= 26` (possibly more). Assume these observations were improperly
recorded and, in fact, the value should be 25.

Using `ifelse()` (or **dplyr**’s `if_else()`) inside `mutate()`, recode
any values where `Factor_D == 26` to be 25.

``` r
# unique values of Factor D before being re-coded
sort(unique(df$Factor_D))

# recode Factor D
df <- df %>%
  mutate(Factor_D = if_else(_____ == _____, _____, _____))

# unique values of Factor D after being re-coded
sort(unique(df$Factor_D))
```

## Exercise 6

Unfortunately, some of the “Factor\_” variables have observations that
contain the value “NULL” (they are recorded as a character string, not
the actual `NULL` value.  
Use `filter_at()` to filter out any of these observations. Your
resulting data frame should have 489,537 rows after
filtering.

``` r
# filter out any observations where the "Factor_" variables contain "NULL"
df <- df %>%
  filter_at(_____, _____)

# your resulting data frame should have 489,537 rows.
nrow(df)
```

## Exercise 7

Using `mutate_at()` , convert all variables except for
“Transaction\_Timestamp” to factors. However, make sure the “Month”
variable is an ordered factor. This may require you to do two seperate
`mutate()` statements.

``` r
df <- df %>%
  mutate_at(_____, _____) %>%
  mutate(Month = factor(_____, levels = _____))

# make sure all features are changed to factors
glimpse(df)

# make sure the Month variable is an ordered factor
levels(df$Month)
```

## Exercise 8

Excluding “Transaction\_Timestamp”, how many unique values are there for
all the other variables in our data set? Hint: use `n_distinct()` inside
`summarize_if()`

``` r
df %>% summarize_if(_____, _____)
```

If you group by “Transaction\_Status”, are there approximately equal
distributions of unique values across all the variables?

``` r
df %>%
  group_by(_____) %>%
  summarize_if(_____, _____)
```

## Exercise 9

Fill in the blanks for `case_when()` so that you create a new variable
named “Quarter” where:

  - When Month is Jan-Mar, Quarter = “Q1”
  - When Month is Apr-Jun, Quarter = “Q2”
  - When Month is Jul-Sep, Quarter = “Q3”
  - When Month is Oct-Dec, Quarter = “Q4”

You should have 85,588 obs in Q1, 100,227 in Q2, 161,071 in Q3, and
142,651 in Q4.

``` r
# Use mutate and case_when to create new Quarter variable
df <- df %>%
  mutate(Quarter = case_when(
    _____ ~ "Q1",
    _____ ~ "Q2",
    _____ ~ "Q3",
    _____ ~ "Q4"
  ))

# assess how many observations you have in each quarter
table(df$Quarter)
```

## Exercise 10

Open up the “01-case-study-presentation.Rpres” file, click the “Preview”
button, and compare your results to mine. In many cases, you could’ve
gotten the same results by using a different method. This is fine but
you should look to see where you code could’ve been more efficient (or
maybe you did it more efficiently than me and if so, please share\!).

Also, take some time to see how the code to create the R presentation
works. This is also built on top of R Markdown and the primary
difference is how you use “========” to separate slides and the slide
title precedes “========”.

Day 1 Case Study
========================================================
author: "Brad Boehmke"
date: "2019-01-31"
autosize: true



Prerequisites
========================================================

Download this folder and save it as "Intermediate-R-Case-Study-Day-1" (I know, 
I couldn't think of a longer name).  This folder will contain a "data" subfolder
that contains all the data required for this case study and a .Rmd file with
the exercises.

Exercise 1
========================================================

Create a self-contained R Project for this case study.  When creating the R 
Project, you should choose the option to create in an "Existing Directory".

## Solution

1. File,
2. New Project,
3. Existing Directory,
4. select folder you just downloaded,
5. Click "Create Project".

Exercise 2
========================================================

Open the R notebook saved as "01-case-study.Rmd".  An R notebook functions very 
similarly to an R Markdown file. In fact, you will see two files in the directory,
a 01-case-study.Rmd file and a 01-case-study.nb.html file.  Be sure to open the
.Rmd file.  

After you've opened the .Rmd file, go ahead and click the "Preview" button at the 
top of the RStudio window (next to the round settings wheel where the knit button 
used to be).  As you edit this document, rather than pressing the knit but, you 
can just hit save and your preview file will be automatically updated.  As you 
add a code chunk, run the code chunk and hit save and you will see the results 
instantly updated in your preview.

Exercise 3
========================================================

Change the author of the .Rmd file to your name and add today's date.

## Solution

```r
---
title: "Day 1 Case Study"
author: "Your name here"
date: "2019-01-31"
output: html_notebook
---
```

Exercise 4
========================================================

Run the following code chunk.  This will automatically import all the data files
and convert to a single data frame titled `df`.  Don't worry if you don't understand 
all the code, we'll discuss this more tomorrow.


## Solution

Run by pressing the green "play" button at the top right hand side of the code chunk



```r
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
Observations: 698,159
Variables: 10
$ Account_ID            <int> 5, 16, 28, 40, 62, 64, 69, 69, 70, 79, 88,…
$ Transaction_Timestamp <dttm> 2009-01-08 00:16:41, 2009-01-20 22:40:08,…
$ Factor_A              <int> 2, 2, 2, 2, 2, 7, 2, 2, 2, 7, 8, 10, 10, 2…
$ Factor_B              <int> 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 18, 6, 6, 6,…
$ Factor_C              <chr> "VI", "VI", "VI", "VI", "VI", "MC", "VI", …
$ Factor_D              <int> 20, 20, 21, 20, 20, 20, 20, 20, 20, 20, 20…
$ Factor_E              <chr> "A", "H", "NULL", "H", "B", "NULL", "H", "…
$ Response              <int> 1020, 1020, 1020, 1020, 1020, 1020, 1020, …
$ Transaction_Status    <chr> "Approved", "Approved", "Approved", "Appro…
$ Month                 <chr> "Jan", "Jan", "Jan", "Jan", "Jan", "Jan", …
```

Exercise 5
========================================================

The "Factor_D" variable contains 15 unique values (i.e. 10, 15, 20, 21, ..., 85, 90).  There is at least one single observation where `Factor_D = 26` (possibly more).  Assume these observations were improperly recorded and, in fact, the value should be 25.  

Using `ifelse()` (or __dplyr__'s `if_else()`) inside `mutate()`, recode any values where `Factor_D == 26` to be 25.

## Solution


```r
# unique values of Factor D before being re-coded
sort(unique(df$Factor_D))
 [1] 10 15 20 21 25 26 30 31 35 40 50 55 70 85 90

# recode Factor D
df <- df %>%
  mutate(Factor_D = if_else(Factor_D == 26L, 25L, Factor_D))

# unique values of Factor D after being re-coded
sort(unique(df$Factor_D))
 [1] 10 15 20 21 25 30 31 35 40 50 55 70 85 90
```

Exercise 6
========================================================

Unfortunately, some of the "Factor_" variables have observations that contain the 
value "NULL" (they are recorded as a character string, not the actual `NULL` value.  
Use `filter_at()` to filter out any of these observations. Your resulting data frame 
should have 489,537 rows after filtering.

## Solution


```r
# filter out any observations where the "Factor_" variables contain "NULL"
df <- df %>%
  filter_at(vars(contains("Factor")), all_vars(. != "NULL"))

# your resulting data frame should have 489,537 rows.
nrow(df)
[1] 489537
```

Exercise 7
========================================================

Using `mutate_at()` , convert all variables except for "Transaction_Timestamp"
to factors.  However, make sure the "Month" variable is an ordered factor. 

## Solution


```r
df <- df %>%
  mutate_at(
    vars(-matches("Timestamp|Month")),
    as.factor        
    ) %>%
  mutate(Month = factor(Month, levels = month.abb))

# make sure the Month variable is an ordered factor
levels(df$Month)
 [1] "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov"
[12] "Dec"

# make sure all features are changed to factors
glimpse(df)
Observations: 489,537
Variables: 10
$ Account_ID            <fct> 5, 16, 40, 62, 69, 69, 70, 95, 101, 101, 1…
$ Transaction_Timestamp <dttm> 2009-01-08 00:16:41, 2009-01-20 22:40:08,…
$ Factor_A              <fct> 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, …
$ Factor_B              <fct> 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, …
$ Factor_C              <fct> VI, VI, VI, VI, VI, VI, VI, VI, VI, VI, VI…
$ Factor_D              <fct> 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20…
$ Factor_E              <fct> A, H, H, B, H, H, B, G, G2, G2, A, A, C, A…
$ Response              <fct> 1020, 1020, 1020, 1020, 1020, 1020, 1020, …
$ Transaction_Status    <fct> Approved, Approved, Approved, Approved, Ap…
$ Month                 <fct> Jan, Jan, Jan, Jan, Jan, Jan, Jan, Jan, Ja…
```

Exercise 8
========================================================

Excluding "Transaction_Timestamp", how many unique values are there for all the
other variables in our data set?  Hint: use `summarize_if()`

## Solution


```r
df %>%
  summarize_if(is.factor, n_distinct)
# A tibble: 1 x 9
  Account_ID Factor_A Factor_B Factor_C Factor_D Factor_E Response
       <int>    <int>    <int>    <int>    <int>    <int>    <int>
1     324174        2        3        2       12       62       30
# … with 2 more variables: Transaction_Status <int>, Month <int>
```

Exercise 8 continued
========================================================

If you group by "Transaction_Status", are there approximately equal distributions
of unique values across all the variables?

## Solution


```r
df %>%
  group_by(Transaction_Status) %>%
  summarize_if(is.factor, n_distinct)
# A tibble: 2 x 9
  Transaction_Sta… Account_ID Factor_A Factor_B Factor_C Factor_D Factor_E
  <fct>                 <int>    <int>    <int>    <int>    <int>    <int>
1 Approved             316172        2        3        2       11       59
2 Declined              14066        2        3        2       11       57
# … with 2 more variables: Response <int>, Month <int>
```

Exercise 9
========================================================

Fill in the blanks for `case_when()` so that you create a new variable named
"Quarter" where:

- When Month is Jan-Mar, Quarter = "Q1"
- When Month is Apr-Jun, Quarter = "Q2"
- When Month is Jul-Sep, Quarter = "Q3"
- When Month is Oct-Dec, Quarter = "Q4"

## Solution


```r
# Use mutate and case_when to create new Quarter variable
df <- df %>%
  mutate(Quarter = case_when(
    as.numeric(Month) <= 3 ~ "Q1",
    as.numeric(Month) <= 6 ~ "Q2",
    as.numeric(Month) <= 9 ~ "Q3",
    TRUE                   ~ "Q4"
  ))

# You should have 85588 obs in Q1, 100227 in Q2, 161071 in Q3, and 142651 in Q4.
table(df$Quarter)

    Q1     Q2     Q3     Q4 
 85588 100227 161071 142651 
```

Exercise 10
========================================================

Open up the "01-case-study-presentation.Rpres" file, click the "Preview" button, 
and compare your results to mine.  In many cases, you could've gotten the same 
results by using a different method.  This is fine but you should look to see 
where you code could've been more efficient (or maybe you did it more efficiently 
than me and if so, please share!).

Also, take some time to see how the code to create the R presentation works. This
is also built on top of R Markdown and the primary difference is how you use
"========" to separate slides and the slide title precedes "========".

## Solution

If you've gotten this far in the presentation then you've completed this exercise!

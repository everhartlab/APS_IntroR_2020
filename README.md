# IntroR_Workshop
<!--
---
title: "R for Plant Pathologists"
---
-->


An introduction to R for plant pathologists written by Dr. Sydney E. Everhart, Nikita Gambhir, Dr. Lucky Mehra, and Dr. Zhian N. Kamvar.

This repository is intended to serve as an additional resource for short 
workshops given at Univeristy of Nebraska and the American Phytopathological Society (APS) meetings. The source code can be found at https://github.com/everhartlab/IntroR_2019.

## About 

This introduction to R is designed to be a companion to a workshop lasting 4 
hours introducing plant pathologists to the basics of R by using field data example. 

## Goals

As a result of taking this workshop you should be able to:

 - find, download, and load necessary packages for analysis
 - load tabular data into R
 - understand the basics of data manipulation in R
 - know what a data frame, vector, and function are
 - summarize data
 - visualize data
 - troubleshoot commmon problems


## Website

This website is meant to serve as a companion to the workshop. The pages located
in the **Workshop** tab are rendered versions of R scripts located in the top 
level of https://github.com/everhartlab/IntroR_2019. As the workshop is designed to
be interactive where the participants are given some control over what direction
we should take the analyses, the scripts here are only to serve as guidelines.

These scripts follow these conventions:

 - R code is presented how it would appear in the R console with the first line
   prefixed with `>` and subsequent lines prefixed with `+`. The intent is to
   encourage the user to type the commands instead of copy and paste.
 - There will be instances where we will have exercise questions. These are
   points in the workshop where we stop the participants and ask them to 
   figure out the working of a function or find a suitable function to answer
   the illustrated problem.



The website located at https://github.com/everhartlab/IntroR_2019 can be build via the
`make` program:

```make
make clean # run this to build the site from scratch
make
```

Note: if the README.md is changed, make will force-update the index.Rmd and in
turn force update the corresponding HTML.

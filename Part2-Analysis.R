# 
# Let's Practice!
# ===============
# 
# In this section we will cover:
# 
#  1. Working directories
#  2. Reading in data
#  3. Finding help
#  4. Basic data manipulation (renaming, subsetting, rotating)
#  
#  
# Part I: Working Directories
# ---------------------------
# 
# A working directory is the folder on your computer where you are currently
# working. You can find out your current working directory by typing `getwd()`

getwd()

# If you've downloaded and un-zipped this directory to your desktop, you might 
# see something like `/Users/<yourname>/Desktop/IntroR`. This is the default 
# place where R will begin reading and writing files. For example, you can use 
# the function `list.files()` to view the files in your current working 
# directory. These are the same files that we downloaded earlier. If you're 
# using Rstudio, you can compare the file list with the "Files" tab in the
# bottom right panel. 
# 
# In order to use `list.files()`, we should provide it with a file path. We can
# provide it a ".", which means "here" to most computer programs.

list.files(".")

# You can see that the first entry in here is "data". This is where we've placed
# the fungicide example data. 

list.files("data")

# Part II: Reading in Data
# ------------------------
# 
# 
# We can use the `read.table()` function to read these data in to R. It's
# important to remember that while in R, these data are simply a copy kept *in
# memory*, not on the disk, so we don't have to worry too much about
# accidentally deleting the data :).
# 
# So, how do we actually USE the `read.table()` function? 

stop("

     Type ?read.table and answer these three questions:
     
     1. What does it do? (Description)
     2. What are the first three arguments and their defaults? (Usage/Arguments)
     3. What does it return? (Value)
     
     ")


# In order to read our data into R, we will need to provide three things:
# 
#  1. The path to the data set                 : data/FungicideExample.csv
#  2. If the first row are column names        : yes
#  3. The separator for each cell in the data  : comma
# 
# Now that we have these elements, we can read the data into a variable, which
# we can call "fungicide". Once we do this, we can check the dimensions to make
# sure that we have all of the data.

fungicide <- read.csv("data/FungicideExample.csv", header = TRUE, sep = ",")
nrow(fungicide)
ncol(fungicide)

# We can print the data to screen by simply typing its name

fungicide

# We can also use the `str()` function (short for "structure") to have a broad
# overview of what our data looks like. This is useful for data frames with many
# columns.

str(fungicide)


# Part III: Finding the right tool for the job
# --------------------------------------------
# 
# The data presented here are from
# http://www.apsnet.org/edcenter/advanced/topics/EcologyAndEpidemiologyInR/DiseaseProgress/Pages/StripeRust.aspx
# and consist of three cultivars of wheat treated with different fungicides. 
# 'Jagger Wheat' is a succeptible variety whereas 'Cutter Wheat' and '2137 
# Wheat' are both resistant varieties. Disease severity is measured over a 
# period of 58 days. It is assumed that the fungicide will only be able to
# prevent new infections for two weeks after applicaton. With these data, we
# want to answer the following questions:
# 
#  1. How does the size of the fungicide effect compare to the effect of
#     cultivar? 
#  2. Would it be the same as cultivar?
# 
# To answer these questions, we will use the summary statistic, Area Under the
# Disease Progress Curve (AUDPC). 
# 
# So, how do you calculate this? You could code the trapezoid rule yourself, OR
# you could find a package that was designed for this. 

stop("

    Do an internet search for AUDPC in R. What did you find?

    ")

# The first thing that likely popped up was the function `audpc()` in the
# *agricolae* package. If we want to use it, we can download the package to our
# computer with the function `install.packages()`. This will install a package
# from CRAN and place it into your R *Library*. Where is your R library? Type
# `.libPaths()` to find out!
#+ eval = FALSE

.libPaths()

install.packages("agricolae", repos = "https://cran.rstudio.com")

# Now that we have the *agricolae* package installed, we can load into our R
# workspace using the `library()` function, which looks in our library and loads
# the functions and data sets within that package. You can find out about what
# functions are avialable with help(package = "agricolae").
# 
# To accomplish our task, however, we need to find out how to use the `audpc()`
# function. First we should load the agricolae package

library("agricolae")

# Now we can look up help for `audpc()`

?audpc

# This function will take in a data frame of severity and a vector of dates. 
# Since our vector of dates is in the first column, we will need to manipulate
# the data frame by subsetting. 

jdate <- fungicide$Julian.Date # this is the first column, so it can also
# be written as `jdate <- fungicide[, 1]`

jdate

severity_data <- fungicide[, -1]
severity_data

fungicide.audpc <- audpc(evaluation = severity_data, dates = jdate, type = "relative")

# Well this doesn't look good. What can this error message mean? Let's take a 
# look at the audpc help page one more time; this time, we'll look at the
# Examples section. Try to copy and paste 'example 3' code one line at a time
# and see what happens. Check the evaluaton data relative to the dates and see
# how it's relevant.

stop("

     Stop and look at the examples from ?audpc.
     
     ")

# We can see from example 3 that data must be arranged such that dates are in
# separate columns. How does our data look like?

fungicide

# We need to transpose our data. To do this, we can use the `t()` function:

t(fungicide)

# Now we can plug this into the `audpc()` function:

fungicide.audpc <- audpc(evaluation = t(fungicide[, -1]), dates = jdate, type = "relative")
fungicide.audpc

# This gives us a vector with the AUDPC values per treatment. The vector format 
# does not make it particularly easy to compare the effect of cultivar or
# treatment. A better format to store these data would be in a table. Since all
# the values are numeric, we can place them into a matrix using the `matrix()`
# function. We are going to put the cultivars in rows and experiments in columns.
# We have three cultivars (2137 Wheat, Cutter Wheat, and Jagger Wheat) and two
# experiments (Control and Treated).

fungicide.res <- matrix(fungicide.audpc, nrow = 3, ncol = 2, byrow = TRUE)
fungicide.res

# We have our result, but there are no labels for the rows and columns. Notice
# how we selected `byrow = TRUE`. This means that the matrix was filled row by 
# row. So the first two elements of the vector would go in the first row, the
# next two would go in the second, and so on and so forth.

names(fungicide.audpc)[1:2]
names(fungicide.audpc)[3:4]
names(fungicide.audpc)[5:6]
 
# Since this is a small matrix, we can easily name these rows and columns
# ourselves using the `rownames()` and `colnames()` functions.

rownames(fungicide.res) <- c("2137", "Cutter", "Jagger")
colnames(fungicide.res) <- c("Control", "Treated")
fungicide.res

# If we wanted to use these data as a table in a paper, we should export it to a
# csv file. We do this using the function `write.table()`

dir.create("results")
write.table(fungicide.res, file = "results/audpc.csv", sep = ",", 
            col.names = NA,
            row.names = TRUE)

# 
# Let's Practice!
# ===============
# 
# In this section we will cover:
# 
#  1. Working directories
#  2. Reading in data
#  3. Advanced data manipulation (filter, select, group_by, mutate)
#  4. Finding the right tool for the job
#  
#  
# Part 1: Working Directories
# ---------------------------
# 
# A working directory is the folder on your computer where you are currently
# working. You can find out your current working directory by typing `getwd()`

getwd()

# If you've downloaded and un-zipped this directory to your desktop, you might 
# see something like `/Users/<yourname>/Desktop/IntroR_Workshop`. This is the  
# default place where R will begin reading and writing files. For example, you  
# can use the function `list.files()` to view the files in your current working 
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

# Part 2: Reading in Data
# ------------------------
# 
# 
# We can use the `read.table()` function to read these data in to R. It's
# important to remember that while in R, these data are simply a copy kept *in
# memory*, not on the disk, so we don't have to worry too much about
# accidentally deleting the data :).
# 
# So, how do we actually USE the `read.table()` function? 

?read.table

# In order to read our data into R, we will need to provide three things:
# 
#  1. The path to the data set                 : data/fungicide_dat.csv
#  2. If the first row are column names        : yes
#  3. The separator for each cell in the data  : comma
# 
# Now that we have these elements, we can read the data into a variable, which
# we can call "fungicide". Once we do this, we can check the dimensions to make
# sure that we have all of the data.

fungicide <- read.csv("data/fungicide_dat.csv", header = TRUE, sep = ",")
nrow(fungicide)
ncol(fungicide)

# We can print the data to screen by simply typing its name

fungicide

# We can also use the `str()` function (short for "structure") to have a broad
# overview of what our data looks like. This is useful for data frames with many
# columns.

str(fungicide)

# The dummy data presented here consists of yield (measured in bu/acre) and disease
# severity (measured on a scale of 1 to 10) of a corn culitvar treated with two
# fungicides. This trial was conducted to measure the efficacy of the two fungicides 
# to manage disease. The experiment was laid out as a Completely Randomized Design. 

# Part 3: Advanced data manipulation (filter, select, group_by, mutate)
# ----------------------------------------------------------------------
# The package 'dplyr' provides functions for easy and advanced data manipulation.
# If we want to use it, we can download the package to our computer with the 
# function `install.packages()`. This will install a package from CRAN and place
# it into your R *Library*.

install.packages("dplyr")

# To load this package, we can use the function `library()`.

library("dplyr")

# So, how can we convert yield data from bu/acre to kg/ha ?
#
# We can do it similar to what we did in Part 1.

# fungicide$Yield_kg_per_ha <- fungicide$Yield_bu_per_acre*62.77

# We can also use the function `mutate()` from 'dplyr'. This adds a new variable 
# using the existing variables. The usage of this function is as: 
# mutate(data, new_variable_name = calculation_based_upon_existing_variables)

fungicide <- mutate(fungicide, Yield_kg_per_ha = Yield_bu_per_acre*62.77)
fungicide

# Notice that we did not have to use fungicide$Yield_bu_per_acre. 

# If we want to create a new data frame with selected columns from this data, 
# we can use the function `select()` that picks variables based on their names.
fungicide_yield <- select(fungicide, Treatment, Yield_kg_per_ha)
fungicide_yield

# If we want to filter a data frame based upon specific values of a variable,
# we can use the function `filter()`.
filter(fungicide, Treatment == "Fungicide_A")

fungicide <- filter(fungicide, Treatment == "Control" | Treatment == "Fungicide_A")
fungicide

# It can also be written as
filter(fungicide, Treatment != "Fungicide_B")

# If we want to summarise multiple values to a single value, for example, mean,
# we can use the function `summarise()`.
summarise(fungicide, Mean_yield = mean(Yield_kg_per_ha))

# In the above example, we just got one mean even though we had three different 
# groups (Control, Fungicide_A, Fungicide_B). To perform any operation by group, 
# we can use the function `group_by()`.

fungicide_grp <- group_by(fungicide, Treatment)
fungicide_grp
#
#
fungicide_grp_mean <- summarise(fungicide_grp, Mean_yield = mean(Yield_kg_per_ha))
fungicide_grp_mean

# Instead of creating different objects everytime, we may perform multiple functions
# at once to create one final object. We use the pipe operator, %>% , for this purpose.
# The left hand side of %>% acts as the input on which one function is performed and
# the right hand side of %>% is where we can write a subsequent function to be performed.

# Let's first restore our original data file.

fungicide <- read.csv("data/fungicide_dat.csv", header = TRUE, sep = ",")

yield_summary <- fungicide %>% 
  mutate(Yield_kg_per_ha = Yield_bu_per_acre*62.77) %>%  
  select(Treatment, Yield_kg_per_ha) %>% 
  group_by(Treatment) %>% 
  summarise(Mean_yield = mean(Yield_kg_per_ha))

yield_summary

# Let's make a new data frame for severity where severity is measured in percent and
# not on a scale of 1 to 10.

severity_dat <- fungicide %>% 
  mutate(Percent_Severity = Severity/10*100) %>% 
  select(Treatment, Percent_Severity)

severity_dat

# If we wanted to use these data as a table in a paper, we should export it to a
# csv file. We do this using the function `write.table()`

dir.create("results")
write.table(severity_dat, file = "results/severity_dat.csv", sep = ",", 
            col.names = NA,
            row.names = TRUE)

# Part 4: Finding the right tool for the job
# -------------------------------------------
# 
# The dummy data presented here consists of yield (measured in bu/acre) and disease
# severity (measured on a scale of 1 to 10) of a corn culitvar treated with two
# fungicides. This trial was conducted to measure the efficacy of the two fungicides 
# to manage disease. The experiment was laid out as a Completely Randomized Design.
# With these data, we want to find which fungicide is effective? We can find this by
# doing ANOVA for yield and severity data. The alpha level to be used is 0.05.
# 
# If you do an internet search for ANOVA in R, you will find that function `aov` is 
# appropriate for this. How do we use `aov`?

?aov

# This function takes in a formula to be tested. So if we want to find the response
# of `Yield_bu_per_acre` (dependent variable) with respect to `Treatment` (independent 
# variable), the formula should be written as 'Yield_bu_per_acre ~ Treatment'. The
# function also takes in a data frame in which these variables are present. Other
# arguments are optional.

# Let's use this function
aov(formula=Yield_bu_per_acre ~ Treatment, data=fungicide) 

# As mentioned in the 'Description', `aov` fits an ANOVA model to an experimental design.
# Let's check the 'Value' section of the help page so we know how to find the result.

# Create an object of class `aov`
fit_yield <- aov(formula=Yield_bu_per_acre ~ Treatment, data=fungicide) 

# Use `summary` method to find the 'Value'. 
summary(fit_yield)

# 'Pr(>F)' is the associated p-value. As the p-value is less than 0.05, we can say that
# the null hypothesis is rejected. So, at least one of the treatments is different.

# Now that we know that differences exist between our treatments, how can we find which
# treatments are different? We can do this by using Tukey's post-hoc test using the 
# function `TukeyHSD`.

TukeyHSD(fit_yield) # There is no difference between 'Fungicide_A' and 'Control' as the
                    # p-value is 0.978 (>0.05)

# Let's do similar analysis using the Severity data

fit_severity <- aov(formula=Severity ~ Treatment, data=fungicide)
summary(fit_severity)
TukeyHSD(fit_severity) 

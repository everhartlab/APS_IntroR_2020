# 
# Let's Practice!
# ===============
# 
# In this section we will cover:
# 
#  1. Working directories
#  2. Reading in data
#  3. Using an appropriate function to analyze data
#  4. Advanced data manipulation (filter, select, group_by, mutate)
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


# Part 3: Finding the right tool for the job
# --------------------------------------------
# 
# The dummy data presented here consist of disease severity and yield measured on 
# a corn culitvar treated with a new fungicide. This trial was conducted to measure
# the efficacy of the fungicide against two different fungi (A and B). The experiment   
# was laid out as a Completely Randomized Design. With these data, we want to answer 
# the following questions:
# 
#  1. Is the fungicide effective against both the fungi? 
#  2. Which fungus is more destructive when untreated?
# 
# We want to use the function `aov` for doing ANOVA.
?aov

# One Way Anova (Completely Randomized Design)
fit_dat <- aov(formula=Severity ~ Treatment, data=fungicide)
summary(fit_1)

# Since two fungi are being tested, ANOVA should be performed separately for the two
# data. For that, we first have to create separate data frames for data associated
# with the two fungi. We learned basic data manipulation in Part 1. Here, we will 
# introduce advanced data manipulation.

# Part 4: Advanced data manipulation (filter, select, group_by, mutate)

library("dplyr")

#filter
fungusA_dat <- fungicide %>% 
  filter(Fungus == "A")

fungusB_dat <- fungicide %>% 
  filter(Fungus == "B")

fit_fungusA_dat <- aov(formula=Severity ~ Treatment, data=fungusA_dat)
summary(fit_2) # not effective

fit_fungusB_dat <- aov(formula=Severity ~ Treatment, data=fungusB_dat)
summary(fit_3) # effective

#describe how logical work.. in ppt
#group_by, summarise
effect_fungus <- fungicide %>% 
  filter(Treatment != "Fungicide") %>% 
  group_by(Fungus) %>% 
  summarise(Mean_Severity = mean(Severity), Mean_Yield = mean(Yield_bu_per_acre))

# Suppose this data is sent to somebody in Japan and they want to analyze yield data
# but want to convert it to kg/ha from bu/acre. How should they proceed?

# select, mutate
yield_dat <- fungicide %>% 
  select(Treatment, Rep, Fungus, Yield_bu_per_acre) %>% 
  mutate(Yield_kg_per_ha = Yield_bu_per_acre*62.77) %>% 
  select(Treatment, Rep, Fungus, Yield_kg_per_ha)

# If we wanted to use these data as a table in a paper, we should export it to a
# csv file. We do this using the function `write.table()`

dir.create("results")
write.table(yield_dat, file = "results/yield_data.csv", sep = ",", 
            col.names = NA,
            row.names = TRUE)

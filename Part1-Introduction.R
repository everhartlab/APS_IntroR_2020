# 
# Let's get familiar with R 
# =========================
# 
# In this section we will investigate the following questions:
#  [[  How does R understand data?  ]]
# 
#  1. How to use this script and R
#  2. Creating objects and using logicals
#  3. Sequences and vectors (1-D)
#  4. Data frames, basic data manipulation (subsetting, renaming, joining), 
#     and finding help for using functions
#  
# Part 1: How to use this R script
# ---------------------------------
# 
# A script is a text document that contains instructions and commands The # 
# symbol is used to leave comments, which R will not try to interpret as a 
# command.
# 
# The console (below) is for submitting commands to be interpreted in R. To run 
# a command in the console, you can copy+paste it into the console and press 
# enter.
# 
# Copy and paste the following into the console and run it:

    print("the instructor's name is Sydney")  

# Run a single line of your script in the console by placing your cursor on the 
# line you want to submit and use your cursor to press the "Run" button at the 
# top right. You can also use the shortcut key strokes cmd+enter (mac) or 
# ctrl+enter (PC) to run a single line at a time.
# 
# The two other most important keyboard shortcuts that you'll want to use are the
# *Tab* key to auto-complete your typing at the command line and ctrl+up arrow or
# cmd+up arrow to access the most recently typed commands.
# 
# You can also select only part of a line to have it run on the console.  Try
# running the following command without copy+paste:   print("my name is _____")
# 
# R can also be used to perform calculations, such as the following:

5+1/3

# What rules does R apply for the order of operations and how do you find out?
# 
# Let's modify the statement above to see if adding parentheses changes the
# result:

(5+1)/3

# Does it matter if there are spaces added into this?
# 
 ( 5 + 1 ) / 3

# That shows us that the spaces did not matter for the calculation.
# 
# R also has some pre-defined matematical terms that you can use, such as pi.
# 
# What is pi times pi ?

pi*pi

pi^2   # this does the same thing because ^ is, here, interpreted as "taken to the exponent"

# 
# Part 2: Creating objects and using logicals
# --------------------------------------------
# 
# Objects are like shortcuts.  They are a way to store data without having to 
# re-type them.  By virtue, objects are only created once something has been 
# assigned to them.  Anything can be stored in an object, including figures!

# Let's repeat our simple math calculation above, this time using objects. If we
# want to calculate (5+1)/3 using objects, it needs to look like this: (a+b)/c
# The objects a, b, and c do not exist yet, so we need to assign values to them
# in order to create them. R interprets the less than symbol and dash as
# "assign".  So we need to do the following:

a <- 5  # assign the number 5 to a
b <- 1  # assign number 1 to b
c = 3   # we can also use `=` to assign 3 to c

# As you are assigning these numbers to objects, they appear in your environment
# (top right).  These objects are not being saved to a hard drive, they are
# stored in memory of your computer only.
# 
# > **NOTE** if you assign something to an object that already exists, R will do
# > what you tell it and overwrite that obect with the new assignment.
# 
# Now we can execute our calculation using objects instead of numbers.  Try it!

(a+b)/c

# Avoid creating object names that start with a numnber because R will look at
# the first character and try to interpret the entire name as a mathematical
# term.  Try this:

2foxes <- 1   

# The error here tells us that something went wrong and R cannot proceed.
# 
# If we want to assign (a+b)/c to a new object called `answer` -- what will the
# object contain?  Find out:

answer <- (a+b)/c

# Take a look at the object `answer` by typing the name into the command line:

answer

# What would you get if you multiplied answer by 2?

answer*2

# We can also use logical operations in R.  The answer to a logical question is
# always TRUE or FALSE.

a > b # Is `a` greater than `b`?  You can look at the Values on your right to
      # check the answer.
b > 10 # Is `b` greater than 10?
b + c > a # Is `b + c` greater than `a`?  R will first evaluate the algebraic
          # operation (`+`) and then evaluate the logical operation (`>`).
          # So, we don't need to use `(b+c) > a`
a = 7 

# Oops! We did not get any answer. What went wrong? Let's print `a`.

a

# `a = 7` changed the value of `a` to '7'.  So, how do we find if `a` is
# equal to '7'?

a == 7 # We need to put two '=' signs to check equality.

a != 7 # Is `a` not equal to '7'?

a & b > c # Are both `a` and `b` greater than c?
a | b > c # Is either `a` or `b` greater than c?

# The examples above dealt with numeric values assigned to objects.  We can also
# store character data in objects.  We need to place the character data (words,  
# phrases, etc.) inside quotation marks, otherwise R will try to interpret the  
# character data as an object and will produce an error.
# 
# Let's use my name for this exercise.  Let's create two objects, one for my
# first name and another for my last name.  

first.name <- "Sydney"
last.name <- 'Everhart'  # Single quotes work too!

# We now have those two objects.  Let's look at them.

first.name
last.name

# Since we each have a first name and a family name, I want you to modify these
# objects so that instead of my name, they contain your name. 

first.name <- "____"  # Replace ____ with your own name
last.name <- "____"

# Did this work?  Let's look at the two objects:

first.name
Last.name

# Oops!  What went wrong?  R is case-sensitive, so `last.name` is interpreted 
# differently than `Last.name`. Let's try again:

first.name
last.name # It works!

# Using a function c() we can tell R to *combine* these two objects.  This
# function will combine values from the first object with the second object and
# return them as a single observation.  Let's try it:

c(first.name, last.name)

# Notice how the names are returned inside quotation marks, which tells us that
# these are interpreted as character data in R. You'll also notice that each
# name is placed inside quotes and that's because c() combined names into a
# single vector that contains two elements, your first and your last name.  This
# brings us to the next part in our introduction, vectors.
# 

# Part 3: Vectors and sequences 
# ------------------------------
# 
# Up to here, the objects we've created only contained a single element. You can 
# store more than one element in a 1-dimensional object of unlimited length. Let's
# create an object that is a vector of our first and last names using the two
# objects that we created previously.
# 
# *Avoid re-typing your commands.* Since the last command that we ran contained 
# what we want, we can simply use the up arrow to access the most recently 
# submitted command and modify it. You can also access the *History* tab in the 
# top right panel of RStudio or, at the command line, access a list of the most 
# recent commands using the cmd + up arrow OR the ctrl + up arrow.

name <- c(first.name, last.name)

# We can inspect this object by typing *name* at the command line. We can
# inspect the structure of this object using the function str() on name.

str(name)

# This shows us that this is a vector because the elements in it are ordered from 1
# to 2 as shown by the [1:2]. This also tells us that this list is a *character*
# list, which is indicated by the *chr* label. We also see the two elements in this
# vector, which is your first and last name.
# 
# What is the length of your name?  We can find out using the function lenght()

length(name)

# Let's compare this to a vector that contains only numeric data. For this 
# example, let's create three objects to represent today's date in numbers for
# the month (06), day (27), and year (2018).

month <- 06
day <- 27
year <- 2018

# combine those three objects using the *combine* function:
today <- c(month, day, year)

# Inspect this object by typing the name `today` at the command line. You'll see
# that R has eliminated the zero that preceeds the 6 and has kept the order we 
# provided for these elements in the vector.  Let's take a look at the structure of
# today.

str(today)

# You'll notice that the vector has three elements [1:3] and it contains only 
# numeric data.
# 
# Let's do the same thing using the name June for month and see how that changes
# our vector. Notice that we are not modifying the object *month*, we are simply
# combining our two existing objects with the word "June".

c("June", day, year)   

# In this case we didn't re-assign the object named `today`. To inspect the 
# structure of this vector, we can wrap the statement within the str() function,
# as shown below. We also want to inspect the data class (ie. whether numeric or 
# character) using the function class().  Don't forget to use the up-arrow to
# access the last like that you ran!

str(c("June", day, year)) # this shows us the structure of the object
class(c("June", day, year))

# Notice how R is trying to keep our data organized according to type.  Rather
# than coding this vector as containing numbers and characters, it has decided
# that because it can't call everything in our vector a number that it will call
# everything characters. This process is called *coercion*.
# 
# Let's say we wanted to create a table that showed every date this month:
# 
# ```
#   day   month   year
#   1     6       2018
#   2     6       2018
#   3     6       2018
#   ...
# ```
# 
# We know there are 30 days in the month, so we can modify the object day to
# contain all of the 30 days in this month. Instead of typing each number out by
# hand, we can place a colon (`:`) between 1 and 30, which is a shortcut in R
# for creating sequences of numbers.

1:30

# You see at in the console that this created a sequence of 30 numbers from 1 to
# 30. Let's go ahead and assign this to the object `day`.

day <- 1:30

# For the objects month and year, we don't need to modify them, however, we want
# to repeat each of them a total of 30 times because we need to repeat each, 
# once for each day.
# 
# We can easily repeat the number 6 a total of 30 times using the function 
# `rep()`, specifying how many `times` we should repeat this object. Let's
# assign `6` to `month` and modify the object month to contain 30 copies.

month <- 6
month <- rep(month, times = 30)
month

# Let's check to make sure that month is correct using the function `length()`:

length(month)

# There are 30 elements in this vector and we can inspect individual elements in the
# vector based on their ordered position using square brackets:

day[27]  
month[27] # the number inside the brackets corresponds to location of element in list, not value

# In this case, the 27th element in `day` is 27, and the 27th element in `month` is 6
# which confirms that we created this correctly.
# 
# > Type `day[32]` into your R console. What do you get? What does it mean? Ask
# > yourself the question, "Are there any months with 32 days?"
# 
# We can create the object `year` to contain 30 repeats of 2018, however, this 
# time, let's say we wanted to make sure that this object was always the same
# length as the number of days we have in a month. Instead of specifying `30`,
# we can simply get that information using the `length()` function. Here, we'll
# replace `30` with `length(day)`, which is equivalent.

year <- rep(2018, times = length(day))
year
length(year)

# We now have three vectors to create our table and they are exactly the same length:

length(day)
length(month)
length(year)

# Part 4: Data frames, basic data manipulation, and finding help for using functions
# -----------------------------------------------------------------------------------
# 
# Remember that our goal here is to create a table with the columns "month",
# "day", and "year". First, here's a quick reminder of what we want this to
# look like:
# 
# ```
#   day   month   year
#   1     6       2018
#   2     6       2018
#   3     6       2018
#   ...
# ```
# 
# In order to create a data frame, we can use the command `data.frame()`. This
# function will create columns out of vectors that are all the same length. In
# the function, we just have to specify name of the column and populate it with
# vector data.

June <- data.frame(day = day, month = month, year = year)

# Let's inspect this new object in the same way as vectors:

June
length(June)

# Using the `length()` function, we see it says 3. This is because `June` has three
# columns: day, month, and year. A data frame is a two-dimensional object which
# stores its information in rows and columns. 
# 
# Because this is a 2-dimensional object, we can inspect the dimensions using
# the `dim()` function:

dim(June)

# This tells us that we have 30 rows and 3 columns. R also provides the `nrow()`
# and `ncol()` functions to make it easier to remember which is which:

nrow(June)
ncol(June)

# What happens when we use the `str()` function?

str(June)

# We can see that it's listing the columns we have in our table and showing us
# how they are represented. Notice the `$` to the left of each column name, 
# this is how we access the columns of the data frame:

June$day
June$month
June$year

# You can see that these are the same as the vectors we created earlier.
# 
# Because this object is rather large, we didn't get to see the top rows of the 
# obect.  A quick way to look at the top of the object is with the `head()`
# function and if we wanted to look at the bottom, we would use `tail()`.

head(June)  # if this didn't work, double-check that you spelled the object name correctly

# Now that we have our table, the question becomes, how do we inspect different elements?
# 
# Just like we can inspect the 27th element in the `day` vector using `day[27]`,
# we can also use the brackets to subset a table, the only catch is that we have
# to use the coordinates of the row(s) and the column(s) we want. We can do this
# by specifying `[row, column]`. These are analagous to X and Y Cartesian 
# coordinates. Let's take a look at the elements in the 27th row, separately:

June[27, 1] # day
June[27, "month"] # you can use characters when the elements are named!
June[27, 3] # year
June[27, -3] # here `-` means all columns except the third (year)
June[27, -2] # day and year

# If we don't specify a dimension, R will give us the entire contents of that
# dimension. Let's look at the row that contains today's date:

June[27, ]

# You can also use this to access just one column of the matrix.  Let's look at month:

June[, 2]

# Notice, however that this result now appears to be a a vector! This is because
# of a sneaky default option called `drop = TRUE`. R tries to "help" by removing
# the dimensions of your data frame if you choose only one column. If you want
# to keep this as a data frame, you can turn off this option *inside the 
# brackets*:

June[, 2, drop = FALSE]

# Now that we've inspected the object `June`, let's create the same thing for
# the month of July. How should we do this?
# 
# One option would be to create new obects for day, month, and year and combine
# them just like we did for June.  What is the simplest method to do this, using
# the fewest number of steps? 
# 
# We can simply make a copy of `July` and add a vector with information about
# the 31st day.  Now that we have two dimensions, there are two ways we can add
# the vector, as a row or as a column. R provides two functions that can help us
# with that called `rbind()` and `cbind()` which bind a data frame with a vector
# (or another data frame) by rows and columns, respectively.  Which one should
# we use?  If you're unsure, try both!

July <- cbind(June, c(31, 6, 2018))

# Inspect what we have now:

str(July)  # we have an extra column
tail(July) # we don't have 31 days

# Now let's try `rbind()`

July <- rbind(June, c(31, 6, 2018)) 
str(July)
tail(July) # we have 31 days!

# We need to change the month column so that it says 7 instead of 6, how can we
# do this?  Let's just look at the column first:

July$month

# We need to add 1 to each of these values, so let's try that!

July$month + 1

# This worked, so now we just need to replace values in July[,2] with the new
# expression:

July$month <- July$month + 1    # Did it work?
str(July)

# Let's combine both of these tables into one.

rbind(June, July)
summer <- rbind(June, July)

# Inspect this object to ensure it was made correctly. 

str(summer)
head(summer)
tail(summer)

# We now have a new object summer that contains only numeric data. Let's revise
# this object so that it uses names for the month instead of numbers.  We want
# it to look like this:
# ```
#   day   month   year  
#   1     "June"   2018  
#   2     "June"   2018  
#   3     "June"   2018
#   ...
# ```
# 
# Months need to be changed from the number 6 to "June" and from 7 to "July" in
# the second column.  Let's first look at the month column.

summer$month

# We want to specify only the cells in this list that are 6. We know that rows 1
# to 30 contain 6's and the rest contain 7's, which means we can inspect
# those rows in the object summer:

summer[1:30, "month"]     # June
summer[-c(1:30), "month"] # July

# 
# > Notice that we used `-c(1:31)`, what do you think this is doing? Why would 
# > this give us the values for the month of July?
# 
# We can use the `ifelse()` function to replace the values in our column.  How 
# do we use this function?  A good first step to figuring out how you can use a 
# function is to look at its help page.  The way you can do that is by typing  
# either `help("function_name")` or `?function_name`.  

?ifelse

stop("

     Type ?ifelse and answer these three questions:
     
     1. What does it do? (Description)
     2. What are the arguments? (Usage/Arguments)
     3. What does it return? (Value)
     
     ")

# In order to use `ifelse`, we will need to provide three things:
# 
#  1. A logical question about the elements of an object   : summer$month == 6
#  2. Values for TRUE elements                             : "June"
#  3. Values for FALSE elements                            : "July"

ifelse(summer$month == 6, yes = "June", no = "July")
summer$month <- ifelse(summer$month == 6, yes = "June", no = "July")

# > Notice that we had to use `==` to indicate equality. This is so that R 
# > doesn't get confused and assume we are using the argument assignment, `=`.
# 
# Now, let's inspect summer. 

str(summer)
head(summer)

# Let's change first letter of every column name to uppercase i.e., replace  
# "day" with "Day" and so on.  We can do this using `colnames()` function.

colnames(summer) # Current column names

colnames(summer) <- c("Day", "Month", "Year") # New column names

# Let's inspect summer again. 
str(summer)
head(summer)


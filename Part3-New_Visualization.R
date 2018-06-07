# 
# Part 3: Data Visualization
# ===========================
# 
# So far we have covered:
# 
#  - data types in R
#  - reading in data
#  - subsetting data
#  - reading documentation
#  - using functions
#  - saving data
#  
# Of course, we haven't used one of R's most powerful assets: graphics. This 
# section is dedicated to creating a plot from the data. While R has very
# powerful default plotting functions, we will be using the "ggplot2" package
# as it relies on a consistent "grammar of graphics" that gives a clear
# relationship between the data and the visualization.
# 
# 
# Expected Outcomes
# -----------------
# 
# After this section, you should have the tools to:
# 
#  1. Create a simple plot in ggplot2
#  2. Save plots
# 
# Again, since this is a four hour workshop, we do not expect mastery, but this
# at least should give you a starting point. With that in mind, let's get 
# started!
# 

install.packages("ggplot2")

library("ggplot2")

# Visualizing Data
# ----------------
# 
stop("
     What visualization might be appropriate for these data?
     What should be on the axes?
     Should we use lines, points, bars, boxplots, etc?
     ")
# 
# If you haven't taken the time to address the questions above, do so now. 
# 
# 
# 
# ### What is ggplot2?
# 
# The package *ggplot2* is built off of the "grammar of graphics" in which 
# plots are built layer by layer, starting with the coordinate plane
# and then adding geometric elements like lines, dots, bars, etc, and assigning
# metadata to values like color or shape. 
# 
# The advantage of ggplot2 over R's native plotting is that the plots are saved
# as R objects and can be modified by adding layers or even replacing data. This
# tutorial will begin to scratch the surface of how to use ggplot2, but to get a
# better idea of what is possible, you can browse the resources at
# http://ggplot2.tidyverse.org/#learning-ggplot2 or examine the code of
# colleagues (e.g. Alejandro Rojas:
# https://github.com/alejorojas2/Rojas_Survey_Phytopath_2016).
# 
# It is important to note that ggplot2 uses "bare" column names, meaning that you 
# do not need to put quotation marks when specifying a column.
# 
# 
# 
# 
# Part 1: Creating our plot
# -------------------------
# 
# > Note: if you are reading this script after attending the workshop, the plot
# > may look different due to the interactive nature of the workshop. This is
# > indtended as an example.
# 
# Before we begin, we should become familiar with two functions:
# 
#  - `ggplot()` initializes a ggplot object from a data set. The data set needs
#     to be a data frame.
#  - `aes()` is a general way to specify what parts of the ggplot should be 
#     mapped to variables in your data. What should be the x and y variables?
# 
# 
# ### Creating the base of the ggplot
# 
# To create our ggplot with nothing on it, we should specify two things:
# 
#  1. The data set (fungicide)
#  2. The mapping of the x and y coordinates (from the data set, using aes)

yield.plot <- ggplot(data = fungicide, mapping = aes(x = Treatment, y = Yield_bu_per_acre))

# If everything worked, you should see nothing. This is because ggplot2 returns
# an R object. This object contains the instructions for creating the
# visualization. When you print this object, the plot is created:

yield.plot

# Now you should see a plot with nothing on it where the x and y axes are
# labeled "Treatment" and "Yield_bu_per_acre", respectively.
# 
# To break down what the above function did, it first took in the data set 
# `fungicide` and then mapped the x and y aesthetics to the Treatment and
# yield columns. Effectively, this told ggplot how big our canvas needs to be
# in order to display our data, but currently, it doesn't know HOW we want to
# display our data; we need to give it a specific geometry.
# 
# 
# 
# ### Adding a geometry layer
# 
# All functions that add geometries to data start with `geom_`, so if we wanted
# the data to be displayed as a line showing the increase of yield over time,
# we would use `geom_line()`. If we wanted to show the data displayed as points,
# we can use `geom_point()`. We can also specify the color and shape of these
# geometries using `aes()`.
# 
# To add a geometry or anything to a ggplot object, we can just use the `+`
# symbol. Here, we will add lines to the plot coloring them by Cultivar and
# differing the line type by Experiment 
# 
# > Note: From here on out, I will be wrapping all commands with parentheses.
# > This allows the result of the assignment to be displayed automatically.

(yield.plot <- yield.plot + geom_boxplot())

# If we want to color the plot accordng to Treatment, we can supply that 
# information here. 

(yield.plot <- yield.plot + geom_boxplot(aes(fill = Treatment)))


# Now you can see that we have a boxplot displaying the data, To give a title to
# our plot, we can use `ggtitle()`. 

(yield.plot <- yield.plot + ggtitle("Effect of Fungicides on Yield"))

# We now have a fully functional and informative plot using only three lines of
# code! Producing a visualization of your data can be an extremely useful tool
# for analysis because it can allow you to see if there are any strange patterns
# or spurious correlations in your variables. 
# 
# You can click on 'Zoom' to view a bigger version of this plot. You can also click
# on 'Export' to save this plot as an image or pdf file on your computer.
#     
# Of course, this plot is not quite publication ready. For one thing, the font is
# too small and would cost a small fortune to include a color figure in a
# journal. We need to add some customization.
# 
# 
# Preparing a publication-ready plot
# ----------------------------------
# 
# In contrast to the above section, where layers are added to the plot, we are
# now manipulating the aesthetics of the plot in how the data and labels are
# displayed.
# 
# ### Axis labels 
# 
# We also need to update the axis labels. This is easily done with `xlab()` and
# `ylab()`:

(yield.plot <- yield.plot + xlab("Treatment Applied"))
(yield.plot <- yield.plot + ylab("Yield (bu/acre)"))

# The labels are now okay, but it's still not publication-ready. The font is too
# small, the background should have no gridlines and the axis text needs to be
# darker.  
# 
# 
# ### Adjusting Look and Feel (theme)
# 
# The first thing we can do is change the default theme from `theme_grey()` to
# `theme_bw()`. We will simultaneously set the base size of the font to be 14pt.

(yield.plot <- yield.plot + theme_bw(base_size = 14))

# There are many different default themes available for ggplot2 objects that
# change many aspects of the look and feel. The *ggthemes* contains many popular
# themes such as fivethirtyeight and economist. Of course, as it is, the plot
# is still not ready for publication. For one, the legend is taking up to much
# horizontal realestate and the size of the plot is cutting off 
# TwentyOneThirtySevenWheat.
# 
# To adjust granular aspects of the theme, we can use the `theme()` function, 
# which contains a whopping 71 different options all related to the layout of
# the non-data aspects of the plot.
# 

stop("
     Look at ?theme and figure out one of the following:
     1. change the aspect ratio of the panels
     2. remove the background grid in the panels
     3. change the placement of the legend
     4. change the orientation of the legend
     ")

# When we inspect the help page of the `theme()` function, we can find out how
# to adjust several parameters to make out plot look acceptable:

(yield.plot <- yield.plot + theme(aspect.ratio = 1.25)) 
(yield.plot <- yield.plot + theme(panel.grid = element_blank()))

# 
# 
# 
# ### Putting it all together
# 
# Because we can add information to a plot with the `+` symbol, we can add all
# of the elements in one go. Let's combine what we have above, but removing the
# points and the color of the lines since these are redundant.

yield.plot <- ggplot(fungicide, aes(x = Treatment, y = Yield_bu_per_acre)) +
  geom_boxplot(aes(fill = Treatment)) +
  ggtitle("Effect of Fungicides on Yield") +
  theme_bw(base_size = 14) +
  theme(aspect.ratio = 1.25) +
  theme(panel.grid = element_blank()) +
  xlab("Treatment Applied") +
  ylab("Yield (bu/acre)")
yield.plot

# We can now create a similar plot for Severity Data.

severity.plot <- ggplot(fungicide, aes(x = Treatment, y = Severity)) +
  geom_boxplot() +
  ggtitle("Effect of Fungicides on Disease Severity") +
  theme_bw(base_size = 14) +
  theme(aspect.ratio = 1.5) +
  theme(panel.grid = element_blank()) +
  xlab("Treatment Applied") +
  ylab("Disease Severity")
severity.plot

# element_text() is an “element function” and it is used to format text elements.
(severity.plot <- severity.plot + theme (plot.title = element_text(hjust = 0.5)))

(severity.plot <- severity.plot + theme(axis.text.x = element_text(angle = 60, hjust = 1)))

# 
# Part 2: Saving your plot
# 
# Now that we have our plot finished, we can save it with the `ggsave()`
# function, which allows us to save it as a pdf, png, svg, eps, etc. file. 

ggsave(filename = "results/figure1.pdf", width = 88, units = "mm")


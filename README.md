# Lab 2 Assignment

Please write an R script that performs the operations described below. When you are done, submit your assignment by pushing to GitHub.  You do not need to submit anything in Cavas.  Make sure the file you submit can be executed in R or RStudio with a clean environment.  That is, make sure it will provide output using the source() command from within R. Perform all the operations described below. Comment your script so that I know which lines are meant to address which item in the list below.

 
1. Getting and Reformatting Data

The US Census website provides a data set representing many population statistics from 2010 to 2014 at the following website:

[Census Pop Stats](https://www2.census.gov/programs-surveys/popest/datasets/2010-2014/state/asrh/)

These data sets can be downloaded as a CSV that is readable directly in R.  Load the "sc-est2014-agesex-civ.csv" set.  Select the subset of the data corresponding to the variables POPEST2010_CIV through POPEST2014_CIV for Florida and Alabama (hint:  filter, slice, subset), then reformat that data so it easier to visualize (hint:  melt), and finally provide a line plot with two trends showing the number of births over all the years in the 2010-2014 period for Florida and Alabama.
 
2.  Data Munging

I ran an simple evolutionary algorithm (EA) optimization method on five different instances of a binary knapsack problem.  Since EAs are stochastic, for each instance I ran 10 independent trials.  For each trial and each distinct problem instance, I reported the best solution found (the highest value of items that fit into the knapsack for that problem).  You can find this data set at the following location:

[Knapsack](http://eecs.ucf.edu/~wiegand/idc6700/datasets/knapsack-data.csv)

Take this data set compute the mean and standard deviation across all the trials for each problem instance (hint:  group_by, summarize), then produce a point and whisker plot where the points position represents the mean and the whisker length represents the standard deviation.

 

3. Plot golfers data

Consider the following dataset about PGA golfers in 2004:

[PGA Data](http://eecs.ucf.edu/~wiegand/idc6700/datasets/pga2004.csv)

Find a way to plot the following variables:  winnings,  and three of the following variables:  avedrv, drvacc, grnreg, aveputt, savepct, or events.  Explain why you chose those variables and why you chose the encodings your picked for each variable.

 

4. Modeling Data

Consider again the 2004 PGA golfers data from question #3.  Construct a standard linear model for predicting the winnings response variable from the following explanatory variables:  avedrv, drvacc, grnreg, aveputt, savepct, and events.  Construct a second model of some sort for the same variables.  Compare these two fits quantitatively and tell which is better.

 

5.  Predicting from your model

Now consider the following dataset, which consists of three additional golfers not in set on which you made your model fits.

http://eecs.ucf.edu/~wiegand/idc6700/datasets/pga2004b.csv 

 Use your two models from question #4 to make predictions of the winnings in the new data set.  Compare these to the actual winnings.  Which is the better predictor.


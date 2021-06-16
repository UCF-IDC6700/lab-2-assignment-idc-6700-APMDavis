# Alexis Davis Lab 2 Assignment
library(dplyr)
library(reshape2)
library(ggplot2)
library(scales)

# 1. Census Data
Census <-read.csv('https://www2.census.gov/programs-surveys/popest/datasets/2010-2014/state/asrh/sc-est2014-agesex-civ.csv', header = TRUE, sep = ",")  
#Renamed columns by year
names(Census) [9] = 2010
names(Census) [10] = 2011
names(Census) [11] = 2012
names(Census) [12] = 2013
names(Census) [13] = 2014
#Filtered by Alabama or FL by total sex and age 0 for birth, renamed to FLALTotalBirths
Census %>% filter(NAME == "Florida" | NAME == "Alabama", SEX == 0, AGE ==0)
FLALTotalBirths<-Census %>% filter(NAME == "Florida" | NAME == "Alabama", SEX == 0, AGE ==0)
View(FLALTotalBirths)
#Selected Name & Year, renamed to FLAALBirthPerYear
select(FLALTotalBirths, "NAME", "2010", "2011", "2012", "2013", "2014")
FLALBirthPerYear<-select(FLALTotalBirths, "NAME", "2010", "2011", "2012", "2013", "2014")
View(FLALBirthPerYear)
# Melted, renaming as Molten
Molten <- melt(FLALBirthPerYear, id.vars = "NAME")
View(Molten)
#Line plot of Births by State
print(ggplot(Molten, aes(variable, value, color = NAME, group = NAME)) +
  geom_line(stat = "identity") +
  xlab("Census Year") + 
  ylab("Number of Births") + 
  ggtitle("Births by State, 2010-2014") + 
  theme(text=element_text(size=14, family="Times")) + 
  scale_y_continuous(labels = comma))

#2. Data Munging
knapsack_data <-read.csv('http://eecs.ucf.edu/~wiegand/idc6700/datasets/knapsack-data.csv', header = TRUE, sep = ",")
MeanSD.BestSolution = knapsack_data %>% #New dataframe
group_by(ProblemInstance) %>% #Group by instance
  summarise(
    Mean = mean(BestSolution), #Summarize and label mean & sd columns
    SD = sd(BestSolution))
View(MeanSD.BestSolution)
#Point/line plot with error bars, with title and labels
print(ggplot(MeanSD.BestSolution, aes(x=ProblemInstance, y=Mean, color = ProblemInstance)) +
  geom_line() + 
  geom_point() + 
  geom_errorbar(aes(ymin=Mean-SD, ymax=Mean+SD), width = 0.2, position = "identity") + 
  xlab("Problem Instance") + 
  ylab("Best Solution (Mean & SD)") + 
  ggtitle("Knapsack Problem: 5 Problem Instances") + 
  theme(text = element_text(size = 14, family = "Times")) + 
  theme(legend.position = "none")) 

#3. PGA Plot
#There was a comma before Jr. for one of the golfers messing things up, so I had to edit in Notepad, upload to GitHub, make my repo public, and copy the raw link here. HOPE THIS WORKS. Took me forever to figure out. 
PGA <-read.csv('https://raw.githubusercontent.com/UCF-IDC6700/lab-2-assignment-idc-6700-APMDavis/main/pga2004a.csv', header = TRUE, sep = ",")
#Plot: Bubble plot to allow for 4 variables
#Chose Events for X b/c when grouped, has fewest observations (so can plot easier) & b/c want to see if as Events go up, Winnings and other variables go up.
#Chose avedrv for size b/c its values had the biggest range of the remaining variable options. Changed scale/range so size difference more obvious. Picked savepct for color b/c its values had the next largest range of remaining variable choices. I made the alpha mid-range so that the slight differences in percentage/color were more detectable. Since this isn't a precise visualization, relative differences were important to discern.
print(ggplot(PGA, aes(x=events, y=winnings, size=avedrv, color=savepct)) +
geom_point(alpha=0.7) + scale_size (range=c(0,10)) +
xlab("Events") + 
ylab("Winnings") + 
ggtitle("PGA 2004 Stats") + 
theme(text = element_text(size = 14, family = "Times")))

#4. Modeling 6 variables as predictors of winnings
#Linear regression
fit1<-lm(formula = winnings ~ avedrv + drvacc + grnreg + aveputt + 
     savepct + events, data = PGA)
summary(fit1)
#Polynomial regression
fit2<-lm(formula = winnings ~ poly(avedrv, 6), data = PGA)
summary(fit2)
#fit1 has higher adj R2 and 4 of 6 predictors explain significant variability in y (vs. 1 of 6 for fit2 poly model), so fit1 is better fit  

#5. Prediction
PGA2 <- read.csv('http://eecs.ucf.edu/~wiegand/idc6700/datasets/pga2004b.csv', header = TRUE, sep = ",")
#Predict with fit1, the linear model
LinPred = predict(fit1, newdata=PGA2)
print(LinPred)
#Predict with fit2, the polynomial model
PolyPred<-predict(fit2, newdata=PGA2, SE = true)
print(PolyPred)
print(PGA2$winnings)
print(LinPred)
print(PolyPred)
#In this case, it seems fit2 the polynomial model is a better predictive model (for 2 of 3 golfers). P.S. I was pretty confused on the polynomial plotting, but what I did is based on what's at this link, but modeling for y (winnings) instead of x. http://www.science.smith.edu/~jcrouser/SDS293/labs/lab12-r.html 
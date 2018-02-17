#' ---
#' title: "R tidyverse workshop"
#' author: "Carpentry UiO"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---

#' *Read more about this type of document in 
#' [Chapter 20 of "Happy Git with R"](http://happygitwithr.com/r-test-drive.html)*
#'  
#' Uncomment the following lines to install necessary packages

#install.packages("tidyverse")
#install.packages("maps")
#install.packages("gapminder")

#' First we need to load libraries installed previously
library(tidyverse)

#' We will source `gapminder` dataset into the session and assign it 
#' to the variable with the same name
gapminder <- gapminder::gapminder

gapminder

#' Let's make our first plot
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))

#' Generally speaking ggplot2 syntax follows the template:
# ggplot(<DATA>) +
#   geom_<GEOM_FUNCTION>(mapping=aes(<AESTETICS>))

<<<<<<< HEAD
#' Let's learn some more about `ggplot2` and its functions!
ggplot(gapminder)+
  geom_point(mapping = aes(x=year, y=gdpPercap))

ggplot(gapminder)+
  geom_jitter(mapping = aes(x=year, y=gdpPercap))

ggplot(gapminder)+
  geom_jitter(mapping = aes(x=gdpPercap, y=lifeExp, color=continent))

ggplot(gapminder)+
  geom_point(mapping = aes(y=gdpPercap, x=pop, color=continent))

ggplot(gapminder)+
  geom_jitter(mapping = aes(x=year, y=lifeExp, color=continent))

ggplot(gapminder)+
  geom_jitter(mapping = aes(x=continent, y=lifeExp, color=year))

ggplot(gapminder)+
  geom_jitter(mapping = aes(x=continent, y=lifeExp, color=country))

ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp, color=year))

ggplot(gapminder)+
  geom_point(mapping = aes(x=log(gdpPercap), 
                           y=lifeExp, 
                           color=year))

ggplot(gapminder)+
  geom_point(mapping = aes(x=log(gdpPercap), 
                           y=lifeExp, 
                           color=continent,
                           size=pop))

ggplot(gapminder)+
  geom_point(mapping = aes(x=log(gdpPercap), 
                           y=lifeExp, 
                           color=year,
                           size=pop,
                           shape=continent))


ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp),
             color="blue", alpha=0.1)

ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp),
             color="blue", alpha=0.1)

# new geom function
ggplot(gapminder)+
  geom_line(mapping = aes(x=year, y=lifeExp, 
                          group=country,
                          color=continent))

ggplot(gapminder)+
  geom_boxplot(mapping = aes(x=continent, y=lifeExp, 
                             color=continent))

#Combine plots
ggplot(gapminder)+
  geom_jitter(mapping = aes(x=continent, y=lifeExp,
                            color=continent)) +
  geom_boxplot(mapping = aes(x=continent, y=lifeExp, 
                             color=continent))

# Remove redundancy  
ggplot(gapminder, mapping = aes(x=continent, y=lifeExp,
=======
#' Let's learn some more about `ggplot2` and its functions

## Imagine the rest of the script from before lunch!  

#' 
#' 

ggplot(gapminder)+
  geom_jitter(mapping = aes(x=gdpPercap, y=lifeExp, 
                            color=continent))

#' Transform gdpPercap to log scale by wrapping the name of the column into the appropriate function
ggplot(gapminder)+
  geom_point(mapping = aes(x=log(gdpPercap), 
                           y=lifeExp, color=continent))


#' There are many more aestetics in ggplot
#' See cheatsheet https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
#' Or the newer version in Rstudio. Click Help > Cheatsheets > ...
#' Introducing `size` aestetic 
ggplot(gapminder)+
  geom_point(mapping = aes(x=log(gdpPercap), 
                           y=lifeExp, color=continent,
                           size=pop))

#' If you want to color all points in same color, provide aestetic properties
#' outside of `aes()` function
#' 
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp), 
             color="blue", alpha=0.1)



#' Introducing new geom function LINES

ggplot(gapminder, mapping = aes(x=continent, y=lifeExp, 
>>>>>>> dmi3kno/master
                                color=continent))+
  geom_jitter() +
  geom_boxplot()

<<<<<<< HEAD
ggplot(gapminder, mapping = aes(x=gdpPercap, 
                                y=lifeExp))+
  geom_point(mapping = aes(color = continent), alpha=0.5) +
  geom_smooth(method = "lm")

ggplot(gapminder, mapping = aes(x=gdpPercap, 
                                y=lifeExp,
                                color=continent))+
  geom_point() +
  geom_smooth(method = "lm") +
  scale_x_log10()


ggplot(gapminder, mapping = aes(x=year,
                                y=gdpPercap,
                                group=year))+
  geom_boxplot() +
  scale_y_log10()

ggplot(gapminder) +
  geom_histogram(mapping = aes(x=gdpPercap), bins = 100) +
  scale_y_log10()

ggplot(gapminder) +
  geom_density(mapping = aes(x=gdpPercap, color=continent)) +
  scale_x_log10()

ggplot(gapminder) +
  geom_density2d(mapping = aes(x=gdpPercap, y=lifeExp)) +
  scale_x_log10()

# Faceting
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp)) +
  facet_wrap(~continent)

ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp)) +
  facet_grid(~continent)

ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp)) +
  facet_wrap(~year)

ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, 
                           y=lifeExp,
                           color=continent,
                           size=pop)) +
  scale_x_log10() +
  labs(x="GDP per capita", 
       y="Life expectancy at birth (years)",
       color="Continent",
       size="Population",
       title = "GDP per capita vs. life expectancy",
       subtitle = "More money, longer life",
       caption = "Source: Gapminder foundation")
ggsave("myplot.png")
=======
#' More examples of multiple layers
ggplot(gapminder, mapping = aes(x=year, group=year, 
                                y=gdpPercap))+
  geom_boxplot()+
  scale_y_log10()

#' We can make a histogram

ggplot(gapminder)+
  geom_histogram(mapping=aes(x=gdpPercap), 
                 bins=20)+
  scale_x_log10()

#' We can try 2D density function to identify clusters
ggplot(gapminder)+
  geom_density2d(mapping=aes(x=gdpPercap,
                           y=lifeExp))+
  scale_x_log10()


#' Faceting allows you to split the data into "small multiples"
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))+
  facet_wrap(~year)

#' Lets label the data
ggplot(gapminder)+
  geom_point(mapping=aes(x=gdpPercap,
                         y=lifeExp,
                         color=continent,
                         size=pop))+
  scale_x_log10() +
  labs(x="GDP per capita in '000 USD",
       y="Life expectancy at birth, years",
       color="Continent",
       size="Population",
       title="GDP per capita vs. Life Expectacy",
       subtitle="The more money you have the longer you live",
       caption="Source: GAPMINDER.ORG foundation")

#' saving plots is easy with `ggsave()` which by default saves the last plot into the filename you specify
ggsave("my_plot.png")









>>>>>>> dmi3kno/master

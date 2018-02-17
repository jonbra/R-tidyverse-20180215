<<<<<<< HEAD
library(readxl)
raw_fert <- read_excel("indicator undata total_fertility.xlsx")
View(raw_fert)
raw_fert

raw_fert %>% 
  rename(country=`Total fertility rate`) %>% 
  gather(key = year, value = fert, -country)

fert <- raw_fert %>% 
  rename(country=`Total fertility rate`) %>% 
  gather(key = year, value = fert, -country) %>% 
  mutate(year = as.integer(year))

raw_mort <- read_excel("indicator gapminder infant_mortality.xlsx")
View(raw_fert)
raw_mort

mort <- raw_mort %>% 
  rename(country=`Infant mortality rate`) %>% 
  gather(key=year, value = mort, -country) %>% 
  mutate(year = as.integer(year),
         mort = as.numeric(mort))

gapminder_plus <- gapminder %>% 
  left_join(fert, by = c("year", "country")) %>% 
  left_join(mort, by = c("year", "country"))

write_csv(gapminder_plus, "gapminder_plus.csv")
=======
library("readxl")

raw_fert <- read_excel("indicator undata total_fertility.xlsx")

raw_fert

fert <- raw_fert %>% 
  rename(country = `Total fertility rate`) %>% 
  gather(key = year, value = fert, -country) %>% 
  mutate(year = as.integer(year))

fert

raw_infantMort <- read_excel("indicator gapminder infant_mortality.xlsx")

infantMort <- raw_infantMort %>% 
  rename(country = `Infant mortality rate`) %>% 
  gather(key = year, value = infantMort, -country) %>% 
  mutate(year = as.integer(year),
         infantMort = as.numeric(infantMort))

gapminder_plus <- gapminder %>% 
  left_join(fert, by = c("year", "country")) %>% 
  left_join(infantMort, by = c("year", "country"))

gapminder_plus

write_csv(gapminder_plus, "gapminder_plus.csv")

>>>>>>> dmi3kno/master

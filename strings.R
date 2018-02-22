library(tidyverse)

gapminder <- gapminder::gapminder

gapminder %>% 
  filter(str_detect(country, "Rep")) %>% 
  select(country) %>% 
  distinct()

dr_string <- "Congo, Dem. Rep."         
dr_string

dr_pattern <- ", Dem\\. Rep\\."
dr_pattern

str_detect(dr_string, dr_pattern)
str_replace(dr_string, dr_pattern, "")
str_c("Deomocratic Republic of ", str_replace(dr_string, dr_pattern, ""))

str_locate(dr_string, dr_pattern)
str_locate(dr_string, dr_pattern)[1]
str_locate(dr_string, dr_pattern)[2]
str_locate(dr_string, dr_pattern)[,1]
str_locate(dr_string, dr_pattern)[1,2]

start <- str_locate(dr_string, dr_pattern)[1,1]
start
class(start)
typeof(start)

str_sub(dr_string, start = start)
str_sub(dr_string, end = start)
str_sub(dr_string, end = start-1)

read_lines(file="https://www.gapminder.org/wp-content/themes/gapminder/cronJobs/json.js") %>% 
  str_replace("var indicatorsJson=", "") %>% 
  str_sub(start = 1, end = 10)

read_lines(file="https://www.gapminder.org/wp-content/themes/gapminder/cronJobs/json.js") %>% 
  str_replace("var indicatorsJson=", "") %>% 
  str_length()

read_lines(file="https://www.gapminder.org/wp-content/themes/gapminder/cronJobs/json.js") %>% 
  str_locate("\\{")

clean <- read_lines(file="https://www.gapminder.org/wp-content/themes/gapminder/cronJobs/json.js") %>% 
  str_sub(start = 20, end = -1) 
  #str_sub(start = 1, end = 1)
  #str_length()

my_list <- str_c("[", clean, "]") %>% 
  jsonlite::fromJSON(simplifyVector = F) # TRUE would make it into a vector instead of a list

my_list <- str_c("[", clean, "]") %>% 
  jsonlite::fromJSON(simplifyVector = F) %>% View 

#Another way to add square brackets into the string
install.packages("glue")
glue::glue("[{txt}]", txt=clean)

# Subsetting lists
my_lisst <- my_list[[1]] #my_list had a list inside the list. Extract the first list within. (one redundant layer)

length(my_lisst)
my_lisst[1] %>% 
  View

my_lisst[[1]][1]

my_lisst[[1]][[1]]

my_lisst[[1]][[5]] # Extract 5th element of first element
my_lisst[[1]]$dataprovider_link #same as above
my_lisst[[1]][["dataprovider_link"]] # same as well

#Recurization (??). Iterate over every element in a list
purrr::map(my_lisst, `[[`, "indicatorName")

# map(<LIST>, <FUNCTION>, <ARGUMENTS_IF_ANY>) # `[[` an extract function for extracting element of a list

purrr::map(my_lisst, "indicatorName") # For extract it is possible to skip the function. It understands.

purrr::map(my_lisst, `[[`, "indicatorName") %>% View

purrr::map(my_lisst, `[[`, "dataprovider_link") %>% View

purrr::map(my_lisst, `[[`, 5) %>% View

# Flatten the list into a vector (it only has one type of element so no need to keep as a list)
simple_vector <- purrr::map(my_lisst, `[[`, "indicatorName") %>%
  simplify() %>% View

#Exercise

# Create vectors first:
indicatorName <- purrr::map(my_lisst, `[[`, "indicatorName") %>% 
  simplify()
cat <- purrr::map(my_lisst, `[[`, "category") %>% 
  simplify()
sub_cat <- purrr::map(my_lisst, `[[`, "subcategory") %>% 
  simplify()
dat_prov <- purrr::map(my_lisst, `[[`, "dataprovider") %>% 
  simplify()
dat_prov_link <- purrr::map(my_lisst, `[[`, "dataprovider_link") %>% 
  simplify()

# Make tibble
my_tibble <- tibble(indicatorname=indName,
                    category = cat,
                    subcategory = sub_cat,
                    dataprovider = dat_prov,
                    dataprovider_link = dat_prov_link)

# Write to file
write_csv(my_tibble, "my_gapminder_csv.csv")

#Better solution
my_tibble <- tibble(indicatorName = purrr::map(my_lisst, `[[`, "indicatorName") %>% simplify(),
       cat = purrr::map(my_lisst, `[[`, "category") %>% simplify(),
       sub_cat = purrr::map(my_lisst, `[[`, "subcategory") %>% simplify(),
       dat_prov = purrr::map(my_lisst, `[[`, "dataprovider") %>% simplify(),
       dat_prov_link = purrr::map(my_lisst, `[[`, "dataprovider_link") %>% simplify())

# Write to file
write_csv(my_tibble, "my_gapminder_csv.csv")

# Extract names from vectors
v <- c(a="a", b="b", c=2.2)
attr(v, "names")
names(v)
names(my_lisst) %>% View

tibble(sheet_id=names(my_lisst),
       indicatorName = purrr::map(my_lisst, `[[`, "indicatorName") %>% simplify(),
       category = purrr::map_chr(my_lisst, `[[`, "category") %>% simplify(),
       subcategory = purrr::map_chr(my_lisst, `[[`, "subcategory") %>% simplify(),
       dataprovider = purrr::map_chr(my_lisst, `[[`, "dataprovider") %>% simplify(),
       dataprovider_link = purrr::map_chr(my_lisst, `[[`, "dataprovider_link") %>% simplify()) %>% 
  write_csv("my_gapminder_csv.csv")


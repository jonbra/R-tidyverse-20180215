library("tidyverse")

gapminder <- gapminder::gapminder

gapminder

gapminder %>% select(-gdpPercap)

year_country_gdp <- gapminder %>% 
  select(year, country, gdpPercap)

gapminder %>% 
  filter(year == 2002) %>% 
  ggplot(mapping = aes(x = continent, y = pop)) +
  geom_boxplot()

gapminder %>% 
  filter(continent == "Europe") %>% 
  select(year, country, gdpPercap)

gapminder %>% 
  filter(country == "Norway") %>% 
  select(gdpPercap, lifeExp, year)

gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap = mean(gdpPercap))

gapminder %>% 
  filter(continent == "Asia") %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  filter(mean_lifeExp == min(mean_lifeExp) | 
           mean_lifeExp == max(mean_lifeExp))

gapminder %>% 
  group_by(continent, year) %>% 
  summarize(mean_gdpPercap = mean(gdpPercap), 
            sd_gdpPercap = sd(gdpPercap), 
            mean_pop = mean(pop), 
            sd_pop = sd(pop))

gapminder %>% 
  mutate(gdp_billion = gdpPercap * pop / 10^9)

gapminder %>%  
  mutate(gdp_billion = gdpPercap * pop / 10^9) %>% 
  filter(year == 1987) %>% 
  group_by(continent) %>% 
  summarize(mean_lifeExp = mean(lifeExp), 
            mean_gdp_billion = mean(gdp_billion))

gapminder_country_summary <- gapminder %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp = mean(lifeExp))

gapminder_country_summary

map_data("world") %>% 
  rename(country = region) %>%
  left_join(gapminder_country_summary, by = "country") %>% 
  ggplot() +
  geom_polygon(mapping = aes(x = long, y = lat, group = group, 
                             fill = mean_lifeExp))

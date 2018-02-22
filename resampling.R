library(tidyverse)
library(rsample)

gapminder <- gapminder::gapminder

train_df <- gapminder %>% 
  rsample::vfold_cv() %>% 
  slice(1) %>% pull(splits) %>% #slice is selecting one fold (like one line of the tibble)
  analysis()

train_df <- gapminder %>% 
  rsample::vfold_cv() %>% 
  slice(1) %>% pull(splits) %>%
  assessment()

gapminder %>% 
  rsample::vfold_cv() %>% 
  mutate(mod=map(splits,
                 ~lm(formula=lifeExp ~year, data = analysis(.x))))

gapminder %>% 
  rsample::vfold_cv() %>% 
  mutate(mod_full=map(splits,
                 ~lm(formula=lifeExp ~year, data = analysis(.x)),
                 rmse=map2(modelr::rmse(mod_full, splits))))

gapminder %>% 
  rsample::vfold_cv() %>% 
  mutate(mod_full=map(splits,
                      ~lm(formula=lifeExp ~year, data = .x)),
         rmse_full=map2_dbl(mod_full, splits,
                            ~modelr::rmse(.x, .y)),
         mod_analyis=map(splits,
                         ~lm(formula = lifeExp ~year, data=analysis(.x))),
         rmse_assess=map2_dbl(mod_analyis, splits,
                              ~modelr::rmse(.x, assessment(.y))))
          

         
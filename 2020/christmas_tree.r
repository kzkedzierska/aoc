library(tidyverse)

tibble(y = -(1:10)) %>%
  mutate(x1 = y*-1,
         x2 = y) %>%
  rowwise() %>%
  mutate(bauble = sample(x2:x1, 1),
         bauble_type = sample(1:3, 1)) %>%
  pivot_longer(names_to = "var_name",
               values_to = "x",
               -c(y, bauble, bauble_type)) %>%
  ggplot(aes(x, y, group = y)) +
  geom_line() +
  geom_point(aes(bauble, y, color = bauble_type, size = bauble_type)) +
  theme_void() + 
  theme(legend.position = "none") + 
  geom_point(data = tibble(x = 0, y = 0), aes(x,y), shape = 8, size = 6)


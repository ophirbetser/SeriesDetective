pacman::p_load(
            data.table,
            tidyverse,
            openxlsx,
            DT,
            shiny,
            visdat)

iris %>% ggplot() +
  aes(Sepal.Length,Sepal.Width) +
  geom_point()
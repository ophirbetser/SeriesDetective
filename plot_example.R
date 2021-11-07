pacman::p_load(
            data.table,
            tidyverse,
            openxlsx,
            DT,
            shiny,
            visdat)

g1 <- 
iris %>% ggplot() +
  aes(Sepal.Length,Sepal.Width) +
  geom_point()

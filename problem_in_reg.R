pacman::p_load(
            data.table,
            tidyverse,
            openxlsx,
            lubridate,
            skimr,
            DT,
            shiny,
            visdat)

d <- fread("/Users/ophirbetser/Ophir/R PROJECTS/SeriesDetective/problem_in_reg.csv")

d[, ":="(res_wday = y - mean(y)), by = wday]
d[, ":="(res_wday_is_holiday = res_wday - mean(res_wday)), by = is_holiday]

model_1 <- 
  lm(
    y ~ factor(wday),
    data = d
  )

model_2 <- 
  lm(
    y ~ factor(wday) + factor(is_holiday),
    data = d
  )

ggplot(d) +
  geom_point(aes(x = date, y = res_wday), size = 3) +
  geom_point(aes(x = date, y = model_1$residuals), color = "red")
  
ggplot(d) +
  geom_point(aes(x = date, y = res_wday_is_holiday), size = 3) +
  geom_point(aes(x = date, y = model_2$residuals, color = factor(is_holiday)))

             
pacman::p_load(
  data.table,
  tidyverse,
  openxlsx,
  DT,
  plyr,
  shiny,
  visdat)

pacman::p_load(
          pacman, 
          ggplot2,
          ggeasy,
          patchwork,
          esquisse,
          glue,
          ggtext,
          showtext,
          ragg
          )

dt <- as.data.table(
  iris
)

names(dt)
dt[, 
   ntile_Sepal.Length := ntile(Sepal.Length, 10),
   by = Species]

dt_for_plot <- 
  join_all(
    list(
      dt[ntile_Sepal.Length == 10, .(mean_top = mean(Sepal.Length)), Species],
      dt[ntile_Sepal.Length == 1, .(mean_bottom = mean(Sepal.Length)), Species],
      dt[, .(mean = mean(Sepal.Length)), Species],
      dt[, .(median = median(Sepal.Length)), Species]
    ),
    by = "Species"
  )


range <- max(dt_for_plot$mean_top) - min(dt_for_plot$mean_bottom)
tick_width <- 0.004  
segment_hight <- 12

dt_for_plot %>% 
  ggplot() +
  geom_segment(
    aes(
      x = mean_bottom,
      xend = mean_top,
      y = Species,
      yend = Species
    ),
    size = segment_hight,
    color = "#45688E"
  ) +
  geom_segment(
    aes(
      x = mean,
      xend = median,
      y = Species,
      yend = Species
    ),
    size = segment_hight,
    color = "#07006F"
  ) +
  geom_segment(
    aes(
      x = mean,
      xend = mean + tick_width * range,
      y = Species,
      yend = Species
    ),
    size = segment_hight,
    color = "#1BFF00"
  ) +
  geom_segment(
    aes(
      x = median,
      xend = median - tick_width * range,
      y = Species,
      yend = Species
    ),
    size = segment_hight,
    color = "#FF9E00"
  ) +
  scale_x_continuous(
    breaks = seq(1,10,0.5)
  ) +
  theme_classic() +
  easy_remove_y_axis(what = c("ticks")) +
  easy_remove_x_axis(what = c("line", "ticks")) +
  labs(
    title = "",
    x = "",
    y = ""
  ) +
  theme(
    panel.grid.major.x = element_line(size = 0.6, colour = "gray85")
  )
  


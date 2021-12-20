renderPlot({
  # create
  range <- max(data_for_plot()$mean_top) - min(data_for_plot()$mean_bottom)
  tick_width <- 0.004  
  
  g <- 
    data_for_plot() %>% 
    ggplot() +
    geom_segment(
      aes_string(
        x = "mean_bottom",
        xend = "mean_top",
        y = input$x,
        yend = input$x
      ),
      size = input$m_segment_size,
      color = input$m_segment_color
    ) +
    geom_segment(
      aes_string(
        x = "mean",
        xend = "median",
        y = input$x,
        yend = input$x
      ),
      size = input$m_segment_size,
      color = input$i_segment_color
    ) +
    geom_segment(
      aes(
        x = mean,
        xend = mean + input$line_size * range,
        y = get(input$x),
        yend = get(input$x)
      ),
      size = input$m_segment_size,
      color = input$mean_color
    ) +
    geom_segment(
      aes(
        x = median,
        xend = median - input$line_size * range,
        y = get(input$x),
        yend = get(input$x)
      ),
      size = input$m_segment_size,
      color = input$median_color
    ) +
    scale_x_continuous(
      breaks = scales::pretty_breaks(n = input$grid_break)
    ) +
    theme_classic() +
    easy_remove_y_axis(what = c("ticks")) +
    easy_remove_x_axis(what = c("line", "ticks")) +
    labs(
      title = glue("asironim of {input$y} by {input$x}"),
      subtitle = "",
      x = "",
      y = ""
    ) +
    ### theming ----
  theme(
    # panel and grid
    plot.background = 
      element_rect(
        fill = input$plot_background_color
      ),
    panel.background = 
      element_rect(
        fill = input$panel_background_color,
        size = 0.5, 
        linetype = "solid"
      ),
    
    panel.grid.major.x = element_line(size = input$grid_size, colour = input$grid_color),
    
    # labs
    plot.title = 
      element_text(
        color="black", size=input$title_size, face="bold"
      ),
    plot.subtitle = 
      element_text(
        size = input$subtitle_size ,color="black", face="bold", hjust = 0.05
      ),
    axis.text = 
      element_text( 
        color="black", 
        face = "bold",
        size = input$axis_size
      ),
    axis.ticks = element_blank() 
    
  )
  
  
  if(input$add_text == "no"){
    g
  } else{
    g + 
      geom_text(
        aes(
          x = mean_bottom,
          y = get(input$x),
          label = scales::comma(mean_bottom, accuracy = 0.01)
        ),
        hjust = 1 + input$geom_text_hjust,
        fontface = "bold",
        size = input$geom_text_size
      ) + 
      geom_text(
        aes(
          x = mean_top,
          y = get(input$x),
          label = scales::comma(mean_top, accuracy = 0.01)
        ),
        hjust = -1* input$geom_text_hjust,
        fontface = "bold",
        size = input$geom_text_size
      ) 
  }
  
})

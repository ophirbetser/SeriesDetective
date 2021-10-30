plot3 <- 
  ggplot(iris) +
  geom_bar(aes_string(x = names(iris)[5]))
  

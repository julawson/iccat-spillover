#Examining Price Data

library(here)
library(tidyverse)

noaa <- read.csv(here("data", "foss_landings.csv"),
                  stringsAsFactors = F) 

noaa.sa <- noaa %>% 
  filter(Region.Name == "South Atlantic") %>% 
  filter(NMFS.Name == "SHARK, BLUE")

ggplot(noaa.sa, aes(x=Year, y=Dollars, color=NMFS.Name)) +
  geom_point()
  
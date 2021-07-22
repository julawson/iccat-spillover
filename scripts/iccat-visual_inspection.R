###Visual analysis of Spillover#


###Revising dataset to allow for re-use of control units###

iccat_df_short <- read.csv(here("data", "iccat_df_edited_cons.csv"),
                      stringsAsFactors = F)

#iccat_df_short$Qtydiff[is.na(iccat_df_short$Qtydiff)] <- 0

#Creating dataframes with just the control units for each treated group
iccat_df_1982 <- iccat_df_short %>% 
  filter(tacever==0) %>% 
  mutate(scaled_tacr = YearC-1982) %>%
  group_by(scaled_tacr) %>% 
  summarize(av_propStock=mean(propStock),
            av_Qty=mean(Qty_t)) %>% 
  add_column(impyear="1982")
iccat_df_1997 <- iccat_df_short %>%
  filter(tacever==0) %>%
  mutate(scaled_tacr = YearC-1997) %>% 
  group_by(scaled_tacr) %>% 
  summarize(av_propStock=mean(propStock),
            av_Qty=mean(Qty_t)) %>% 
  add_column(impyear="1997")
iccat_df_1998 <- iccat_df_short %>%
  filter(tacever==0) %>%
  mutate(scaled_tacr = YearC-1998) %>% 
  group_by(scaled_tacr) %>% 
  summarize(av_propStock=mean(propStock),
            av_Qty=mean(Qty_t)) %>% 
  add_column(impyear="1998")
iccat_df_1999 <- iccat_df_short %>%
  filter(tacever==0) %>%
  mutate(scaled_tacr = YearC-1999) %>% 
  group_by(scaled_tacr) %>% 
  summarize(av_propStock=mean(propStock),
            av_Qty=mean(Qty_t)) %>% 
  add_column(impyear="1999")
iccat_df_2001 <- iccat_df_short %>%
  filter(tacever==0) %>%
  mutate(scaled_tacr = YearC-2001) %>% 
  group_by(scaled_tacr) %>% 
  summarize(av_propStock=mean(propStock),
            av_Qty=mean(Qty_t)) %>% 
  add_column(impyear="2001")
iccat_df_2005 <- iccat_df_short %>%
  filter(tacever==0) %>%
  mutate(scaled_tacr = YearC-2005) %>% 
  group_by(scaled_tacr) %>% 
  summarize(av_propStock=mean(propStock),
            av_Qty=mean(Qty_t)) %>% 
  add_column(impyear="2005")
iccat_df_2006 <- iccat_df_short %>%
  filter(tacever==0) %>%
  mutate(scaled_tacr = YearC-2007) %>% 
  group_by(scaled_tacr) %>% 
  summarize(av_propStock=mean(propStock),
            av_Qty=mean(Qty_t)) %>% 
  add_column(impyear="2006")
#iccat_df_2013 <- iccat_df_short %>%
#  filter(tacever==0) %>%
#  mutate(scaled_tacr = YearC-2013) %>%
#  group_by(scaled_tacr) %>% 
  #summarize(av_propStock=mean(propStock)) %>% 
#  add_column(impyear="2013")
#iccat_df_2017 <- iccat_df_short %>%
#  filter(tacever==0) %>%
#  mutate(scaled_tacr = YearC-2017) %>% 
#  group_by(scaled_tacr) %>% 
  #summarize(av_propStock=mean(propStock)) %>% 
#  add_column(impyear="2017")
#iccat_df_2019 <- iccat_df_short %>%
#  filter(tacever==0) %>%
#  mutate(scaled_tacr = YearC-2019) %>% 
#  group_by(scaled_tacr) %>% 
  #summarize(av_propStock=mean(propStock)) %>%
#  add_column(impyear="2019")

iccat_df_controls <- bind_rows(iccat_df_1982,iccat_df_1997, iccat_df_1998, iccat_df_1999,iccat_df_2001,iccat_df_2005, iccat_df_2006)

###Moved this part over from the main Rmarkdown###

iccat_controlunits <- iccat_df_controls %>% 
  add_column(tac_group = "0") #%>% 
#  filter(scaled_tacr >=-5 & scaled_tacr <=5)

iccat_controlunits$impyear <- as.character(iccat_controlunits$impyear)

iccat_treatedunits <- read.csv(here("data", "iccat_df_edited_cons.csv"),
                               stringsAsFactors = F)

iccat_treatedunits <- iccat_df_short %>% 
  filter(tacever=="1") %>% 
  select(scaled_tacr, yearTACimp, SpeciesStock, propStock, Qty_t) %>% 
  group_by(yearTACimp, SpeciesStock, scaled_tacr)
#iccat_treatedunits$Qtydiff[is.na(iccat_treatedunits$Qtydiff)] <- 0
iccat_treatedunits <- iccat_treatedunits %>% 
  summarize(av_propStock=mean(propStock),
            av_Qty=mean(Qty_t)) %>%
  #  rename(impyear=yearTACimp) %>% 
  select(scaled_tacr, av_propStock, av_Qty, SpeciesStock) %>% 
  add_column(tac_group = "1")

iccat_timeline <- full_join(iccat_treatedunits,iccat_controlunits)

#Figure showing average catch proportion of treated (red) and control (grey) stocks with 0 indicating the TAC implementation year. Each grey line represents the average proportion of control stocks zeroed to a given TAC year, whereas each red line represents the average proportion of each treated stock.

ggplot() +
  theme_bw()+
  geom_line(data = iccat_treatedunits, aes(x = scaled_tacr, y = av_propStock, color = SpeciesStock)) + 
  geom_line(data = iccat_controlunits, aes(x = scaled_tacr, y = av_propStock, color = impyear)) +
  scale_colour_manual(values=c("#696969","#696969","#696969","#696969","#696969", "#696969", "#696969", "#e31a1c", "#e31a1c", "#e31a1c", "#e31a1c")) +
  #theme(legend.position =  "none") +
  xlab("TAC Implementation Year") +
  ylab("Mean Proportion of Catch") +
  geom_vline(xintercept = 0,linetype = "longdash", colour="darkgrey")

#ggsave(plot = last_plot(),
#       filename = here("visuals", "av_propStock_cons.png"),
#       width = 5,
#       height = 3)

#Figure showing average total volumes caught for treated (red) and control (grey) stock with 0 indicating the TAC implementation year.

ggplot() +
  theme_bw()+
  geom_line(data = iccat_treatedunits, aes(x = scaled_tacr, y = av_Qty, color = SpeciesStock)) + 
  geom_line(data = iccat_controlunits, aes(x = scaled_tacr, y = av_Qty, color = impyear)) +
  scale_colour_manual(values=c("#696969","#696969","#696969","#696969","#696969", "#696969", "#696969", "#e31a1c", "#e31a1c", "#e31a1c", "#e31a1c")) +
  #theme(legend.position =  "none") +
  xlab("TAC Implementation Year") +
  ylab("Total Volume of Catch (t)") +
  geom_vline(xintercept = 0,linetype = "longdash", colour="darkgrey")

###Looking at average proportions for each group.

iccat_controlunits_a <- iccat_df_controls %>% 
  filter(scaled_tacr >=-5 & scaled_tacr <=0) %>% 
  group_by(impyear) %>% 
  summarize(meanPropStock5yr = mean(av_propStock)) %>% 
  add_column(time=-1) %>% 
  rename(SpeciesStock=impyear)

iccat_controlunits_b <- iccat_df_controls %>% 
  filter(scaled_tacr >=0 & scaled_tacr <=5) %>% 
  group_by(impyear) %>% 
  summarize(meanPropStock5yr = mean(av_propStock)) %>% 
  add_column(time=1)%>% 
  rename(SpeciesStock=impyear)

iccat_df_final_reg <- iccat_df_short %>% 
  filter(scaled_tacr >=-5 & scaled_tacr <=0) %>% 
  filter(SpeciesStock!="BSH.ATN") %>% 
  group_by(SpeciesStock) %>% 
  summarize(meanPropStock5yr = mean(av_propStock)) %>% 
  add_column(time=-1)

iccat_df_final_regb <- iccat_df_short %>% 
  filter(scaled_tacr >=0 & scaled_tacr <=5) %>% 
  filter(SpeciesStock!="BSH.ATN") %>% 
  group_by(SpeciesStock) %>% 
  summarize(meanPropStock5yr = mean(av_propStock)) %>% 
  add_column(time=1)

combo<-bind_rows(iccat_df_final_reg,iccat_df_final_regb, iccat_controlunits_a, iccat_controlunits_b)

ggplot(data = combo, aes(x = time, y = meanPropStock5yr, color = SpeciesStock)) +
  theme_bw()+
  geom_point() +
  geom_line() +
  xlab("TAC Implementation Year") +
  ylab("Mean Proportion of Catch (5 year)") #+
 # scale_colour_manual(values=c("#B0C4DE","#B0C4DE","#B0C4DE","#B0C4DE","#B0C4DE", "#B0C4DE", "#B0C4DE", "#B0C4DE", "#B0C4DE", "#B0C4DE", "#00BFFF", "#00BFFF", "#00BFFF", "#00BFFF", "#00BFFF", "#00BFFF", "#00BFFF", "#00BFFF","#00BFFF", "#00BFFF", "#00BFFF", "#00BFFF", "#00BFFF","#00BFFF")) +
 # theme(legend.title =  element_blank())

#ggsave(plot = last_plot(),
#       filename = here("visuals", "av_propStock_5yrav.jpg"),
#       width = 5,
#       height = 3)
  

ggplot() +
  theme_bw()+
  geom_line(data = iccat_df_final_reg, aes(x = scaled_tacr, y = meanPropStock5yr, color = SpeciesStock)) +
  geom_line(data = iccat_df_final_regb, aes(x = scaled_tacr, y = meanPropStock5yr, color = SpeciesStock), linetype = 2) +
  geom_line(data = iccat_controlunits, aes(x = scaled_tacr, y = av_propStock, color = impyear)) +
  geom_vline(xintercept = 0,linetype = "longdash", colour="darkgrey") +
  #scale_colour_manual(values=c("#B0C4DE","#B0C4DE","#B0C4DE","#B0C4DE","#B0C4DE", "#B0C4DE", "#B0C4DE", "#B0C4DE", "#B0C4DE", "#B0C4DE", "#00BFFF", "#0000FF", "#00BFFF", "#0000FF", "#00BFFF", "#0000FF", "#00BFFF", "#0000FF","#00BFFF", "#0000FF", "#0000FF", "#00BFFF", "#0000FF","#0000FF")) +
  theme(legend.position =  "none") +
  xlab("TAC Implementation Year") +
  ylab("Mean Proportion of Catch") 

#ggsave(plot = last_plot(),
       #filename = here("visuals", "av_propStock_5yr.png"),
       #width = 5,
      #height = 3)


#Trying to get to the bottom of why there appears to be spillover for longhaul fleets under constraining TACs.
#Overall averages across groups based on YearC.
iccat_df_controls <- iccat_df_short %>% 
  filter(tacever==0) %>% 
  filter(tac_any==1) %>% 
  group_by(YearC) %>% 
  summarize(av_propStock=mean(propStock),
            av_Qty=mean(Qty_t)) %>% 
  add_column(group="Control") %>% 
  filter(YearC >= 1970 & YearC <= 2012)

iccat_df_treated <- iccat_df_short %>% 
  filter(tacever==1) %>% 
  filter(tac_any==1) %>% 
  group_by(YearC) %>% 
  summarize(av_propStock=mean(propStock),
            av_Qty=mean(Qty_t)) %>% 
  add_column(group="Treated") %>% 
  filter(YearC >= 1970 & YearC <= 2012)

combined <- bind_rows(iccat_df_controls, iccat_df_treated)

ggplot() +
  theme_bw()+
  geom_line(data = combined, aes(x = YearC, y = av_Qty, color=group))

library(tidyverse)
library(scryr)
library(formattable)
library(DT)



old_file <- prep_decklist("Deck - my_deck.txt") %>% 
  mutate(old_deck = "YES") %>% 
  rename(old_deck_number = number)
new_file <- prep_decklist("Deck - upgraded_deck.txt")%>% 
  mutate(new_deck = "YES")

tab <- full_join(old_file, new_file) %>% 
  mutate(
    old_cards = if_else(old_deck == "YES", card_name, ""),
    new_cards = if_else(new_deck == "YES", card_name, "")
  ) %>% 
  select(old_cards, new_cards, type, cmc, prices)



datatable(tab %>% 
            filter(type == "Spells") %>% 
            arrange(cmc, prices) %>% 
            select(-type, -cmc))

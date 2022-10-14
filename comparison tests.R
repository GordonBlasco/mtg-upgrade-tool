library(tidyverse)
library(scryr)
library(DT)


source("functions.R")
old_file <- prep_decklist("Deck - my_deck.txt") %>% 
  mutate(old_deck = "YES") %>% 
  rename(old_deck_number = number)
new_file <- prep_decklist("Deck - upgraded_deck.txt")%>% 
  mutate(new_deck = "YES")

tab <- full_join(old_file, new_file) %>% 
  mutate(
    old_cards = if_else(old_deck == "YES", card_name, ""),
    new_cards = if_else(new_deck == "YES", card_name, ""),
    deck = case_when(
      old_deck == "YES" & new_deck == "YES" ~ "both",
      old_deck == "YES" & is.na(new_deck) ~ "old",
      is.na(old_deck) & new_deck == "YES" ~ "new"
    )
  ) %>% 
  mutate(
    card_name = if_else(is.na(old_cards), new_cards, old_cards)
  ) %>% 
  select(card_name, type, cmc, prices, deck) 

write_csv(tab, "test_data.csv")

datatable(tab %>% 
            filter(type == "Spells") %>% 
            arrange(cmc, prices) %>% 
            select(-type, -deck))

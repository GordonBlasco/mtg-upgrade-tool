
get_card_data <- function(name) {
  card_raw <- scryr::scry_card_name(name)
  cmc <- card_raw$cmc
  type_line <- card_raw$type_line
  
  if (is.null(card_raw$prices[[1]]$usd)) {
    price <- NA
  } else {
    price <- card_raw$prices[[1]]$usd
  }
  
  
  df <- data.frame("cmc" = cmc,
                   "prices" = price,
                   "type_line" = type_line)
  
  return(df)
  
}


prep_decklist <- function(path_to_deck) {
  
  df <- read_lines(path_to_deck) %>% 
    as.data.frame() %>% 
    separate(1, into = c("number", "card_name"), sep = " ", extra = "merge") %>% 
    filter(!is.na(card_name)) %>% 
    mutate(
      scryr_info = map_dfr(.x = card_name,
                           .f = get_card_data)) %>% 
    unnest_wider(scryr_info) %>% 
    mutate(
      type = case_when(str_detect(type_line, "Creature") ~ "Creatures",
                       str_detect(type_line, "Land") ~ "Lands",
                       str_detect(type_line, "Instant") ~ "Spells",
                       str_detect(type_line, "Sorcery") ~ "Spells",
                       str_detect(type_line, "Artifact") ~ "Artifacts",
                       str_detect(type_line, "Enchantment") ~ "Enchantments",
                       str_detect(type_line, "Planeswalker") ~ "Planeswalkers",
                       str_detect(type_line, "Basic Land") ~ "Basic Lands"))
  
  return(df)
  
}




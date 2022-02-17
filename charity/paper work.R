
# Load the dataset --------------------------------------------------------

chks <- readr::read_csv("chickenn.csv", col_types = cols(X23 = col_skip()))
# Relevel factors ---------------------------------------------------------

chks %<>% 
  drop_na(labid) %>% 
  mutate(
    across(amp:tzp, ~fct_relevel(.x, "Susceptible", "Intermediate", "Resistant")),
    esbl = fct_relevel(esbl, "Negative", "Positive"),
    site = fct_collapse(site, "Sukuumu" = "Fati Seidu Sukuumu")
  )


# Label the variables -----------------------------------------------------

Hmisc::label(chks, self = F) <- codebk$label

# Save file as rds --------------------------------------------------------

write_rds(chks, file = "chickenn.rds")

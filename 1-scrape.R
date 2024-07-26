library(rvest)
library(dplyr)

# URL of the webpage
url <- "https://www.nifc.gov/fire-information/nfn"

# Read the HTML content from the webpage
webpage <- read_html(url)

# Extract the table with the ID 'year-to-date'
table <- webpage %>%
  html_node("table#year-to-date") %>%
  html_table(fill = TRUE)

# Print the extracted table
print(table)

# Clean and format the table
cleaned_table <- table %>%
  # Rename columns
  rename(
    Date = X1,
    Fires = X2,
    Acres = X3
  )%>%
  # Remove unnecessary text and convert to numeric where appropriate
  mutate(
    Fires = as.numeric(gsub("[^0-9]", "", Fires)),
    Acres = as.numeric(gsub("[^0-9]", "", Acres))
  )

# Write csv
write.csv(cleaned_table,"outputs/total_fires.csv", row.names = FALSE)

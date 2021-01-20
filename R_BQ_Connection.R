# Call libraries and set required options
library(tibble)
library(glue)
library(bigrquery)
library(DBI)
options(scipen = 20)


# Define global variables 
BILLING_PROJECT = "BILLING_PROJECT"
PROJECT_NAME = "PROJECT_NAME"
DATASET_NAME = "DATASET_NAME"
TABLE_NAME = "TABLE_NAME"

# Establish connection with BigQuery
con <- dbConnect(
  bigrquery::bigquery(),
  project = PROJECT_NAME,
  dataset = DATASET_NAME,
  billing = BILLING_PROJECT
)
bq_auth(path = "PATH_TO_SA_JSON")
# Write SQL call to grab the table
sql_call <- glue("SELECT * FROM `{PROJECT_NAME}.{DATASET_NAME}.{TABLE_NAME}`")

# Execute the call and download the dataset as a tibble
BQ_data <- dbGetQuery(con, sql_call) %>% as_tibble()

# View the head of the dataset
head(BQ_data)
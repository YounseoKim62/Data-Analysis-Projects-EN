library(dplyr)
library(tidyverse)

attorneys <- read.csv('C:/Users/leo/Desktop/DataFest/attorneys.csv')
attorneytimeentries <- read.csv('C:/Users/leo/Desktop/DataFest/attorneytimeentries.csv')
categories <- read.csv('C:/Users/leo/Desktop/DataFest/categories.csv')
clients <- read.csv('C:/Users/leo/Desktop/DataFest/clients.csv')
subcategories <- read.csv('C:/Users/leo/Desktop/DataFest/subcategories.csv')
questions <- read.csv('C:/Users/leo/Desktop/DataFest/questions.csv')


# count max Category by unique Attorney
at_cat_count <-
  questions %>%
  group_by(TakenByAttorneyUno, Category) %>%
  dplyr::summarise(count = n()) %>%
  arrange(desc(count)) %>%
  slice(1) %>%
  dplyr::rename(AttorneyUno = TakenByAttorneyUno) %>%
  select("AttorneyUno", Category)

# count max SubCategory by unique Attorney
at_subcat_count1 <-
  questions %>%
  group_by(TakenByAttorneyUno, Subcategory) %>%
  dplyr::summarise(count = n()) %>%
  arrange(desc(count)) %>%
  slice(1) %>%
  dplyr::rename(AttorneyUno = TakenByAttorneyUno, Subcategory1 = Subcategory) %>%
  select("AttorneyUno", Subcategory1)

# count second largest SubCategory by unique Attorney
at_subcat_count2 <-
  questions %>%
  group_by(TakenByAttorneyUno, Subcategory) %>%
  dplyr::summarise(count = n()) %>%
  arrange(desc(count)) %>%
  slice(2) %>%
  dplyr::rename(AttorneyUno = TakenByAttorneyUno, Subcategory2 = Subcategory) %>%
  select("AttorneyUno", Subcategory2)

# count third largest Subcategory by unique Attorney
at_subcat_count3 <-
  questions %>%
  group_by(TakenByAttorneyUno, Subcategory) %>%
  dplyr::summarise(count = n()) %>%
  arrange(desc(count)) %>%
  slice(3) %>%
  dplyr::rename(AttorneyUno = TakenByAttorneyUno, Subcategory3 = Subcategory) %>%
  select("AttorneyUno", Subcategory3)

# number of cases by each attorney
number_of_cases <-
  questions %>%
  group_by(TakenByAttorneyUno) %>%
  dplyr::summarise(NumberofCases = n()) %>%
  dplyr::rename(AttorneyUno = TakenByAttorneyUno)

# Calculate total hours for each Attorney
attorneyHours <-
  attorneytimeentries %>%
  group_by(AttorneyUno) %>%
  dplyr::summarise(TotalHours = sum(Hours))

# select tables of AttorneyUno, StateAbbr, County
stateabbr_county_attorney <-
  attorneys %>%
  select(AttorneyUno, StateAbbr, County)

# Join Everything
joined_table <-
  at_cat_count %>%
  left_join(at_subcat_count1, by = c("AttorneyUno" = "AttorneyUno")) %>%
  left_join(at_subcat_count2, by = c("AttorneyUno" = "AttorneyUno")) %>%
  left_join(at_subcat_count3, by = c("AttorneyUno" = "AttorneyUno")) %>%
  left_join(attorneyHours, by = c("AttorneyUno" = "AttorneyUno")) %>%
  left_join(number_of_cases, by = c("AttorneyUno" = "AttorneyUno")) %>%
  left_join(stateabbr_county_attorney, by = c("AttorneyUno" = "AttorneyUno"))

# 60% 90% 100%
quantile(joined_table$TotalHours, probs = c(0.60, 0.90, 1.0), na.rm = TRUE)
quantile(joined_table$NumberofCases, probs = c(0.60, 0.90, 1.0), na.rm = TRUE)

# give level for total hours
joined_table <-
  joined_table %>%
  mutate(TotalHoursLevel = ifelse(TotalHours < 3, 1, ifelse(TotalHours <= 20.7, 2, 3)))

# replace na value to 1
joined_table$TotalHoursLevel <-
  replace(joined_table$TotalHoursLevel, is.na(joined_table$TotalHoursLevel), 1)

# give level for number of cases
joined_table <-
  joined_table %>%
  mutate(NumberOfCasesLevel = ifelse(NumberofCases < 6, 1, ifelse(NumberofCases <= 43, 2, 3)))

# create a new mean level and clean data.
joined_table <-
  joined_table %>%
  mutate(Level = (TotalHoursLevel + NumberOfCasesLevel)/2)



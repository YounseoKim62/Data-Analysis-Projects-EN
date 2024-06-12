# loading packages
library(tidyverse)
library(plyr)
library(dplyr)

# loading data
attorneys <- read.csv('C:/Users/leo/Desktop/DataFest/attorneys.csv')
attorneytimeentries <- read.csv('C:/Users/leo/Desktop/DataFest/attorneytimeentries.csv')
categories <- read.csv('C:/Users/leo/Desktop/DataFest/categories.csv')
clients <- read.csv('C:/Users/leo/Desktop/DataFest/clients.csv')
questionposts <- read.csv('C:/Users/leo/Desktop/DataFest/questionposts.csv')
questions <- read.csv('C:/Users/leo/Desktop/DataFest/questions.csv')
statesites <- read.csv('C:/Users/leo/Desktop/DataFest/statesites.csv')
subcategories <- read.csv('C:/Users/leo/Desktop/DataFest/subcategories.csv')

## Clients

# create test data
clients <- clients[sample(30000), ]

# convert it to numeric value 
clients$AnnualIncome = as.numeric(clients$AnnualIncome)
clients$AllowedIncome = as.numeric(clients$AllowedIncome)
clients$CheckingBalance = as.numeric(clients$CheckingBalance)
clients$SavingsBalance = as.numeric(clients$SavingsBalance)
clients$InvestmentsBalance = as.numeric(clients$InvestmentsBalance)


# join clients and statesites for AllowedAssets
statesites_selected <- 
  statesites %>%
  select(StateAbbr, AllowedAssets)

clients <-
  clients %>%
  left_join(statesites_selected, by = c("StateAbbr" = "StateAbbr"))

# If AnnualIncome is NA, all other asset variables are also NA
clients <- 
  clients %>% 
  filter(!is.na(AnnualIncome))

# make a variable that is sum of every assets
clients$sum_assest <- rowSums(clients[, c('CheckingBalance', 'SavingsBalance', 'InvestmentsBalance')], na.rm = TRUE)

# classifying Pro Bono by Income
for (i in 1:nrow(clients)) {
  if (clients$AnnualIncome[i] > clients$AllowedIncome[i]) {
    clients$ProBono_income[i] <- "N"
  } else if (clients$AnnualIncome[i] <= clients$AllowedIncome[i]) {
    clients$ProBono_income[i] <- "Y"
  }
}

# classifying Pro Bono by Assets (if someone is NA, tell em to put their value, so they can be classified as Pro Bono and get help)
for (i in 1:nrow(clients)) {
  if (is.na(clients$AllowedAssets[i])) {
    clients$ProBono_assets[i] <- 'NAA'
  } else if (is.na(clients$CheckingBalance[i]) & is.na(clients$SavingsBalance[i]) & is.na(clients$InvestmentsBalance[i])) {
    clients$ProBono_assets[i] <- 'NC'
  } else if (clients$sum_assest[i] > clients$AllowedAssets[i]) {
    clients$ProBono_assets[i] <- 'N'
  } else if (clients$sum_assest[i] <= clients$AllowedAssets[i]) {
    clients$ProBono_assets[i] <- 'Y'
  }
}

# classifying ProBono by both Income and Assets (for the states without AllowedAssests standard, we decided it with just Income)
clients$ProBono_Final <- NA

for (i in 1:nrow(clients)) {
  if (clients$ProBono_income[i] == 'Y' & clients$ProBono_assets[i] == 'Y') {
    clients$ProBono_Final[i] <- 'Y'
  } else if (clients$ProBono_income[i] == 'N') {
    clients$ProBono_Final[i] <- 'N'
  } else if (clients$ProBono_assets[i] == 'N') {
    clients$ProBono_Final[i] <- 'N'
  } else if (clients$ProBono_assets[i] == 'NC') {
    clients$ProBono_Final[i] <- 'NC'
  } else if (clients$ProBono_income[i] == 'Y' & clients$ProBono_assets[i] == 'NAA') {
    clients$ProBono_Final[i] <- 'Y'
  }
}

write.csv(x = clients, file = "C:/Users/leo/Documents/clients_cleaneddata.csv")
getwd()

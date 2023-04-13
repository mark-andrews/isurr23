
# Create the data vectors -------------------------------------------------


composites <- c(4, 6, 8, 9, 10, 12)

composites_plus_one <- composites + 1

composites_minus_one <- composites - 1

# Create the data frames ---------------------------------------------------


# The following command creates a data frame ....
data_df2 <- data.frame(
  name = c('bob', 'ann', 'sue'), # this is the first name of the person
  age = c(23, 25, 19),
  # this next line is their gender as stated in a survey
  gender = c('male', 'female', 'female'),
  occupation = c('dr', 'dr', 'bar'),
  income = c(10000, 100000, 1000000))

data_df_01b <- read_csv("https://raw.githubusercontent.com/mark-andrews/isurr23/main/content/data/data01.csv")

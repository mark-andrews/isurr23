library(tidyverse)

weight_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/isurr23/main/content/data/weight.csv")

glimpse(weight_df)

summary(weight_df)

summarise(weight_df, 
          average_height = mean(height), 
          stdev_height = sd(height),
          variance_height = var(height))

summarise(group_by(weight_df, gender), 
          average_height = mean(height), 
          stdev_height = sd(height),
          variance_height = var(height))        


# Let's talk about "the pipe"

log(sqrt(abs(-42))) # nested functions

# rewritten as a chain
abs(-42) %>% sqrt() %>% log()

-42 %>% abs() %>% sqrt() %>% log()

group_by(weight_df, gender) %>% 
  summarise(average_height = mean(height), 
            stdev_height = sd(height),
            variance_height = var(height),
            n = n())

# Missing values ----------------------------------------------------------

data_df <- tibble(x = c(1, NA, 1, 2, 3),
                  z = c('x', '1', NA, NA, NA),
                  y = c(1, 1, 2, NA, NA))

# Number of missing values per each variable
summarise(data_df, across(everything(), ~sum(is.na(.))))


# Select columns ----------------------------------------------------------

select(weight_df, gender, height, weight)

select(weight_df, starts_with('height'))

select(weight_df, contains('eight'))

select(weight_df, gender, starts_with('weight'))

select(weight_df, gender:age)

select(weight_df, 3:5)


# Rename ------------------------------------------------------------------

rename(weight_df, id = subjectid, sex = gender)


# Slice -------------------------------------------------------------------

slice(weight_df, 101:110)
slice(weight_df, c(10, 20, 50, 100))
slice(weight_df, -c(10, 20, 50, 100))



# Filter ------------------------------------------------------------------

filter(weight_df, gender == 'Male')

filter(weight_df, height >= 180)

filter(weight_df, height >= median(height))

filter(weight_df, gender == 'Male', height >= median(height))
filter(weight_df, gender == 'Male' & height >= median(height))
filter(weight_df, gender == 'Male' | height > median(height))


filter(weight_df, gender == 'Male') %>% 
  filter(height >= median(height))



# Create new variables with mutate ----------------------------------------

mutate(weight_df, is_tall = height > 180)

mutate(weight_df, x = height^2 / sqrt(age))

mutate(weight_df, bmi = weight / (height/100)^2)

mutate(weight_df, subjectid = as.factor(subjectid))



# sorting with arrange ----------------------------------------------------

arrange(weight_df, height)

arrange(weight_df, age, height)

arrange(weight_df, desc(height))



weight_df %>% 
  select(gender, weight, height) %>% 
  filter(gender == 'Male', height > 180) %>% 
  arrange(desc(height)) %>% 
  slice(1:5)



# Data visualize ----------------------------------------------------------

ggplot(weight_df, 
       aes(x = height, y = weight)
) + geom_point(size = 0.5) + 
  theme_classic()


ggplot(weight_df, 
       aes(x = height, y = weight, colour = gender)
) + geom_point(size = 0.5) + 
  theme_classic()

ggplot(weight_df, 
       aes(x = height, y = weight)
) + geom_point(size = 0.5) + 
  stat_smooth(method = 'lm') +
  theme_classic()

ggplot(weight_df, 
       aes(x = height, y = weight, colour = gender)
) + geom_point(size = 0.5, alpha = 0.1) + 
  stat_smooth(method = 'lm') +
  theme_classic()

# histogram
ggplot(weight_df,
       aes(x = height)
) + geom_histogram(binwidth = 5, colour = 'white')


ggplot(weight_df,
       aes(x = height, fill = gender)
) + geom_histogram(binwidth = 5, 
                   colour = 'white')

ggplot(weight_df,
       aes(x = height, fill = gender)
) + geom_histogram(binwidth = 5, 
                   position = 'dodge',
                   colour = 'white')

ggplot(weight_df,
       aes(x = height, fill = gender)
) + geom_histogram(binwidth = 5, 
                   alpha = 0.75,
                   position = 'identity',
                   colour = 'white')

# Tukey boxplots

ggplot(weight_df,
       aes(x = gender, y = weight)
) + geom_boxplot(outlier.colour = 'red')



# Simple linear regression ------------------------------------------------

result <- lm(weight ~ height, data = weight_df)
summary(result)

result1 <- lm(weight ~ height + age + gender, data = weight_df)
summary(result1)

anova(result, result1)

result2 <- lm(weight ~ height * gender, data = weight_df)

confint(result1, level = 0.99)

weight_df_pred <- tibble(height = 180, age = 25, gender = 'Male')

predict(result1, newdata = weight_df_pred)
predict(result1, newdata = new_data, interval = 'conf', level = 0.99)

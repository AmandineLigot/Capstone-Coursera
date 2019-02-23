

# Coursera Data Science Capstone

This repository gathers the scripts used to build a next word prediction algorithm.

The corpus used to build the algorithm can be found in: [Corpus](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip)

Only the English corpus was used to build the algorithm.

First of all, the corpus was sampled to get 50% of the Twitter data, 50% of the news data and 50% of the blog data. This is done with the code called **sampling.R**.

After this step, the n-grams are built. 5-grams to 1-gram are built using the code **preparation dataset.R**.
Profanities were removed using the file **en**.

Then the function **sbo5** uses a stupid backoff model to give the next word prediction.

The slide deck can be found [here](http://rpubs.com/aligot/470170)

The Shiny app can be found [here](https://amandineligot.shinyapps.io/Capstone/)

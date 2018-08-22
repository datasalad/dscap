Data Science Specialization Capstone Project
========================================================
author: Sergii Sorokolat
date: 8/22/2018
autosize: true

Next Word Prediction based on Ngram language model and Stupid Backoff Algorithm

Executive summary
========================================================


- The goal of the project is to build an algorithm that predicts the next word based on user's input (words, sentences, phrases)
- The predictive model was built using Ngram language model from Natural Language Processing
- The training data for the model is 30% random sample from the original dataset provided by SwiftKey
- The final data product was implemented as a Shiny App

Language model
========================================================
- The original dataset contains 4269678 lines of text (102080240 words) from Twitter, news and blogs
- Data cleansing stage included removing special characters, numbers, punctuation and profanity words
- The model utilizes the combination of 2-6 Ngrams built from the preprocessed dataset
- The app implements Stupid Backoff smoothing method introduced by Google


Reference: 
[Large Language Models in Machine Translation](https://www.aclweb.org/anthology/D07-1090.pdf)

Algorithm
========================================================
The algorithm is inexpensive to train on large data sets and approaches the quality of Kneser-Ney Smoothing as the amount of training data increases, so:
- It gives model good accuracy
- It requires fewer computer resources compared to other methods, e.g. Katz' Backoff Model

Scoring function:

$S(w_i|w_{i-k+1}^{i-1}) = \Bigg\{\begin{align*} \frac{f(w_{i-k+1}^i)}{f(w_{i-k+1}^{i-1})}  \quad   if \quad f(w_{i-k+1}^i) > 0 \\   \alpha S(w_i|w_{i-k+2}^{i-1}) \quad\quad otherwise\end{align*}$

Backoff factor $\alpha$ was set to 0.4 based on Google recommendations.



Data product
========================================================

- The app is hosted on shinyapps.io and can be found here:
https://datasalad.shinyapps.io/shinappdscapstone/

- The app is fairly simple to use. Just type in a few words or a sentence and hit 'Predict'. The suggested next word will show up. 

![Data Product](app.png)

Thanks for your time!

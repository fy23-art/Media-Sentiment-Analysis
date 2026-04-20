# Media-Sentiment-Analysis
A Statistical Analysis of the Relationship Between Pre-Match Social Media Sentiment and Soccer Team Performance

The purpose of this project is to investigate a potential link between pre-match social
media sentiment and in-game soccer performance. Motivated by the rise of social
media and an interest in sports analytics, this study sets out to solve a specific question:
"Can the collective mood of fans online predict on-field outcomes?"
The primary goal is to determine if the average sentiment of fan tweets in the 24 hours
before a match has a statistically significant relationship with a team's performance,
after accounting for key confounding variables. The effects of particular interest are the
relationship between sentiment and both the binary match result (win/loss) and a
continuous measure of attacking performance, Expected Goals (xG).

The conceptual foundation for this project was built upon background reading in two key
areas: advanced soccer analytics and social psychology. My background knowledge on
this topic comes from reading on expected goals (xG) models from Statsbomb and
studies on "social contagion," which suggest group emotions can influence outcomes. I
explored Natural Language Processing (NLP) tools to quantify fan sentiment from social
media. I selected the VADER (Valence Aware Dictionary and sEntiment Reasoner)
model, which is a lexicon and rule-based model specifically designed for analyzing
informal language in social media texts like tweets. It works by scoring words,
emoticons, slang, capitalization, punctuation, and degree modifiers (e.g., "very good").
For each tweet, it outputs a compound sentiment score ranging from -1 (most negative)
to +1 (most positive), which was then averaged per match. The average of these scores
for all tweets in the 24 hours preceding a match served as the primary explanatory
variable.


The analysis plan was designed to answer the research question through a
two-pronged statistical approach:
1. A logistic regression model was used to test if pre-match sentiment could predict the
binary outcome of a match (Win/Loss), while controlling for opponent strength and
venue (home/away).
log(odds of Win) = β0 + β1
(Avg_Sentiment) + β1
(Opponent_Strength)+ β3
(Venue)
2. A multiple linear regression model was used to test for a relationship between
pre-match sentiment and the continuous performance metric, Expected Goals (xG),
again controlling for the same confounding variables such as home field advantage and
opponent level.
xG = β0 + β1
(Avg_Sentiment) + β1
(Opponent_Strength)+ β3
(Venue) + ϵ
where ϵ∼N(0, σ^2)
The goals of the study would be answered by examining the statistical significance
(using a threshold of p < 0.05) and the confidence intervals of the sentiment coefficient.


Data for this study was collected from two primary sources to create a merged dataset
linking pre-match sentiment with in-game performance:
- Soccer Performance Data: Match logs for Manchester United's 2023-2024 season
were sourced from FBref.com. For each match, the key variables extracted were: Date,
Opponent, Venue (Home/Away), Result (Win/Loss/Draw), Goals For (GF), Goals
Against (GA), and the crucial performance metric, Expected Goals (xG).
- Fan Sentiment Data: Using the **Twitter (X) API, tweets containing the handles
"@ManUtd" OR the hashtag "#MUFC" were collected from the 24-hour window
immediately preceding each match's kickoff.


The raw data were processed to create the final explanatory variables:
- avg_sentiment (Continuous): The compound sentiment score for each tweet, calculated
using the VADER model, was averaged across all tweets for a given match, resulting in
a single value between +1 and -1.
- opponent_Strength (Continuous): A derived variable representing the quality of the
opposition, quantified by the opponent's final points total in the league table.
- venue (Categorical): A binary variable indicating whether the match was played at
Home (1) or Away (0).


I also proposed the following response variables:
- win (Binary Response): The match result was converted into a binary outcome where a
Win = 1 and a Loss or Draw = 0.
- xG (Continuous Response): The team's Expected Goals for the match, representing the
quality of attacking chances created.




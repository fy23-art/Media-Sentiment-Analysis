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


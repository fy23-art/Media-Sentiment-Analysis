#3. Data Analysis
team_data <- read.csv("C:/Users/freya/Downloads/STAT410/data/final_raw_data.txt")
head(team_data)

# Load required libraries
library(ggplot2)
library(gridExtra)
library(lmtest)
library(car)

#3.3 Preliminary Data Examination
str(team_data)
if(is.character(team_data$Venue)) {
  team_data$Venue <- as.factor(team_data$Venue)
}

# Distribution of Match Outcomes
ggplot(team_data, aes(x = Win)) +
  geom_bar(fill = c("red", "darkgreen"), alpha = 0.7) +
  labs(title = "Distribution of Match Outcomes",
       x = "Win (1 = Win, 0 = Loss/Draw)", 
       y = "Count") +
  theme_minimal()

# Distribution of Expected Goals (xG)
ggplot(team_data, aes(x = xG)) +
  geom_histogram(fill = "steelblue", alpha = 0.7, bins = 15) +
  labs(title = "Distribution of Expected Goals (xG)",
       x = "Team xG", 
       y = "Frequency") +
  theme_minimal()

# Sentiment vs Expected Goals
ggplot(team_data, aes(x = Avg_Sentiment, y = xG)) +
  geom_point(alpha = 0.6, color = "purple") +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(title = "Sentiment vs Expected Goals",
       x = "Average Pre-Match Sentiment", 
       y = "Team xG") +
  theme_minimal()


# Analysis I: Logistic Regression for Match Outcome
# Fit logistic regression model
logit_model <- glm(Win ~ Avg_Sentiment + Opponent_Strength + Venue, 
                   data=team_data, family=binomial)
# Model summary
summary(logit_model)
# Odds ratios with confidence intervals
odds_ratios <- exp(cbind(OR = coef(logit_model), confint(logit_model)))
print(round(odds_ratios, 3))
# Model significance tests
anova(logit_model, test="Chisq")


# Analysis II: Linear Regression for Expected Goals
# Fit linear regression model
lm_model <- lm(xG ~ Avg_Sentiment + Opponent_Strength + Venue, data=team_data)
# Comprehensive model summary
summary(lm_model)
confint(lm_model)
# Diagnostic plots
par(mfrow=c(2,2))
plot(lm_model, which=1:4)
title("Linear Regression Diagnostic Plots", outer=TRUE, line=-1)

# Formal Assumption Tests
# Normality test
shapiro.test(residuals(lm_model))
# Homoscedasticity test
bptest(lm_model)
# Autocorrelation test
dwtest(lm_model)
# Multicollinearity check
vif(lm_model)


# Effect Visualization and Final Interpretation

# Q-Q plot for normality confirmation
qqnorm(residuals(lm_model), main="Q-Q Plot: Normality of Residuals")
qqline(residuals(lm_model), col="red")

# Partial effect plot for sentiment
avPlots(lm_model, "Avg_Sentiment", 
        main="Partial Effect of Sentiment on xG",
        ylab="xG (adjusted for other predictors)")

# CORRECTED: Prediction plot with confidence bands
# Check what levels Venue has
print(levels(team_data$Venue))

# Use the correct factor level for prediction
new_data <- data.frame(
  Avg_Sentiment = seq(min(team_data$Avg_Sentiment), 
                      max(team_data$Avg_Sentiment), length=50),
  Opponent_Strength = mean(team_data$Opponent_Strength),
  Venue = "Home"  # Use character/factor level instead of numeric
)

# If Venue is factor, make sure new_data matches
if(is.factor(team_data$Venue)) {
  new_data$Venue <- factor(new_data$Venue, levels = levels(team_data$Venue))
}

predictions <- predict(lm_model, newdata=new_data, interval="confidence")

plot(team_data$Avg_Sentiment, team_data$xG,
     xlab="Average Pre-Match Sentiment", ylab="Expected Goals (xG)",
     main="Sentiment Effect on Expected Goals with 95% CI",
     pch=19, col=rgb(0.2,0.4,0.6,0.6))
lines(new_data$Avg_Sentiment, predictions[,"fit"], lwd=2, col="red")
lines(new_data$Avg_Sentiment, predictions[,"lwr"], lwd=1, col="red", lty=2)
lines(new_data$Avg_Sentiment, predictions[,"upr"], lwd=1, col="red", lty=2)
legend("topleft", legend=c("Observed", "Fitted", "95% CI"),
       col=c("steelblue", "red", "red"), pch=c(19, NA, NA), lty=c(NA, 1, 2))

# Reset plot parameters
par(mfrow=c(1,1))


# Effect Visualization and Final Interpretation - Two Main Plots
if(!require(car)) install.packages("car"); library(car)

# PLOT 1: Partial Effect Plot for Sentiment
if(!exists("lm_model")) {
  lm_model <- lm(xG ~ Avg_Sentiment + Opponent_Strength + Venue, data = team_data)
}

library(car)
avPlots(lm_model, "Avg_Sentiment", 
        main = "Partial Effect of Pre-Match Sentiment on Expected Goals",
        xlab = "Average Sentiment (adjusted for opponent strength & venue)",
        ylab = "Expected Goals (xG) (adjusted)",
        pch = 16, 
        col = "darkblue",
        lwd = 2,
        grid = TRUE,
        cex.lab = 1.1,
        cex.main = 1.2)

coef_sum <- summary(lm_model)$coefficients
beta_sentiment <- round(coef_sum["Avg_Sentiment", "Estimate"], 3)
p_value <- round(coef_sum["Avg_Sentiment", "Pr(>|t|)"], 3)
mtext(paste("β =", beta_sentiment, ", p =", p_value), 
      side = 3, line = 0.2, cex = 1, col = "darkred")


# PLOT 2: Prediction Plot with Confidence Bands
new_data <- data.frame(
  Avg_Sentiment = seq(min(team_data$Avg_Sentiment), 
                      max(team_data$Avg_Sentiment), length = 100),
  Opponent_Strength = mean(team_data$Opponent_Strength),
  Venue = factor("Home", levels = levels(team_data$Venue))
)

predictions <- predict(lm_model, newdata = new_data, interval = "confidence")
par(mar = c(5, 5, 4, 2) + 0.1)
plot(team_data$Avg_Sentiment, team_data$xG,
     xlab = "Average Pre-Match Sentiment", 
     ylab = "Expected Goals (xG)",
     main = "Relationship Between Pre-Match Sentiment and Expected Goals",
     pch = 19, 
     col = rgb(0.3, 0.5, 0.8, 0.8),  # Nice blue color
     cex = 1.3,
     xlim = range(team_data$Avg_Sentiment),
     ylim = range(c(team_data$xG, predictions)),
     cex.lab = 1.2,
     cex.main = 1.3,
     cex.axis = 1.1)
polygon(c(new_data$Avg_Sentiment, rev(new_data$Avg_Sentiment)),
        c(predictions[, "lwr"], rev(predictions[, "upr"])),
        col = rgb(1, 0.2, 0.2, 0.2),  # Light red shading
        border = NA)
lines(new_data$Avg_Sentiment, predictions[, "fit"], 
      lwd = 3, col = "red")

lines(new_data$Avg_Sentiment, predictions[, "lwr"], 
      lwd = 1.5, col = "red", lty = 2)
lines(new_data$Avg_Sentiment, predictions[, "upr"], 
      lwd = 1.5, col = "red", lty = 2)
legend("topleft", 
       legend = c("Observed Match Data", "Fitted Regression Line", "95% Confidence Interval"),
       col = c("steelblue", "red", "red"),
       pch = c(19, NA, NA),
       lty = c(NA, 1, 2),
       lwd = c(NA, 3, 1.5),
       pt.cex = c(1.3, NA, NA),
       bg = "white",
       cex = 1)
rsq <- round(summary(lm_model)$r.squared, 3)
adj_rsq <- round(summary(lm_model)$adj.r.squared, 3)

eq_text <- paste0("Regression: xG = ", 
                  round(coef_sum["(Intercept)", "Estimate"], 2), 
                  " + ", 
                  round(coef_sum["Avg_Sentiment", "Estimate"], 3), 
                  " × Sentiment")

mtext(eq_text, side = 1, line = 3.8, cex = 1, col = "darkblue")
mtext(paste0("Model Fit: R² = ", rsq, ", Adjusted R² = ", adj_rsq), 
      side = 1, line = 4.8, cex = 1, col = "darkblue")
if(p_value < 0.001) {
  sig_text <- "*** p < 0.001"
} else if(p_value < 0.01) {
  sig_text <- "** p < 0.01"
} else if(p_value < 0.05) {
  sig_text <- "* p < 0.05"
} else {
  sig_text <- paste0("p = ", p_value)
}

mtext(paste("Sentiment effect:", sig_text), 
      side = 3, line = 0.3, cex = 1, col = "darkred")

# Reset plot parameters
par(mar = c(5, 4, 4, 2) + 0.1)


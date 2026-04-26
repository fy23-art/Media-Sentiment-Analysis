# FairPlay: Auditing Sentiment Bias in Sports Analytics

### Project Overview

This repository contains a complete statistical analysis investigating whether pre-match social media sentiment predicts soccer team performance. The analysis uses **Manchester United's 2023-24 season** data, combining:

- **Performance data** (Expected Goals / xG, match outcomes) from FBref.com
- **Fan sentiment data** from Twitter/X API, scored using the VADER NLP model

**Key finding:** Pre-match sentiment does NOT predict win/loss outcomes, but it DOES have a statistically significant positive relationship with Expected Goals (β = 0.448, p = 0.044).

### Why This Is an *Ethical AI* Project

This is not just a sports analytics project. It is an **audit** — a template for asking critical questions about predictive models deployed in the wild:

- If a sports betting company deployed a sentiment model, what biases would be embedded?
- Does sentiment data overrepresent certain fan bases (English-language, platform-specific, time-zone biased)?
- Should models include a "model card" disclosing data provenance and limitations?

This project applies the **ACM Code of Ethics** (Principles 1.2 Avoid Harm, 1.3 Be Honest and Trustworthy) to demonstrate responsible predictive modeling.

### Intended Audience

| Audience | How They Use This |
|----------|-------------------|
| Sports data journalists | A template for auditing claims about "social media predicts performance" |
| Analytics bloggers | A model card example for their own predictive work |
| Students | A case study in statistical ethics + regression modeling |
| Bettors (unintended) | A cautionary tool — sentiment alone is insufficient for betting decisions |

### Repository Structure
fairplay-sentiment-audit/
├── README.md # You are here
├── code/
│ └── sentiment_analysis.R # Full R code (logistic + linear regression)
├── data/
│ └── README.md # Data provenance and privacy statement
├── docs/
│ ├── MODEL_CARD.md # Complete model documentation
│ ├── ETHICS_STATEMENT.md # ACM Code application (300+ words)
│ └── USER_GUIDE.md # How to run the analysis
├── outputs/
│ ├── histogram_xG.png # Distribution of Expected Goals
│ ├── sentiment_vs_xG.png # Correlation plot
│ ├── logistic_summary.txt # Odds ratios and coefficients
│ ├── lm_diagnostics.png # 2x2 diagnostic plots (Q-Q, residuals)
│ └── prediction_plot.png # Final sentiment-xG plot with 95% CI
└── .gitignore


### Key Findings (From Your Analysis)

#### Logistic Regression (Win/Loss)

| Variable | Coefficient | p-value | Significant? |
|----------|-------------|---------|---------------|
| Avg_Sentiment | 0.841 | 0.420 | ❌ No |
| Opponent_Strength | -0.039 | 0.001 | ✅ Yes |
| Venue (Home) | 1.092 | 0.026 | ✅ Yes |

**Interpretation:** Pre-match sentiment does NOT predict whether a team wins or loses. Traditional factors (opponent quality, home advantage) dominate.

#### Linear Regression (Expected Goals / xG)

| Variable | Coefficient | p-value | 95% CI | Significant? |
|----------|-------------|---------|--------|---------------|
| Avg_Sentiment | 0.448 | 0.044 | [0.012, 0.884] | ✅ Yes |
| Opponent_Strength | -0.021 | 0.0002 | — | ✅ Yes |
| Venue (Home) | 0.155 | 0.460 | — | ❌ No |

**Model fit:** R² = 0.421, Adjusted R² = 0.37, F(3,34) = 8.24, p < 0.001

**Interpretation:** Each one-unit increase in pre-match sentiment is associated with a **+0.448 increase in Expected Goals** — a moderate, statistically robust effect.

### Diagnostic Checks (All Passed)

| Test | Result | p-value | Status |
|------|--------|---------|--------|
| Shapiro-Wilk (normality) | W = 0.966 | 0.289 | ✅ Pass |
| Breusch-Pagan (homoscedasticity) | BP = 0.804 | 0.849 | ✅ Pass |
| Durbin-Watson (autocorrelation) | DW = 1.796 | 0.312 | ✅ Pass |
| VIF (multicollinearity) | All < 2.2 | — | ✅ Pass |

### Ethical Limitations (Must Read)

This audit does **not** claim:

- Causation (sentiment → performance). The relationship is correlational.
- Generalizability beyond Manchester United, one season.
- Freedom from sampling bias (Twitter/X users are not all fans).

**What this audit *does* provide:** A reproducible, transparent, ethically documented example of how to report predictive models with appropriate caveats.

### How to Run This Code

1. Clone the repository
2. Open `code/sentiment_analysis.R` in RStudio
3. Install required packages:
   ```r
   install.packages(c("ggplot2", "gridExtra", "lmtest", "car"))

# Model Card: FairPlay Sentiment Auditor

## Model Details
- **Type:** Logistic regression (Win) + Linear regression (xG)
- **Date:** April 2026
- **Developer:** Freya

## Intended Use
- **Primary:** Auditing bias in sports sentiment models
- **Secondary:** Educational demonstration of ethical ML
- **Out-of-scope:** Real betting decisions, player evaluation

## Factors
- **Reported:** Venue (Home/Away), Opponent Strength
- **Unreported but potentially biasing:** Language of sentiment source, time zone effects, platform bias (X vs Reddit)

## Metrics
- **Logistic:** Coefficients, odds ratios, p-values, Chi-squared test
- **Linear:** R², adj R², residual diagnostics

## Ethical Evaluation (ACM Code 1.2, 1.3)
- The model does not directly cause harm, but could mislead if published without: (1) data provenance, (2) uncertainty quantification, (3) acknowledgment of sentiment sampling bias.
- Recommendation: Any deployment must include a public model card.

## Limitations
- Correlation ≠ causation. Sentiment may reflect media hype, not team quality.
- Sentiment source not documented in current code.

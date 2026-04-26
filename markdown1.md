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

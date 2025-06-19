# 🏡 Ames Housing Price Prediction – Hackathon Winning Project

This repository contains the code and output of a predictive modeling project developed for the BU Hackathon 2025. Our team won 1st place for designing a robust classification model to predict whether the sale price of a house would be above or below the median, using over 80 features from the Ames housing dataset.

## 🎯 Objective

To build a classification model that identifies whether a property will sell for **above** or **below** the median price based on structural, geographic, and economic attributes.

## 📦 Dataset

- **Source**: Ames Housing dataset
- **Size**: ~2,930 observations
- **Features**: 80+ engineered variables (e.g., square footage, location, year built)

## 🔍 Feature Selection

We used and compared three different feature selection methods:
- **Boruta**
- **Lasso Regularization**
- **Gain Ratio**

These helped reduce dimensionality while maintaining performance.

## 🤖 Models Evaluated

We trained and evaluated the following models using R:
- Generalized Linear Model (GLM)
- Random Forest (RF)
- Support Vector Machine (SVM)
- Neural Networks (NNET)
- Naive Bayes
- XGBoost

To address class imbalance, we applied **SMOTE** and under-sampling techniques.

## 📈 Results

- Evaluated using **F1 Score**, **ROC AUC**, and **True Positive Rate**
- Target TPR for “Yes” class (above median) was > 84%
- Visual performance comparison included in the HTML report

## 📂 Files

- `1_model.Rmd`: R Markdown source file with code and analysis
- `Hackathon Ames Prediction.html`: Final report with results, visualizations, and model comparisons

## 🛠 Tools Used

- R, tidyverse, caret, SMOTE, Boruta, xgboost
- R Markdown for reproducible analysis

## 🏅 Outcome

🏆 **1st Place** – BU Hackathon 2025  
Our model demonstrated strong performance and practical interpretability, making it a scalable solution for real estate pricing predictions.

---

## 📬 Contact

**Katherine Ruiz**  
[LinkedIn](https://www.linkedin.com/in/kat-ruiz-q/) • [GitHub](https://github.com/kat2309)

# Stock Prediction Project
* Programming Languages and Tools: Python (pandas, numpy, matplotlib, imblearn, scikit-learn, xgboost)
* Technologies Used: EDA, Data Preprocessing, Machine Learning

<br/>

## [Project Introduction]
* Project for the Machine Learning course in Spring 2024
* Predicted whether the stock prices of companies listed on NASDAQ had increased or decreased over the past year using one year of financial indicators.

<br/>

## Step 1: EDA

<br/>

### [Data Inspection]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/68b44d07-3e9a-420d-81fa-4381f7d4ec93)

* There are 3,138 companies and 229 variables.
* The 'Name' variable does not play an important role in the machine learning model.
* The 'Sector' variable is the only categorical variable; the rest are all numerical variables.
* The 'Class' variable is the target variable.
* Each variable contains NA values.
  * Some companies (e.g., CBH) have no values entered except for 'Name', 'Sector', and 'Class', which needs to be addressed.
* In the financial indicators, 'operatingProfitMargin' should be formatted as a percentage, but in the dataset, it's only indicated as 1 or NA, so it needs to be removed.

<br/>

### [Statistical Summary]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/db206e4b-8723-4b6f-a7b1-ddae62337c4f)

* From the statistical summary table and box plots, we can see that the scale of values varies greatly between variables.
* Significant differences in value scales between variables can affect the stability of the machine learning model and need to be addressed.

<br/>

### [Missing Values]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/a65cf719-490b-4cac-9156-f1c470eef5cd)
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/13f15b3d-d5cf-4e36-b4b0-c1e2545e4f8f)

* All variables except 'Sector', 'Name', and 'Class' have missing values.
* Missing values can affect the performance of machine learning, so they need to be handled.

<br/>

### [Imbalance of Target Variable]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/f8be6cdd-1cc2-4419-bbe6-34b0c43dc703)

* The imbalance of the target variable can cause the machine learning model to overfit to the minority class, reducing performance.
* In this project, we use AUC-ROC, which is relatively less sensitive to the distribution of the target variable, so no additional preprocessing is performed.

<br/>

## Step 2: Data Preprocessing

<br/>

### [Removal and Handling of Missing Values]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/83a39fcb-fa34-427f-9fc2-b3f7834d5055)
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/00b1ea7f-bb33-4c6c-9ba0-1c35f0fb4bbe)

* Removed 221 companies that had NA values in all variables except 'Name', 'Sector', and 'Class'.

<br/>

![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/a33622e1-f7b1-4877-a9a2-ddfc838fc374)

* Removed variables with more than 50% missing values: 'operatingCycle', 'cashConversionCycle', 'shortTermCoverageRatios', and 'operatingProfitMargin', which is presumed to have incorrectly entered values.

<br/>

![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/793613e2-b023-453c-8cde-e435a5dc379d)

* Converted the categorical variable 'Sector' into a binary vector form to handle missing values using the KNN algorithm.
* All categorical variables need to be converted into binary vector form for machine learning.

<br/>

![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/eeb100d2-45de-4aaf-98b1-4dfc7631bd3c)

* KNNImputer finds the 5 nearest neighbors of a missing value and replaces the missing value with the mean of those neighbors. This allows handling missing values while maintaining the data pattern.

<br/>

### [Data Standardization]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/af5f10ff-e88e-4d39-83f7-5dc1d196340a)

* Although standardization is not mandatory since we plan to use a decision tree-based model later, we improved the model's stability through standardization because there are many variables and the scale of values varies greatly between variables.

<br/>

### [Data Splitting]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/0f192f61-8839-44bf-bc45-b4afda8b84ad)

* For machine learning training, we split the training dataset into an X_train dataset containing only explanatory variables and a y_train dataset containing only the target variable.

<br/>

### [Feature Selection]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/28708656-2e68-4d30-8fb5-4b2b07812464)
![Group 15](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/3ba2b2d0-0b46-4379-8b9c-37df59a946ac)

* After training the preprocessed dataset on an XGBoost model without hyperparameter tuning, we optimized the model's performance by generating a Gini feature importance plot and removing features with a Gini score of 1.5 or less.

<br/>

## Step 3: Machine Learning (XGBoost)

<br/>

### [Hyperparameter Tuning]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/a66c0583-a6ff-47eb-9cf8-86d54605e7dc)

* Set various values for XGBoost parameters:
  * **learning_rate**: The step size for updating model weights; larger values learn faster but are less precise.
  * **max_depth**: Increases model complexity to learn more detailed patterns.
  * **n_estimators**: Number of trees in the ensemble; each tree corrects the errors of previous trees.
* Tested all combinations through GridSearchCV and saved the parameter combination with the highest ROC AUC score.

<br/>

### [Prediction]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/a39e6e91-d4eb-4de9-a73c-b7460064ec9e)

* Predicted the results of the test dataset using the parameter combination that achieved the highest ROC AUC score.

<br/>

### [Score (ROC AUC)]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/a47bb48e-4799-4151-9d1a-ba950a94ec12)

* The ROC AUC value is 0.61, which means the model correctly predicts companies whose stock prices have risen with a probability of 61% and incorrectly predicts with a probability of 39%.
* The model performs slightly better than random guessing but is not good enough to be used in actual trading.
* Since investor sentiment, market volatility, and unexpected events have a significant impact on stock prices, it is difficult to predict stock price fluctuations with simple mathematical modeling alone.

# Text Classification Project
* Programming Languages and Tools: Python (pandas, numpy, nltk, scikit-learn, xgboost)
* Technologies Used: Data Preprocessing, Machine Learning

<br/>

## [Project Introduction]
* Project for the Machine Learning course in Spring 2024
* Classified text from medical diagnostic charts into one of six categories using classification algorithm models.

<br/>

## Step 1: Data Preprocessing

<br/>

### [Converting to Lowercase and Removing Special Characters]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/e2cde325-479a-4aa1-a969-a9c666cb9a21)

* Mixing uppercase and lowercase letters can cause the same word to be recognized differently, so we standardize words like 'The' and 'the' to lowercase to ensure they are recognized the same.
* Special characters often do not provide meaningful information and are therefore removed.

<br/>

### [Removing Stop Words]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/ecb835d1-596a-4bca-afab-364a5c8d9d3a)

* Stop words do not provide meaningful information and are therefore removed.
* By removing stop words, the model can focus more on meaningful words, making it easier to identify patterns and relationships that are better suited for classification tasks.

<br/>

### [Lemmatization]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/602f1bc9-3d0c-4390-b140-d97e8cb41e66)

* Since the text data is related to actions such as symptoms reported by patients and records of treatments received, we lemmatize words into their verb forms.
* By consistently processing words transformed into various forms into their base verb forms, we can remove duplicate words with the same meaning and noise, thereby improving the model's performance.

<br/>

### [Vectorizing (TF-IDF)]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/96e79673-224e-4747-8648-070e4973d3bd)

* TF-IDF tokenizes the text, evaluates the importance of words, calculates their importance within the document, and converts this into vectors.
* Example: (0, 258) 0.06596 means that the importance of the 258th word in the first document is 0.06596 (range: 0 ~ 1).

<br/>

## Step 2: Machine Learning (Stacking Algorithm)

<br/>

### [Creating the Stacking Algorithm Model]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/0f706a78-83f2-4e05-a41c-1c091b13006f)

* Since text data requires consideration of word order, meaning, context, etc., we use a stacking algorithm that can improve prediction accuracy by combining the strengths of multiple models.
* Logistic Regression captures the linear relationships in text data well; XGBoost explains the nonlinear relationships in complex text data effectively; Naive Bayes Classifier can classify text data simply and effectively.
* Logistic Regression is a relatively simple model, so it has a low risk of overfitting the training data and is used as the meta model.

<br/>

### [Hyperparameter Tuning]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/36c1f4cc-7a64-496c-8b13-b884705f2966)

* Set various values for the parameters of Logistic Regression and XGBoost used in the stacking algorithm:
  * lr__C: Adjusts the strength of regularization to prevent overfitting.
  * xgb__learning_rate: The step size for updating model weights; larger values learn faster but are less precise.
  * xgb__max_depth: Increases the complexity of the model to learn more detailed patterns.
  * xgb__n_estimators: Number of trees in the ensemble; each tree corrects the errors of the previous tree.
* Tested all combinations through GridSearchCV and saved the parameter combination that resulted in the highest f1_weighted score.

<br/>

### [Prediction]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/571ce30f-672d-47f8-a303-129db0c503c3)

* Predicted the results of the test dataset using the parameter combination that achieved the highest f1_weighted score.

<br/>

### [Score (Mean F-1 Score)]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/d3c79428-4cdb-4e0b-968d-a0921437d019)

* The Mean F-1 score is 0.85, which means the model achieved high precision (85% of the cases classified as True by the model are actually True) and high recall (the model predicts 85% of the cases that are actually True).
* This indicates that the model effectively identifies actual positive cases with few False Positives (false alarms) and few misses of True Positives (misses).

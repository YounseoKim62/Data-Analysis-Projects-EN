## Younseo Kim's Data Science Portfolio

This is the project portfolio of **Younseo Kim**, who dreams of becoming a data analyst.

---

### Stock Prediction Project Summary

**Programming Languages and Tools**: Python (pandas, numpy, matplotlib, KNNImputer, StandardScaler, scikit-learn, xgboost, GridSearchCV)  
**Technologies Used**: EDA, Data Preprocessing, Machine Learning  

#### Project Introduction
- **Duration**: Final project for the Machine Learning course in Spring 2024
- **Description**: Predicted stock price increases or decreases of companies listed on NASDAQ using one year of financial indicators

#### Main Steps
1. **Exploratory Data Analysis (EDA)**
   - Analyzed a dataset consisting of 3,138 companies and 229 variables
   - Identified issues of target variable imbalance and scale differences among variables
   - Found missing values in all variables except 'Name', 'Sector', and 'Class'

2. **Data Preprocessing**
   - Removed variables with many missing values and those containing incorrect data
   - Encoded categorical variables and replaced missing values using the KNN algorithm
   - Improved model stability through data standardization
   - Removed less important features using XGBoost feature importance

3. **Machine Learning Modeling (XGBoost)**
   - Found the optimal parameter combination through hyperparameter tuning
   - Trained the model using GridSearchCV
   - Final model's ROC AUC score: 0.61

#### Results
- Achieved an ROC AUC score of 0.61, slightly better than random guessing
- Recognized the complexity and limitations of stock price prediction; confirmed that accurate predictions are difficult with simple mathematical modeling alone

#### Reflections
- Careful observation is necessary as datasets may contain missing values or incorrectly entered variable values
- Learned that there are various methods for handling missing values beyond mean or median imputation
- Recognized the need for standardization or normalization when dealing with many variables with significantly different scales (however, depending on the machine learning algorithm used, choose either standardization or normalization)

#### [Stock Prediction Project Report](https://github.com/YounseoKim62/Data-Analysis-Projects-EN/blob/7f2e4aade66733d2c93859fe0f26228c1051390e/Stock%20Prediction%20Project/stock_prediction.md)
---

### Text Classification Project Summary

**Programming Languages and Tools**: Python (pandas, numpy, nltk, WordNetLemmatizer, TfidfVectorizer, scikit-learn, LogisticRegression, MultinomialNB, xgboost, StackingClassifier, GridSearchCV)  
**Technologies Used**: Data Preprocessing, Machine Learning  

#### Project Introduction
- **Duration**: Midterm project for the Machine Learning course in Spring 2024
- **Description**: Classified text from medical diagnostic charts into one of six categories using classification algorithm models

#### Main Steps
1. **Data Preprocessing**
   - Converted text to lowercase and removed special characters
   - Removed stop words to allow the model to focus on important words
   - Reduced noise by lemmatizing words to handle different word forms consistently
   - Vectorized text data using TF-IDF

2. **Machine Learning Modeling (Stacking Algorithm)**
   - Used a stacking algorithm combining Logistic Regression, XGBoost, and Naive Bayes Classifier
   - Found the optimal parameter combination through hyperparameter tuning
   - Trained the model using GridSearchCV
   - Final model's Mean F-1 score: 0.85

#### Results
- Achieved a Mean F-1 score of 0.85, demonstrating high precision and recall
- The model effectively identified actual positive cases with few false positives and negatives

#### Reflections
- Was able to experience the overall preprocessing steps for text data, which was my first time handling such data
- Realized that the preprocessing steps can vary depending on the form of the text data (how the text is stored)
- Had the opportunity to use an ensemble method, the Stacking Algorithm, to classify complex text data

#### [Text Classification Project Report](https://github.com/YounseoKim62/Data-Analysis-Projects-EN/blob/3a3dc695fb2df4048fcc443eb7d0fce822318de3/Text%20Classification%20Project/text_classification.md)
---

### DataFest (Data Competition) 2023 Summary

**Award**: The American Statistical Association DataFest - Best in Show (2023)  
**Team**: Team Megabyte (Younseo Kim, Yong Jun Choi, Woosung Lim, Hyeongkwon Kim, Taehwan Lee)  
**Programming Languages and Tools**: R (tidyverse, dplyr, ggplot2), Tableau, Excel, Figma  
**Technologies Used**: EDA, Data Preprocessing, Algorithm Development, Prototype UI/UX Design  

#### Project Introduction
- **Duration**: 2023.03.25 ~ 2023.03.26
- **Description**: Improved the efficiency of the association's free legal aid consultation services by utilizing over 500,000 client data records, 20,000 lawyer data records, and over 300,000 consultation records from the American Bar Association

#### Main Steps
1. **Determining Client Eligibility for Free Legal Services**
   - Developed an algorithm to determine client eligibility by integrating state-specific criteria for free legal services with asset and income variables
   - Data Preprocessing: Converted categorical variables to numerical, merged datasets, handled missing values
   - Algorithm Development: Implemented logic to determine eligibility for free legal services based on income and asset criteria

2. **Efficient Lawyer and Client Matching**
   - Matched clients and lawyers efficiently by considering lawyers' specialties, number of consultations, and consultation times
   - Data Preprocessing: Merged lawyer and consultation record data, created variables for specialties and consultation counts
   - Algorithm Development: Implemented logic to assess lawyers' expertise based on consultation times and counts

3. **Analysis of Legal Consultation Trends in the U.S.**
   - Identified the most consulted legal categories by state through analysis of legal consultation data
   - Found that consultations were frequent in categories like family and children, others (injury, natural disaster, immigration, taxes), housing and homelessness
   - Analyzed trends in legal consultation categories over time: identified increasing trends in certain categories during the pandemic

4. **Real-world Prototype Implementation**
   - Developed a prototype for determining client eligibility for free legal services and matching clients with lawyers
   - Enabled recommending lawyers matching the legal category of the client's requested consultation and allowed for an overview of lawyers' specialties and consultation performance

#### Results
- Improved the effectiveness of free legal aid consultation services by enhancing the efficiency of client eligibility determination and lawyer matching
- Enhanced resource allocation efficiency through analysis of legal consultation trends, optimizing resource management for the Bar Association

#### Reflections
- Realized that datasets used in practice are not as neatly organized as those used in class
   - Often divided into multiple tables, stored as categorical variables despite being numeric, or variable names are abbreviated in hard-to-understand formats
- The core point of data analysis is how to interpret data and derive meaningful insights through visualization or machine learning
- Learned that respecting and listening to various opinions while collaborating with team members and accepting criticism can lead to better outcomes

#### [DataFest2023 Report](https://github.com/YounseoKim62/Data-Analysis-Projects-EN/blob/ffbaef17b8273f4b04e37e325a0fa8d45eb50026/DataFest2023/DataFest2023.md)
---

### Performance of Arsenal and Tottenham Against Big 6 Clubs: A Goals-Based Analysis (2009-2019)

**Programming Languages and Tools**: R (tidyverse, ANOVA)  
**Technologies Used**: EDA, Data Preprocessing, ANOVA Analysis  

#### Project Introduction
- **Objective**: Analyzed the performance of Arsenal and Tottenham against Premier League Big 6 clubs from 2009 to 2019
- **Main Research Questions**:
  1. Does the location of the match (home/away) affect performance?
  2. Are there changes in performance by season?
  3. Which team performed better against Big 6 clubs?

#### Main Steps
1. **Data Collection and Preprocessing**
   - Collected match data where Arsenal and Tottenham played against Big 6 clubs (Chelsea, Liverpool, Manchester City, Manchester United) during the 2009-2019 seasons
   - Organized data including home/away, opponent, number of goals scored, etc.

2. **Exploratory Data Analysis (EDA)**
   - Analyzed goal statistics for each team based on home/away games
   - Created graphs and statistical analyses to understand performance changes by season

3. **ANOVA Analysis**
   - Evaluated the impact on performance by analyzing the interaction effects of team, location, and season
   - Verified key assumptions (normality, homoscedasticity, independence, sphericity)

#### Results
1. **Home/Away Match Effect**
   - Confirmed that the interaction between team and location is statistically significant through ANOVA analysis
   - However, could not derive significant results from pairwise comparisons between teams, indicating a need for further research

2. **Performance Changes by Season**
   - The effect of season on performance is not statistically significant
   - Arsenal and Tottenham maintained relatively consistent performance

3. **Comparison Between Teams**
   - The performance difference between Arsenal and Tottenham is not statistically significant
   - Both teams recorded similar performance against Big 6 clubs

#### Limitations and Future Research
- **Limitations**: Absence of Random Effect, selection of only two teams, lack of control for confounding variables
- **Future Research**: Incorporate Random Effect, analyze more teams and seasons, explore methods to control for confounding variables

#### [Performance of Arsenal and Tottenham Against Big 6 Clubs: A Goals-Based Analysis](https://github.com/YounseoKim62/Data-Analysis-Projects-EN/blob/3f5d63d71dea293c03fea2544070ee5306dd6e6c/Performance%20of%20Arsenal%20and%20Tottenham%20Against%20Big%206%20Clubs%3A%20A%20Goals-Based%20Analysis%20(2009-2019)/Performance-of-Arsenal-and-Tottenham-Against-Big-6-Clubs-A.pdf)

---


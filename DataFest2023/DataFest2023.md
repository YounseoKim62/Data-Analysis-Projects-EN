# The American Statistical Association DataFest - Best in Show Award (2023)
* Team Megabyte (Younseo Kim, Yong Jun Choi, Woosung Lim, Hyeongkwon Kim & Taehwan Lee)
* 2023.03.25 ~ 2023.03.26
* Programming Languages and Tools: R (tidyverse, dplyr, ggplot2), Tableau, Excel, Figma
* Technologies Used: EDA, Data Preprocessing, Algorithm Development, Prototype UI/UX Design

<br/>

## [Project Introduction]
* A project that improved the efficiency of the association's free legal aid consultation services by utilizing over 500,000 client records, 20,000 lawyer records, and over 300,000 consultation records provided by the American Bar Association.

<br/>

## Step 1: Determining Client Eligibility for Free Legal Services

<br/>

### [Problem]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/0a999767-1408-43e4-9921-9e934a314d7a)

* The criteria for free legal services differ by state.
* To receive free legal services, clients must meet both asset and income criteria, and related variables are separated, making it difficult for lawyers to quickly determine whether a client meets the eligibility criteria.

<br/>

### [Data Preprocessing]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/8f389c0d-3dc0-4e4a-b14c-e733799a2cd8)

![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/0cd50bdb-bcd6-4a71-abc9-af242cb1e94a)

1. In the 'clients' dataset, when 'AnnualIncome' (income variable) is NULL, the asset-related variables are also all NULL, so **we remove clients whose 'AnnualIncome' is NULL**.
2. The variables related to assets and income in the 'clients' dataset are stored as categorical variables, so we **convert them to numeric variables**.
3. Using the 'StateAbbr' variable in the 'clients' dataset, we **LEFT JOIN** with the 'statesites' (dataset containing state-specific free legal service criteria) to create a unified dataset.
4. *(Since the competition organizers mentioned that clients often did not fill in asset-related variables instead of entering 0, we consider NULL values as 0 only for clients who have filled in at least one asset-related variable)* <br/> We create a **'sum_assets' derived variable** that combines the asset-related variables in the 'clients' dataset into one variable.

<br/> 

### [Algorithm Development]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/64cb43c4-19ac-4c9f-9607-6429093e605b)

1. **Income Criteria**:
   * If 'AnnualIncome' is less than 'AllowedIncome', we store 'ProBono_income' as 'Y'; if higher, as 'N'.

2. **Asset Criteria**:
   * For clients from states not in the 'statesites' (state-specific free legal criteria dataset), we store 'ProBono_assets' as 'NAA (No Allowed Assets)'.
   * If all asset-related variables are NULL, we store 'ProBono_assets' as 'NC (Not Classified)'.
   * If 'sum_assets' is less than 'AllowedAssets', we store 'ProBono_assets' as 'Y'; if higher, as 'N'.

3. **Final Determination**:
   * If both 'ProBono_income' and 'ProBono_assets' are 'Y', we store 'ProBono_final' as 'Y'.
   * If either 'ProBono_income' or 'ProBono_assets' is 'N', we store 'ProBono_final' as 'N'.
   * If 'ProBono_income' is 'Y' and 'ProBono_assets' is 'NAA', we store 'ProBono_final' as 'Y'. (Since there are states without asset criteria for free legal services)
   * Regardless of 'ProBono_income', if 'ProBono_assets' is 'NC', we store 'ProBono_final' as 'NC'.

<br/> 

## Step 2: Efficient Lawyer and Client Matching

<br/> 

### [Problem]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/2b281ef6-1fcf-43c9-8df4-91df789ba9bc)

![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/06b28e1b-fd7b-4ab6-ad76-e9c515a01689)

* Clients do not have factors to assess the lawyer's area of expertise and skill.
* It is difficult to grasp at a glance how many clients the lawyer has consulted so far, in which areas they have consulted the most, and how many cases they have handled.

<br/> 

### [Data Preprocessing]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/b91fb619-1363-4c9e-a09c-f61a19ef65f9)

1. In the 'questions' (consultation records dataset), we **remove records where the lawyer did not answer**. (When 'TakenByAttorneyUno' is NULL)
2. We analyze the 'Category' (specialty) and 'Subcategory' (sub-specialty) that the lawyer has most frequently answered in 'questions' and create variables in the existing 'attorneys' (lawyer dataset) that **indicate the lawyer's specialty and sub-specialty**.
3. We create a variable called **'NumberofCases'** in 'attorneys' that counts the number of consultation records the lawyer has taken in 'questions'.
4. From 'attorneytimeentries' (dataset of time spent by lawyers per consultation), we create a variable called **'TotalHours'** in 'attorneys' that sums up the total time the lawyer has spent.
* *Lawyers with all variables as NULL are only registered and have not conducted consultations.*

<br/> 

### [Algorithm Development]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/fae49738-c932-47a7-9297-56aa836132e5)

1. Calculate the cutoff values for the lower 40%, 60%, and 100% of 'TotalHours' and 'NumberofCases' to set the criteria for 'TotalHoursLevel' and 'NumberofCasesLevel'.
2. For 'TotalHours', set Level 1 for the lower 40%, Level 2 for 40% to 80%, and Level 3 for 80% to 100%; if 'TotalHours' is 0, consider it as Level 1.
3. Apply the same for 'NumberofCases' to create the 'NumberofCasesLevel' variable; if 'NumberofCases' is 0, consider it as Level 1.
4. Combine 'TotalHoursLevel' and 'NumberofCasesLevel' to create a 'Level' variable that can assess the lawyer's overall skill.

<br/> 

## Step 3: Analysis of Legal Consultation Trends in the U.S.

<br/> 

### [Most Consulted Legal Category]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/75161971-a632-4db0-b4d0-60bf2c085f4e)

* The most consulted category in the American Bar Association's free legal consultation services by state is **Family and Children**.
* This indicates that in many states, legal consultations related to family conflicts such as divorce, custody disputes, and domestic violence are prevalent.

<br/> 

### [Second Most Consulted Legal Category]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/88b2c294-08f8-4a43-b915-c1bfb03b289d)

* The second most consulted category in the American Bar Association's free legal consultation services by state is **Others**.
* The 'Others' category includes consultations related to injury, natural disasters, immigration, taxes, indicating that many states have frequent legal consultations related to daily life.

<br/> 

### [Third Most Consulted Legal Category]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/b1cecf1d-22f5-412c-a98d-13561b8622b8)

* The third most consulted category in the American Bar Association's free legal consultation services by state is **Housing and Homelessness**.
* This indicates that in several states, legal consultations related to housing stability, tenant rights, and homelessness issues are prevalent.

<br/> 

### [Trends in Legal Consultation Categories Over Time]
![trend graph](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/0edbeab7-12d9-4c7e-a84d-0b0a1442211f)

* A sharp increase in legal consultations related to family and children, others (consultations related to injury, natural disasters, immigration, taxes), housing and homelessness, labor, employment, and unemployment has been observed since early 2020.
* The increase in family and children consultations is presumed to be due to increased family conflicts as remote work increased during COVID-19.
* The increase in consultations in the 'Others' category is because COVID-19 related legal consultations were classified as natural disasters.
* The increase in housing and homelessness consultations is presumed to be due to intensified housing instability caused by economic difficulties during the pandemic.
* The increase in labor, employment, and unemployment-related consultations is presumed to be due to increased unemployment rates and changes due to remote work during the pandemic.

<br/> 

## Step 4: Real-world Prototype Implementation

<br/> 

### [Determining Client Eligibility for Free Legal Services, Efficient Lawyer and Client Matching]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/c778e406-18a9-4b4f-9fea-8dbef37a751c)

![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/9b29b63d-813d-446a-ab85-0e87abcad67a)

* By using the prototype, clients can check whether they meet the income and asset criteria for the free legal aid consultation services.
* Also, it recommends lawyers who have the legal category of the consultation requested by the client as their specialty, and allows clients to grasp at a glance how many clients the lawyer has consulted so far, in which specialty they have consulted the most, and how many cases they have handled.

<br/> 

### [Analysis of Legal Consultation Trends in the U.S.]

<br/> 

![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/16eb19c9-2492-4d11-9a9e-35236cb8e611)

![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/1edbb54a-1ad6-4b10-8684-f0a788c62b72)

* By using the prototype, lawyers can allocate their work efficiently by identifying which legal categories consultations are concentrated in, and prepare for categories that require a lot of time.
* Additionally, the Bar Association can manage resources efficiently by focusing human resources and time on categories with high consultation frequency.


## The American Statistical Association DataFest - 최우수상 수상 (2023)
* 2023.03.24 ~ 2023.03.26
* 프로그래밍 언어: R (tidyverse, dplyr, ggplot2), Excel
* 데이터 분석 기법: EDA, 데이터 전처리, 알고리즘 개

<br/>

### [프로젝트 소개]
* 미국 변호사 협회에서 제공한 데이터셋들을 활용하여 무료 법률 지원 서비스의 효율성을 개선한 프로젝트

<br/>

### [EDA] 
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/5f49c270-5572-4cfa-8786-f2de19966bf9)
* 주 (State)마다 무료 법률 서비스 기준이 다름
* 무료 법률 서비스 기준은 자산과 수입 두 가지 기준을 모두 충족해야 하며, 관련 변수들이 나뉘어져 있어 변호사들이 의뢰인이 무료 법률 서비스 기준에 부합하는지를 한눈에 판단하기 어려움

<br/>

### [데이터 전처리]
1. 자산과 수입에 관련된 변수들이 범주형 변수 (Categorical Variable)로 저장되어 있어 **숫자형 변수 (Numeric Variable)로 변환**
2. 의뢰인 데이터셋의 StateAbbr변수를 통해 주별 무료 법률 서비스 기준 데이터셋을 **LEFT JOIN하여 통합된 데이터셋 생성**
3. AnnualIncome (수입 변수)가 NULL인 경우 자산 관련 변수들도 모두 NULL이므로 **AnnualIncome이 NULL인 의뢰인들을 제거**
4. 자산과 관련된 변수들을 하나의 변수로 통합한 **sum_assest 파생변수 생성**

<br/> 

### [알고리즘 개발]
1. * 의뢰인의 AnnualIncome이 AllowedIncome (무료 법률 서비스 기준 수입)보다 낮을경우 ProBono_income을 Y로 저장
   * 의뢰인의 AnnualIncome이 AllowedIncome (무료 법률 서비스 기준 수입)보다 높을경우 ProBono_income을 N으로 저장
2. * 의뢰인의 sum_assest이 



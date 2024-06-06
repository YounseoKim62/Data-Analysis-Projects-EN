# The American Statistical Association DataFest - 최우수상 수상 (2023)
* 2023.03.24 ~ 2023.03.26
* 프로그래밍 언어: R (tidyverse, dplyr, ggplot2), Excel
* 데이터 분석 기법: EDA, 데이터 전처리, 알고리즘 개발

<br/>

## [프로젝트 소개]
* 미국 변호사 협회에서 제공한 데이터셋들을 활용하여 협회의 무료 법률 지원 서비스의 효율성을 개선한 프로젝트

<br/>

## Step 1 (의뢰인의 무료 법률 서비스 자격 판별)

<br/>

### [문제점] 
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/5f49c270-5572-4cfa-8786-f2de19966bf9)
* 주 (State)마다 무료 법률 서비스 기준이 다름
* 무료 법률 서비스 기준은 자산과 수입 두 가지 기준을 모두 충족해야 하며, 관련 변수들이 나뉘어져 있어 변호사들이 의뢰인이 무료 법률 서비스 기준에 부합하는지를 한눈에 판단하기 어려움

<br/>

### [데이터 전처리]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/dffae339-8f3b-472e-9039-20440363045f)
1. AnnualIncome (수입 변수)가 NULL인 경우 자산 관련 변수들도 모두 NULL이므로 **AnnualIncome이 NULL인 의뢰인들을 제거**
2. 자산과 수입에 관련된 변수들이 범주형 변수 (Categorical Variable)로 저장되어 있어 **숫자형 변수 (Numeric Variable)로 변환**
3. 의뢰인 데이터셋의 StateAbbr변수를 통해 주별 무료 법률 서비스 기준 데이터셋을 **LEFT JOIN하여 통합된 데이터셋 생성**
4. *(대회 진행요원이 자산과 관련된 변수들에서 의뢰인들이 0을 적는 대신 기입을 하지 않은 경우가 많다고 하여, 자산과 관련된 변수들 중 1개 이상 기입한 의뢰인들에 한해서는 NULL 값을 0으로 간주함)* <br/> 
자산과 관련된 변수들을 하나의 변수로 통합한 **sum_assets 파생변수 생성**

<br/> 

### [알고리즘 개발]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/64cb43c4-19ac-4c9f-9607-6429093e605b)
1. 수입 기준:
* AnnualIncome이 AllowedIncome보다 낮으면 ProBono_income을 'Y', 높으면 'N'으로 저장
2. 자산 기준:
* 주별 무료 법률 기준 데이터셋에 없는 주 출신의 경우 ProBono_assets를 'NAA (No Allowed Assets)'로 저장
* 자산 관련 변수들이 모두 NULL이면 ProBono_assets를 'NC (Not Classified)'로 저장
* sum_assets가 AllowedAssets보다 낮으면 ProBono_assets를 'Y', 높으면 'N'으로 저장
3. 최종 판정:
* ProBono_income과 ProBono_assets가 모두 'Y'이면 ProBono_final을 'Y'로 저장
* ProBono_income 또는 ProBono_assets 중 하나라도 'N'이면 ProBono_final을 'N'으로 저장
* ProBono_income이 'Y'이고 ProBono_assets가 'NAA'이면 ProBono_final을 'Y'로 저장 (무료 법률 서비스 기준 자산이 없는 주들이 존재)
* ProBono_income과 상관없이 ProBono_assets가 'NC'이면 ProBono_final을 'NC'로 저장

<br/> 

## Step 2 (효율적인 변호사와 의뢰인 매칭)

<br/> 

### [문제점]
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/28a52b2e-88a1-450f-a971-8805d8348e91)
* 의뢰인이 변호사의 전문 분야 또 실력을 판단할 수 있는 요소가 없음
* 변호사가 지금까지 의뢰인들과 얼마나 상담했는지, 어떤 전문 분야에서 가장 많이 상담했는지, 얼마나 많은 의뢰를 처리했는지 한 눈에 파악할 수 없음
 

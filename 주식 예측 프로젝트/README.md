# 주식 예측 프로젝트
* 프로그래밍 언어 및 도구: Python (pandas, numpy, matplotlib, imblearn, sickit-learn, xgboost)
* 활용한 기술: EDA, 데이터 전처리, 머신러닝 

<br/>

## [프로젝트 소개]
* 2024년도 봄 학기 머신러닝 수업 프로젝트
* 나스닥에 상장된 기업들의 1년치 재무와 관련된 지표들을 사용하여 지난 1년동안 기업의 주가가 상승했는지 하락했는지 예측하였음

<br/>

## Step 1 (EDA)

<br/>

### 데이터 확인
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/68b44d07-3e9a-420d-81fa-4381f7d4ec93)

* 'Name' 변수는 머신러닝 모델에서 중요한 역할을 하지 않음
* 'Sector'는 유일한 범주형 변수이며, 나머지 변수들은 모두 숫자형 변수임
* 'Class'는 목적 변수임
* 각 변수마다 NA 값들이 존재한다는 것을 확인할 수 있음
  * 몇몇 회사들 (ex. CBH)는 'Name', 'Sector', 'Class'를 제외하고는 아무 값도 입력이 되지 않았기에 후에 대처가 필요
* 재무 지표에서 'operatingProfitMargin'은 %형식으로 나와야 하지만 데이터셋에는 모두 1아니면 NA 값으로 표기되어 있기에 추후에 제거가 필요함

<br/>

### 결측치
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/a65cf719-490b-4cac-9156-f1c470eef5cd)
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/13f15b3d-d5cf-4e36-b4b0-c1e2545e4f8f)


* 'Sector', 'Name', 'Class'를 제외하고 모든 변수들이 결측치를 가지고 있음
* 결측치는 머신러닝 성능에 영향을 주기 때문에 추후에 결측치들을 대처 해야 함

<br/>

### 목적변수의 불균형
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/f8be6cdd-1cc2-4419-bbe6-34b0c43dc703)

* 목적 변수의 불균형은 머신러닝 모델이 소수의 목적변수 값에 과적합되어 머신러닝 모델의 성능을 저하시킴
* 이번 프로젝트에서는 목적변수의 분포에 상대적으로 덜 민감한 AUC-ROC를 사용하기 때문에 따로 전처리는 하지 않음

<br/>

## Step 2 (데이터 전처리)

<br/>

### 결측치 제거 및 처리
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/83a39fcb-fa34-427f-9fc2-b3f7834d5055)
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/00b1ea7f-bb33-4c6c-9ba0-1c35f0fb4bbe)

* 위와 같이 'Name', 'Sector', 'Class'를 제외한 모든 변수에 NA값이 있는 221개의 기업들을 제거

<br/>

![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/a33622e1-f7b1-4877-a9a2-ddfc838fc374)

* 변수의 결측치가 50%이상인 'operatingCycle', 'cashConversionCycle', 'shortTermCoverageRatios'와 변수의 값이 잘못 입력된것으로 추정되는 'operatingProfitMargin'을 제거

<br/>

![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/d1c8eef4-4f57-4d74-a89b-0b461c056347)

* KNN 알고리즘을 사용하여 결측치를 처리하기 위해서 범주형 변수인 'Sector'를 이진 벡터 형태로 변환
* KNNImputer는 결측값의 5개의 최근접 이웃을 찾아 이웃들의 평균값으로 결측값을 대처함, 이를 통해 데이터의 패턴을 유지하며 결측값의 처리가 가능함


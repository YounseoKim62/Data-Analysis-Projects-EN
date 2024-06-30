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

### 통계 요약
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/db206e4b-8723-4b6f-a7b1-ddae62337c4f)

* 통계 요약 표와 박스 플롯을 보면 변수마다 값의 기준이 매우 크게 차이 난다는 것을 알 수 있으므로 추후에 대처가 필요

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

![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/793613e2-b023-453c-8cde-e435a5dc379d)

* KNN 알고리즘을 사용하여 결측치를 처리하기 위해서 범주형 변수인 'Sector'를 이진 벡터 형태로 변환
* 또한 머신러닝을 사용하기 위해서는 범주형 변수를 이진 벡터 형태로 변환해야함

<br/>

![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/eeb100d2-45de-4aaf-98b1-4dfc7631bd3c)

* KNNImputer는 결측값의 5개의 최근접 이웃을 찾아 이웃들의 평균값으로 결측값을 대처함, 이를 통해 데이터의 패턴을 유지하며 결측값의 처리가 가능함

<br/>

### 데이터 표준화
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/af5f10ff-e88e-4d39-83f7-5dc1d196340a)

* 추후에 결정 트리 기반 모델을 사용 할 것이기 때문에 표준화가 필수는 아니지만, 변수가 굉장히 많고 변수마다 값의 기준이 너무 크게 차이가 나기 때문에 표준화를 하여 모델의 안정성을 향상함 

<br/>

### 데이터 분할
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/0f192f61-8839-44bf-bc45-b4afda8b84ad)

* 머신러닝 학습을 위해 학습 데이터셋을 설명변수만 있는 X_train 데이터 셋과 독립변수만 있는 y_train 데이터 셋으로 분할

<br/>

### 변수 선택
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/28708656-2e68-4d30-8fb5-4b2b07812464)
![Group 14](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/07b842bc-f172-48ab-adb9-8f1afcc83eff)

* 하이퍼 파라미터 튜닝이 되지않은 XGBoost모델에 전처리가 완료된 데이터 셋을 학습시킨 후, gini feature importance 플롯을 생성하여 gini 점수가 1.5 이하인 특징들을 제거하여 모델 성능을 최적화

<br/>

## Step 3 (머신러닝: XGBoost)

<br/>

### 하이퍼파라미터 튜닝
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/a66c0583-a6ff-47eb-9cf8-86d54605e7dc)

* XGBoost의 파라미터들을 여러 값으로 설정:
 * learning_rate: 모델 가중치를 업데이트하는 스텝 크기; 큰 값은 빠르게 학습하지만 덜 세밀함
 * max_depth: 모델의 복잡성을 증가시켜 더 세밀한 패턴을 학습 가능
 * n_estimators: 앙상블의 트리 수; 각 트리는 이전 트리의 오류를 수정
* GridSearchCV를 통해 모든 조합을 테스트하여 가장 높은 roc_auc 점수가 나온 파라미터 조합을 저장 

<br/>

### 예측
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/a39e6e91-d4eb-4de9-a73c-b7460064ec9e)

* roc_auc 점수가 가장 높게 나온 파라미터 조합을 사용하여 테스트 데이터 셋의 결과 값을 예측

<br/>

### 점수 (ROC AUC)
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/a47bb48e-4799-4151-9d1a-ba950a94ec12)

* ROC AUC의 값이 0.61로 이는 모델이 실제로 주가가 오른 기업의 61%의 확률로 올바르게 예측하고, 39%의 확률로 잘못 예측한다는 것을 알 수 있음
* 모델이 무작위 예측보다는 약간 더 나은 성능을 보이지만 실제 거래에서 사용할 만큼 좋은 성능은 아닌듯함
* 투자자들의 심리, 시장의 변동성, 예기치 않은 사건 등이 주가에 큰 영향을 미치기 때문에 단순한 수학적 모델링 만으로는 주가의 횡보를 예측하기 어려움

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
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/3d5d0db8-0e1a-41aa-b06d-036a0b5858dc)

* 'Name' 변수는 머신러닝 모델에서 중요한 역할을 하지 않음
* 'Sector'는 유일한 범주형 변수이며, 나머지 변수들은 모두 숫자형 변수임
* 'Class'는 목적 변수임
* 각 변수마다 NA 값들이 존재한다는 것을 확인할 수 있음
  * 몇몇 회사들은 'Name', 'Sector', 'Class'를 제외하고는 아무 값도 입력이 되지 않았기에 후에 대처가 필요
* 재무 지표에서 'OperatingProfitMargin'은 %형식으로 나와야 하지만 데이터셋에는 모두 1아니면 NA 값으로 표기되어 있기에 추후에 제거가 필요함

<br/>

### 결측치
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/a65cf719-490b-4cac-9156-f1c470eef5cd)
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/f3aafff6-2257-4dae-b435-530b780f1fdd)

* 'Sector', 'Name', 'Class'를 제외하고 모든 변수들이 결측치를 가지고 있음
* 결측치는 머신러닝 성능에 영향을 주기 때문에 추후에 결측치들을 대처 해야 함

<br/>

### 목적 변수의 대칭성
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/5093f1b9-01a4-4060-954e-c5d978c1015b)

* 목적 변수의 값을 막대그래프로 나타내면, 사지 않는 것을 추천하는 값이 사는 것을 추천하는 값보다 2배 이상 많다는 것을 알 수 있음
* 머신러닝 모델은 소수의 값을 무시하는 경향이 있기 때문에, 사지 않는 것을 추천하는 값 쪽으로 편향될 수 있
* 따라서 추후에 목적 변수의 균형을 맞춰야 함을 알 수 있음

<br/>

### 통계 요약
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/4dd77144-c6f2-454b-b64e-f78deae63d28)
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/443141fe-0878-4a3a-be38-9af2a73c396f)

* 통계 요약표를 살펴보았을 때, 변수들 간의 최소값과 최대값이 크게 차이남을 확인할 수 있
* 첫 10개의 변수를 박스 플롯으로 시각화한 결과, 'Revenue Growth'나 'R&D Expenses'와 같은 변수들은 명확하게 나타나지 않
* 이는 각 변수들의 범위가 다름을 의미하며, 추후 변수들의 표준화가 필요함

<br/>

### 목적변수와 설명변수의 상관관계
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/4d3ebc99-688a-484e-a3c6-8b98bf4c47d8)
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/770b4255-418d-4468-9706-f1123e21cb9a)

* 목적변수와 상관계수가 낮은 설명변수들이 존재한다는 것을 알 수 있음
* 목적변수와 상관계수가 낮은 설명변수들은 머신러닝 모델에 노이즈를 추가하여 성능 저하와 과접합을 초래할 수 있기 때문에 추후 조치가 필요함


## Step 2 (데이터 전처리)

<br/>

### 결측치 제거 및 대처


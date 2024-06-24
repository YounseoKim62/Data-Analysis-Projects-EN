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

* 데이터를 확인한 결과, 'Name' 변수는 머신러닝에 중요하지 않으며, 'Sector'는 범주형 변수이며, 나머지 변수들은 모두 숫자형 변수이고, 'Class'가 목적 변수임을 알 수 있으며, NaN 값들이 존재한다는 것을 알 수 있음

### 통계 요약
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/4dd77144-c6f2-454b-b64e-f78deae63d28)
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/443141fe-0878-4a3a-be38-9af2a73c396f)

* 첫 10개의 변수를 박스 플롯으로 표시했을 때 'Revenue Growth'나 'R&D Expenses'와 같이 잘 보이지 않는 변수들이 있음
* 이는 각 변수들의 범위가 다르다는 것을 의미하기 때문에, 나중에 변수 표준화가 필요함을 알 수 있음

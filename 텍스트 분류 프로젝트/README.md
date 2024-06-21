# 텍스트 분류 프로젝트 
* 프로그래밍 언어 및 도구: Python (pandas, numpy, nltk, scikit-learn, xgboost)
* 활용한 기술: 데이터 전처리, 머신러닝

<br/>

## [프로젝트 소개]
* 2024년도 봄 학기 머신러닝 수업 파이널 프로젝트
* 의료 진단 차트의 텍스트를 분류 알고리즘 모델을 활용하여 6개의 카테고리 중 한가지로 분류하였음

<br/>

## Step 1 (데이터 전처리)

<br/>

### 소문자 변경과 특수문자 제거
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/e2cde325-479a-4aa1-a969-a9c666cb9a21)

* 대문자와 소문자가 섞여 있으면 같은 단어를 다르게 인식할 수 있기 때문에, 'The', 'the'와 같은 단어들을 소문자로 통일하여 동일하게 인식하도록 함
* 특수문자는 의미 있는 정보를 제공하지 않는 경우가 많아 제거

<br/>

### 불용어 (stop words)제거
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/ecb835d1-596a-4bca-afab-364a5c8d9d3a)

* 불용어는 의미 있는 정보를 제공하지 않기 때문에 제거
* 불용어를 제거함으로써 모델이 더 의미 있는 단어들에 집중하게 되어 분류 작업에 더 잘 맞는 패턴과 관계를 쉽게 파악할 수 있음

<br/>

### 표제화 (lemmatization)
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/602f1bc9-3d0c-4390-b140-d97e8cb41e66)

* 환자가 호소하는 증상, 치료받은 기록과 같은 행동에 관련된 텍스트 데이터이기 때문에 동사 형태로 표제화 함
* 다양한 형태로 변형된 단어들을 기본 동사 형태로 일관되게 처리하여 중복된 뜻의 단어들과 노이즈를 제거하여 모델의 성능을 향상 시킬 수 있음

<br/>

### 벡터라이징 (TF-IDF)
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/96e79673-224e-4747-8648-070e4973d3bd)

* TF-IDF는 텍스트를 토크나이징한 후, 단어의 중요도를 평가하여 문서 내에서의 중요도를 계산하고 이를 벡터로 변환
* 예시: (0, 258) 0.06596는 첫 번째 문서의 258번째 단어의 중요도가 0.06596 (범위: 0 ~ 1)이라는 뜻

<br/>

## Step 2 (머신러닝: stacking algorithm)

<br/>

### stacking algorithm 모델 생성
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/0f706a78-83f2-4e05-a41c-1c091b13006f)

* 텍스트 데이터는 단어의 순서, 의미, 문맥 등을 고려해야 하므로 여러 모델의 강점을 결합하여 예측 정확성을 높일 수 있는 스태킹 알고리즘을 사용
* 로지스틱 회귀는 텍스트 데이터의 선형적 관계를 잘 포착하고, XGBoost는 복잡한 텍스트 데이터의 비선형적 관계를 잘 설명하며, 나이브 베이즈는 텍스트 데이터를 간단하고 효과적으로 분류할 수 있음
* 로지스틱 회귀는 비교적 단순한 모델이기 때문에 훈련 데이터에 과적합될 위험이 적어 meta model로 사용


### 하이퍼파라미터 튜닝
![image](https://github.com/YounseoKim62/Data-Analysis-Projects-KR/assets/161654460/36c1f4cc-7a64-496c-8b13-b884705f2966)

* 스태킹 알고리즘에 사용된 로지스틱 회귀와 XGBoost의 파라미터들을 여러 값으로 설정:
>lr__C: 규제 강도를 조절하여 과적합을 방지
>xgb__learning_rate: 모델 가중치를 업데이트하는 스텝 크기; 큰 값은 빠르게 학습하지만 덜 세밀함
>xgb__max_depth: 모델의 복잡성을 증가시켜 더 세밀한 패턴을 학습 가능
>xgb__n_estimators: 앙상블의 트리 수; 각 트리는 이전 트리의 오류를 수정
* GridSearchCV를 통해 모든 조합을 테스트하여 가장 높은 f1_weighted 점수가 나온 파라미터 조합을 저장





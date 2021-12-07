# Proyecto Final Estadística Computacional

## Equipo:

| Usuario de github | Nombres        |
|------------------|----------------|
| @acturio         | Arturo Bringas |  
| @vviiccttoorr    | Víctor Rivera  | 
| @codeMariana     | Mariana Lugo   | 
| @KaLizzyGam  | Lizette Gamboa | 

### Objetivo: ML model and API project 

El problema de negocio es determinar la presencia de enfermedad en el corazón dadas las características de los pacientes.
Se realiza el producto de datos en **R** y **Postegres** con imágenes y contenedores en **Docker**. Se corre una API con [plumber](https://www.rplumber.io/) que realiza:

1. Las predicciones de nuevos datos.
2. Ingesta de nuevos datos y almacenamiento en Postgres.
3. Reentrenamiento del modelo.
4. Resultados del modelo: 
   - Cálculo del AUC de la Curva ROC. 
   - Gráfica de la Curva Roc. 
   - Gráfica de Precision vs. Recall.

### Datos
Se utilizan los datos de [Heart Failure Prediction Dataset](https://www.kaggle.com/fedesoriano/heart-failure-prediction). La base contiene 918 observaciones con 12 columnas que se refieren a las siguientes características de los pacientes:


    Age: age of the patient [years]
    Sex: sex of the patient [M: Male, F: Female]
    ChestPainType: chest pain type [TA: Typical Angina, ATA: Atypical Angina, NAP: Non-Anginal Pain, ASY: Asymptomatic]
    RestingBP: resting blood pressure [mm Hg]
    Cholesterol: serum cholesterol [mm/dl]
    FastingBS: fasting blood sugar [1: if FastingBS > 120 mg/dl, 0: otherwise]
    RestingECG: resting electrocardiogram results [Normal: Normal, ST: having ST-T wave abnormality (T wave inversions and/or ST elevation or depression of > 0.05 mV), LVH: showing probable or definite left ventricular hypertrophy by Estes' criteria]
    MaxHR: maximum heart rate achieved [Numeric value between 60 and 202]
    ExerciseAngina: exercise-induced angina [Y: Yes, N: No]
    Oldpeak: oldpeak = ST [Numeric value measured in depression]
    ST_Slope: the slope of the peak exercise ST segment [Up: upsloping, Flat: flat, Down: downsloping]
    HeartDisease: output class [1: heart disease, 0: Normal]



### Instrucciones para la API

**Requisitos:** 
- Tener instalado [Docker](https://docs.docker.com/get-docker/).



Se inicia el proyecto en la carpeta de docker:

Paso 1: Inicialización de contenedores

`instructions.sh`

Paso 2: Consultas a través de la REST API. 

* Se realizan las predicciones de nuevos datos con: 

`curl localhost:8000/prediction -H "Content-Type: application/json" --request POST --data @predict_data.json`

* Se realiza la ingesta de nuevos datos a postgres con:

`curl localhost:8000/new_data -H "Content-Type: application/json" --request POST --data @new_data.json`

* Se realiza el reentrenamiento del modelo con: 

`curl localhost:8000/re_train --request POST`

* Se obtiene el AUC de la curva ROC del modelo con: 

`curl localhost:8000/metrics --request GET` 

* Se obtienen la gráfica de la curva ROC con:

    LINUX:

    `curl -o curva_roc.png localhost:8000/roc_curve_plot --request GET; xdg-open curva_roc.png`

    MAC:

    `curl -o curva_roc.png localhost:8000/roc_curve_plot --request GET; open curva_roc.png`


* Se obtienen la gráfica de precision vs. recall con:

    LINUX:

    `curl -o pr_plot.png localhost:8000/pr_curve_plot --request GET; xdg-open pr_plot.png`

    MAC:

    `curl -o pr_plot.png localhost:8000/pr_curve_plot --request GET; open pr_plot.png`


Paso 3: Detener contenedores

`docker-compose stop`


#### Notas Adicionales: 

Este repositorio es el resultado final de una serie de pruebas. Se realizó el trabajo en un repositorio *borrador*. Revisar los commits y pruebas en: [CandyWorld](https://github.com/Acturio/CandyWorld).


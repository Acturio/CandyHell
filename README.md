# Proyecto Final Estadística Computacional

## Equipo:

| Usuario de github | Nombres        |
|------------------|----------------|
| @acturio         | Arturo Bringas |  
| @vviiccttoorr    | Víctor Rivera  | 
| @codeMariana     | Mariana Lugo   | 
| @KaLizzyGam  | Lizette Gamboa | 

### Contexto
Las enfermedades cardiovasculares (ECV) son la principal causa de muerte en todo el mundo, cada año mueren más personas por este tipo de enfermedad que por cualquier otra causa. La mayoría de las ECV pueden prevenirse actuando sobre factores de riesgo comportamentales, como el consumo de tabaco, las dietas malsanas y la obesidad, la inactividad física o el consumo nocivo de alcohol. 

### Objetivo
El objetivo de esta aplicación es que las personas, organizaciones y/o gobiernos puedan ingresar datos que permitan detectar tempranamente el riesgo de tener enfermedades cardiovasculares. Es fundamental para las personas con mayor riesgo de tener ECV una detección temprana para recibir los tratamientos necesarios.

### ML model and API project 
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
    ChestPainType: chest pain type [TA: Typical Angina, ATA: Atypical Angina, NAP: 
                   Non-Anginal Pain, ASY: Asymptomatic]
    RestingBP: resting blood pressure [mm Hg]
    Cholesterol: serum cholesterol [mm/dl]
    FastingBS: fasting blood sugar [1: if FastingBS > 120 mg/dl, 0: otherwise]
    RestingECG: resting electrocardiogram results [Normal: Normal, ST: having ST-T wave abnormality 
                (T wave inversions and/or ST elevation or depression of > 0.05 mV), LVH: showing 
                probable or definite left ventricular hypertrophy by Estes' criteria]
    MaxHR: maximum heart rate achieved [Numeric value between 60 and 202]
    ExerciseAngina: exercise-induced angina [Y: Yes, N: No]
    Oldpeak: oldpeak = ST [Numeric value measured in depression]
    ST_Slope: the slope of the peak exercise ST segment [Up: upsloping, Flat: flat, Down: downsloping]
    HeartDisease: output class [1: heart disease, 0: Normal]



### Instrucciones para la API

**Requisitos:** 
- Tener instalado [Docker](https://docs.docker.com/get-docker/).

- Tener instalado [Docker-Compose](https://docs.docker.com/compose/install/).



Se inicia el proyecto en la carpeta de Home (main) del proyecto CandyHell:

Paso 1: Inicialización de contenedores, ejecutar:

`sh instructions.sh`

Paso 2: Consultas a través de la REST API:

En otra terminal usted puede ejectuar lo siguiente posicionandose en el Home del Proyecto

* Se realizan las predicciones de nuevos datos con el comando: 

`curl localhost:8000/prediction -H "Content-Type: application/json" --request POST --data @predict_data.json`

* Se realiza la ingesta de nuevos datos a postgres con el comando:

`curl localhost:8000/new_data -H "Content-Type: application/json" --request POST --data @new_data.json`

* Se realiza el reentrenamiento del modelo con el comando: 

`curl localhost:8000/re_train --request POST`

* Se obtiene el AUC de la curva ROC del modelo con el comando: 

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

`cd docker `

`docker-compose stop`

`docker-compose down`

### Machine Learning Model

La variable de respuesta de este conjunto de datos es categórica, por lo que el modelo implementado corresponde a uno de clasificación.
El modelo baseline de este proyecto se realiza a través de una regresión logística en donde todas las variables restantees forman parte del conjunto de variables explicativas.

#### Análisis Exploratorio Gráfico de Datos

Para conocer mejor las características del conjunto de datos con el que se trabaja, se ha incluido un reporte gráfico con las distribuciones y relaciones entre las variables por analizar. Dentro de la carpeta `geda` se encuentra el documento HTML con los resultados de dicho análisis.

#### Partición de datos

Para la creación del modelo, se realiza una partición a los datos, la cual se realiza de la siguiente manera:

* Conjunta de entrenamiento: 80%

* Conjunto de prueba: 20%

#### Pre-procesamiento de datos

* Debido a que en muchos registros no se cuenta con la información correcta de colesterol, se realiza una imputación por la mediana de esta variable

* Todas las variables numéricas son estandarizadas con la distribución normal estándar del conjunto de entrenamiento

* Para todas las categorías de las variables nominales, se realiza la dicotomización de sus respectios niveles.

#### Predicciones

El modelo permite conocer la probabilidad de que dadas las características de un nuevo individuo, se presente alguna enfermedad del corazón. Los resultados son obtenidos mediante la API a través de los comandos mostrados anteriormente. Cada registro obtiene dos valores como resultado:

* .pred_1: Probabilidad de presentar enfermedades cardiacas

* .pred_0: Probabilidad de no presentar enfermedades cardiacas.

La suma de estos dos resultados es 100% para cada indivuduo.

#### Notas Adicionales: 

Este repositorio es el resultado final de una serie de pruebas. Se realizó el trabajo en un repositorio *borrador*. Revisar los commits y pruebas en: [CandyWorld](https://github.com/Acturio/CandyWorld).


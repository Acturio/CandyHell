# Proyecto Final Estadística Computacional

## Equipo:

| Usuario de github | Nombres        |
|------------------|----------------|
| @acturio         | Arturo Bringas |  
| @vviiccttoorr    | Víctor Rivera  | 
| @codeMariana     | Mariana Lugo   | 
| @KaLizzyGam  | Lizette Gamboa | 

### Objetivo: ML model and API project 

Se inicia el proyecto en la carpeta de docker:

Paso 0: 

`cd docker`

Paso 1: Instalación docker-compose:

`sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`


`sudo chmod +x /usr/local/bin/docker-compose` 

`docker-compose --version`

Paso 2: Se crea la imagen de postgres.

`docker pull postgres:13.3`

Paso 3: Se crea la imagen de RStudio

`docker build -t plumber:1.0.0 . `

Paso 4: Se inicializan contenedores.

`docker-compose up --build`

Paso 5: Cambiar de directorio.

`cd ..`

Paso 6: Se puede utilizar la API. 

* Se realizan las predicciones de nuevos datos con: 

`curl localhost:8000/prediction -H "Content-Type: application/json" --request POST --data @predict_data.json`

* Se realiza la ingesta de nuevos datos a postgres con:

`curl localhost:8000/new_data -H "Content-Type: application/json" --request POST --data @new_data.json`

* Se realiza el reentrenamiento del modelo con: 

`curl localhost:8000/re_train --request POST`

* Se obtiene el AUC de la curva ROC del modelo con: 

`curl localhost:8000/metrics --request GET` 

* Se obtienen la gráfica de la curva ROC con:

`curl -o curva_roc.png localhost:8000/roc_curve_plot --request GET; xdg-open curva_roc.png`

* Se obtienen la gráfica de precision vs. recall con:

`curl -o pr_plot.png localhost:8000/pr_curve_plot --request GET; xdg-open pr_plot.png`




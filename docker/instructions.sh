!#/usr/bin/bash

#Paso 0: ir al directorio correspondiente
cd docker

#Paso 1: Instalación docker-compose:

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`

sudo chmod +x /usr/local/bin/docker-compose`

docker-compose --version`

#Paso 2: Se crea la imagen de postgres.

docker pull postgres:13.3

#Paso 3: Se crea la imagen de RStudio

docker build -t plumber:1.0.0 .

#Paso 4: Se inicializan contenedores.

docker-compose up --build

#Paso 5: Cambiar de directorio.

cd ..


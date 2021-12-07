#!/usr/bin/bash

#Paso 0: ir al directorio correspondiente
cd docker

#Paso 1: Instalación docker-compose:

#echo "instalación de docker compose"
#sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#echo "asignando permisos a docker compose"
#sudo chmod +x /usr/local/bin/docker-compose

echo "docker-compose version"
docker-compose --version

#Paso 2: Se crea la imagen de postgres.

echo "Descarga de imagen de postgres:13.3"
docker pull postgres:13.3

#Paso 3: Se crea la imagen de RStudio

echo "Creación de imagen con plumber"
docker build -t plumber:1.0.0 .

#Paso 4: Se inicializan contenedores.

echo "Composición de contenedores postgres+plumber"
docker-compose up --build

#Paso 5: Cambiar de directorio.
cd ..


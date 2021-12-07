FROM rstudio/plumber

RUN R -e "install.packages(c('tidyverse', 'tidymodels', 'jsonlite', 'rapidoc', 'DBI', 'RPostgres'))"

RUN apt-get update && apt-get install -y \
    libpq-dev \
    libcurl4-openssl-dev

# copia todo del directorio actual al contenedor
COPY data/ /
COPY *.Rds /
COPY *.R /

# Abre el puerto 8000
EXPOSE  8000

# Cuando el contendeor inicia, corre el archivo run.R
ENTRYPOINT ["Rscript", "run.R"]

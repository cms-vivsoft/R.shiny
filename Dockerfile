FROM rocker/shiny-verse:latest

RUN apt-get update && apt-get install -y sudo pandoc pandoc-citeproc libcurl4-gnutls-dev libcairo2-dev libxt-dev libssl-dev libssh2-1-dev && sudo rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('DT', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('plotly', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('shinydashboard', repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('andrewsali/shinycssloaders')"
RUN R -e "install.packages('lubridate', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('magrittr', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('glue', repos='http://cran.rstudio.com/')"

COPY CMS/app.R /srv/shiny-server/
COPY load.R /srv/shiny-server/
COPY df_ru.Rda /srv/shiny-server/

EXPOSE 3838

RUN sudo chown -R shiny:shiny /srv/shiny-server

CMD ["/usr/bin/shiny-server"]
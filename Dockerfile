FROM rocker/r-ver:4.4.0

RUN apt-get update && apt-get install -y \
    python3-pip \
    libcurl4-openssl-dev \
    libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libxml2-dev libcurl4-openssl-dev libfontconfig1-dev libcairo2-dev libharfbuzz-dev libfribidi-dev libssl-dev libfreetype6-dev libpng-dev libtiff5-dev \
    libevent-dev python3-dev jupyter-core


COPY jupyter_notebook_config.py /app/
WORKDIR /app


RUN R -e "install.packages(c('pbdZMQ', 'repr', 'devtools', 'base64enc'))"
RUN R -e "install.packages('IRkernel')"
#RUN R -e "IRkernel::installspec()"

RUN python3 -m pip install pip --upgrade
RUN pip3 install jupyter

EXPOSE 8888

CMD ["jupyter", "notebook", "--no-browser", "--allow-root"]
FROM jupyter/base-notebook

RUN apt-get update && apt-get install -y \
    software-properties-common \
    python3-pip \
    libcurl4-openssl-dev \
    libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libxml2-dev libcurl4-openssl-dev libfontconfig1-dev libcairo2-dev libharfbuzz-dev libfribidi-dev libssl-dev libfreetype6-dev libpng-dev libtiff5-dev \
    libevent-dev python3-dev jupyter-core

RUN apt-get update && apt-get install -y r-base


COPY jupyter_notebook_config.py /app/
WORKDIR /app

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 && \
    add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'

RUN R -e "install.packages(c('pbdZMQ', 'repr', 'devtools', 'base64enc'))"
RUN R -e "install.packages('IRkernel')"
#RUN R -e "IRkernel::installspec()"

RUN python3 -m pip install pip --upgrade
RUN pip3 install jupyter

EXPOSE 8888

CMD ["jupyter", "notebook", "--no-browser", "--allow-root"]
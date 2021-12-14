FROM nvidia/cuda:11.0-cudnn8-runtime-ubuntu18.04

RUN apt-get update

RUN apt-get install bash -y
RUN apt-get install sudo -y
RUN apt-get install git -y

# Install Python 3.8.5 from source
RUN export LC_ALL=C.UTF-8
RUN export LANG=C.UTF-8

RUN apt-get install -y \
    build-essential \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libsqlite3-dev \
    libbz2-dev \
    wget \
    zlib1g-dev \
    liblzma-dev

RUN wget https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz
RUN tar -xf Python-3.8.5.tgz
RUN cd Python-3.8.5 && \
    ./configure --enable-optimizations && \
    make -j 8 && \
    make install

RUN /usr/local/bin/python3 -m pip install --upgrade pip setuptools

ENV G_ID=1000 \
    U_ID=1000 \
    U_NAME=user01 \
    PASS=pass

ENV PATH="/home/$U_NAME/.local/bin:${PATH}"

RUN addgroup --gid $G_ID $U_NAME
RUN adduser --uid $U_ID --ingroup $U_NAME --shell /bin/bash --disabled-password --gecos "" $U_NAME
RUN usermod -aG 100 $U_NAME
RUN usermod -aG sudo $U_NAME
RUN echo "$U_NAME:$PASS" | chpasswd

ADD . /usr/src/code/
RUN chown -R :100 /usr/src/code/
RUN chmod -R g+rwxs /usr/src/code/

USER $U_NAME
WORKDIR /usr/src/config/
RUN python3 -m pip install kedro[pandas.CSVDataSet,profilers]==0.16.6 kedro-viz==3.8.1 kedro-mlflow==0.4.1

WORKDIR /usr/src/code/
RUN python3 -m pip install -r src/requirements.txt

USER root
RUN rm -rf /usr/src/code/
USER $U_NAME

EXPOSE 8888
EXPOSE 4141
EXPOSE 5000
EXPOSE 8008

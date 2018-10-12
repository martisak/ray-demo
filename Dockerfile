FROM ubuntu:xenial
LABEL maintaner="Martin Isaksson"

# Ray worker arguments
ARG numworkers=3
ARG redisaddress=192.168.0.7:6379
ARG objectmanagerport=8076

# Update, upgrade and install things using apt
RUN apt-get update && \
    apt-get install -y \
        curl \
        git \
        libgl1-mesa-glx \
        libtool \
        python3-dev \
        python3-pip \
        python3-pyqt5 \
        wget

# Install pip version of Ray and some other libraries
RUN pip3 install -U \
    colorlog \
    cython==0.27.3 \
    dill \
    flatbuffers \
    gym[atari] \
    lz4 \
    opencv-python==3.2.0.8 \
    PyOpenGL \
    PyOpenGL_accelerate \
    tabulate \
    ujson \
    pip \
    numpy \
    tensorflow==1.5.0 \
    ray[rllib]

# RUN pip3 install -U keras_applications==1.0.5 keras_preprocessing==1.0.3 --no-deps

RUN pip3 install --upgrade \
    git+git://github.com/hyperopt/hyperopt.git

# Tensorflow

# CMD ["tensorboard",  "--logdir=/root/ray_results/", "--port=3000"]

# Ray worker start command
CMD ray start \
        --object-manager-port=$objectmanagerport \
        --redis-address=$redisaddress \
        --num-workers=$numworkers

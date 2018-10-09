FROM tensorflow/tensorflow:latest-gpu-py3
LABEL maintaner="Martin Isaksson"

# Ray worker arguments
ARG numworkers=3
ARG redisaddress=192.168.0.7:6379
ARG objectmanagerport=8076

# Update, upgrade and install things using apt
RUN apt-get update && \
    apt-get install -y \
        autoconf \
        bison \
        build-essential \
        cmake \
        curl \
        flex \
        git \
        libgl1-mesa-glx \
        libtool \
        pkg-config \
        python3-pyqt5 \
        unzip \
        wget \
        zlib1g-dev

# Install pip version of Ray and some other libraries
RUN pip install \
    colorlog \
    cython==0.27.3 \
    dill \
    flatbuffers \
    gym[atari] \
    lz4 \
    opencv-python==3.2.0.8 \
    PyOpenGL \
    PyOpenGL_accelerate \
    ray \
    tabulate \
    ujson

RUN pip install --upgrade \
    git+git://github.com/hyperopt/hyperopt.git

# CMD ["tensorboard",  "--logdir=/root/ray_results/", "--port=3000"]

# Ray worker start command
CMD ray start \
        --object-manager-port=$objectmanagerport \
        --redis-address=$redisaddress \
        --num-workers=$numworkers

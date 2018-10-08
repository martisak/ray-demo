FROM tensorflow/tensorflow:latest-py3
LABEL maintaner="Martin Isaksson"
# FROM tensorflow/tensorflow:latest-gpu-py3

# Ray worker arguments
ARG numworkers=3
ARG redisaddress=192.168.0.7:6379
ARG objectmanagerport=8076

# Update, upgrade and install things using apt
RUN apt-get update && \
    apt-get install -y \
        git \
        zlib1g-dev \
        python3-pyqt5 \
        cmake \
        libgl1-mesa-glx

# Install pip version of Ray and some other libraries
RUN pip install \
    ray \
    gym[atari] \
    opencv-python==3.2.0.8 \
    lz4 \
    dill \
    PyOpenGL \
    PyOpenGL_accelerate \
    tabulate \
    colorlog \
    ujson

RUN pip install --upgrade \
    git+git://github.com/hyperopt/hyperopt.git

# CMD ["tensorboard",  "--logdir=/root/ray_results/", "--port=3000"]

# Ray worker start command
CMD ray start \
        --object-manager-port=$objectmanagerport \
        --redis-address=$redisaddress \
        --num-workers=$numworkers

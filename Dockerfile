FROM ubuntu:xenial
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
        g++ \
        git \
        libgl1-mesa-glx \
        libtool \
        pkg-config \
        python3-dev \
        python3-pip \
        python3-pyqt5 \
        unzip \
        wget \
        zip \
        zlib1g-dev

## Bazel

# RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
# RUN curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
# RUN sudo apt-get update && sudo apt-get install


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
    ray \
    tabulate \
    ujson \
    pip \
    six \
    numpy \
    wheel \
    mock

RUN pip3 install -U keras_applications==1.0.5 keras_preprocessing==1.0.3 --no-deps

RUN pip3 install --upgrade \
    git+git://github.com/hyperopt/hyperopt.git

# Tensorflow

# RUN git clone https://github.com/tensorflow/tensorflow.git
# RUN cd tensorflow &&./configure && bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package
# RUN ./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
# RUN pip install /tmp/tensorflow_pkg/tensorflow-version-cp27-cp27mu-linux_x86_64.whl
#
# CMD ["tensorboard",  "--logdir=/root/ray_results/", "--port=3000"]

# Ray worker start command
CMD ray start \
        --object-manager-port=$objectmanagerport \
        --redis-address=$redisaddress \
        --num-workers=$numworkers

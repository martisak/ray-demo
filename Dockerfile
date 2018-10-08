FROM tensorflow/tensorflow:latest-py3
LABEL maintaner="Martin Isaksson"

# FROM tensorflow/tensorflow:latest-gpu-py3

RUN apt-get update && \
    apt-get install -y \
        git \
        zlib1g-dev \
        python3-pyqt5 \
        cmake \
        libgl1-mesa-glx

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

CMD ["tensorboard",  "--logdir=/root/ray_results/", "--port=3000"]
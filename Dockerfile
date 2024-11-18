ARG CUDA_VER=12.4.1
ARG UBUNTU_VER=22.04
# Download the base image
FROM nvidia/cuda:${CUDA_VER}-cudnn-runtime-ubuntu${UBUNTU_VER}

RUN apt-get update \
	&& apt-get install -y \
	sudo \
	curl \
        python3 \
	python3-pip \
	&& rm -rf /var/lib/apt/lists/*

ARG USER=coder
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
 
RUN pip3 install jupyter

USER ${USER}
WORKDIR /home/${USER}

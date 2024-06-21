# Utilizar a imagem base de CUDA 11.8
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Install git and other dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3-pip
ENV DEBIAN_FRONTEND=noninteractive

# Configurações de ambiente
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Instalar o cuDNN
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcudnn8=8.9.6.50-1+cuda11.8 \
    python3 \
    python3-pip \
    && apt-mark hold libcudnn8 \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Adicionar Python e pip ao PATH
ENV PATH="/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/lib/python3.8/dist-packages"

RUN git clone https://github.com/ultralytics/yolov5.git && \
    cd yolov5 && \
    pip install -r requirements.txt
    
RUN pip uninstall torch torchvision torchaudio -y

RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
RUN pip install comet_ml

CMD ["bash"]
RUN apt-get update && apt-get install -y libgl1-mesa-glx
RUN apt-get update && apt-get install -y libglib2.0-0

# Copiar os arquivos necessários (assumindo que estejam no mesmo diretório que o Dockerfile)
# COPY . /yolov5

# Configurar variáveis de ambiente adicionais, se necessário
# ENV ...
ENV COMET_API_KEY="liT0CLVm570udP5lk25Qr8Xmh"
ENV COMET_WORKSPACE="olavodd42"
ENV COMET_PROJECT_NAME="coco128-test"
RUN pip install --upgrade matplotlib numpy
# Expor portas, se necessário
EXPOSE 8080

# Configurar volumes, se necessário


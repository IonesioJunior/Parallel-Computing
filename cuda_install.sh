# author : 	Ionesio Junior
# Install CUDA LIB/DRIVERS/TOOLKIT (UBUNTU 16.04)

#Download package
wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb

#Install steps
sudo apt-key add /var/cuda-repo-<version>/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda
sudo apt-get install cuda-drivers
sudo apt install nvidia-cuda-toolkit

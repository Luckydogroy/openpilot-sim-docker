# openpilot-sim-docker

## 1. Installing Docker

### Instructions

1. Update your package index:
   ```sh
   sudo apt-get update
   ```

2. Install necessary packages:
   ```sh
   sudo apt-get install \
       ca-certificates \
       curl \
       gnupg \
       lsb-release
   ```

3. Add Docker's official GPG key:
   ```sh
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
   ```

4. Set up the stable repository:
   ```sh
   echo \
     "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```

5. Update the package index again:
   ```sh
   sudo apt-get update
   ```

6. Install Docker Engine:
   ```sh
   sudo apt-get install docker-ce docker-ce-cli containerd.io
   ```

7. Verify the Docker installation:
   ```sh
   sudo docker run hello-world
   ```

## 2. Installing Nvidia-Docker-Container

### Prerequisites
- Docker installed (see above)
- NVIDIA driver installed on your system

### Instructions

1. Add the package repositories:
   ```sh
   distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
   curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
   curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
   sudo apt-get update
   ```

2. Install the `nvidia-docker2` package:
   ```sh
   sudo apt-get install -y nvidia-docker2
   ```

3. Restart the Docker daemon to complete the installation:
   ```sh
   sudo systemctl restart docker
   ```

4. Test the installation with a CUDA container:
   ```sh
   sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
   ```
## 3. Pull the dockerfile
  ```sh
  docker pull luckydogry/openpilot:1.0
  ```

## 4. Run the simulation

### Instructions

1. Start the CARLA simulator by [downloading](https://github.com/carla-simulator/carla/releases/0.9.13) and running the simulator:
  ```sh
  ./CarlaUE4.sh
  ```

2. Start the docker by running:
  ```sh
  ./launch_openpilot_docker.sh
  ```

3. Launch the **openpilot** by running the following command **inside** the docker:
  ```sh
  cd /home/batman/openpilot/tools/sim && ./launch_openpilot.sh
  ```

4. Launchu the **openpilot_bridge** by running:
  ```sh
  docker exec openpilot_client /bin/bash -c 'cd /home/batman/openpilot/tools/sim && ./bridge.py --town {town} --spawn_location  \'{location}\' --auto-engage >/dev/null \'&"
  ```
  The location and town parameters should be formatted as '147,-371,2,0,0,0', "Town04."

5. Wait for 10 seconds, and the simulation should start. 

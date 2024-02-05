#! /bin/bash
# Install ROS2 Humble

set -x

echo "[Check UTF-8]"
locale  # check for UTF-8

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings

echo "[Install ROS2 Humble]"
sudo apt update

sudo apt install software-properties-common

sudo add-apt-repository universe

sudo apt update && sudo apt install curl -y

sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update && sudo apt upgrade

sudo apt install ros-humble-desktop -y

sudo apt install ros-dev-tools -y

source /opt/ros/humble/setup.bash

gedit ~/.bashrc

echo "[Installing ROS2 Tools]"
sudo apt update && sudo apt install -y \
  python3-flake8-docstrings \
  python3-pip \
  python3-pytest-cov \
  ros-dev-tools


sudo apt install -y \
   python3-flake8-blind-except \
   python3-flake8-builtins \
   python3-flake8-class-newline \
   python3-flake8-comprehensions \
   python3-flake8-deprecated \
   python3-flake8-import-order \
   python3-flake8-quotes \
   python3-pytest-repeat \
   python3-pytest-rerunfailures

echo "[Set ROS2 alias]"
sh -c "echo \"alias sb='source ~/.bashrc'\" >> ~/.bashrc"
sh -c "echo \"alias gb='gedit ~/.bashrc'\" >> ~/.bashrc"

sh -c "echo \"alias cw='cd ~/${name_ws}'\" >> ~/.bashrc"
sh -c "echo \"alias cs='cd ~/${name_ws}/src'\" >> ~/.bashrc"

sh -c "echo \"alias cb='cd ~/${name_ws} && colcon build --symlink-install'\" >> ~/.bashrc"
sh -c "echo \"alias cba='colcon build --symlink-install'\" >> ~/.bashrc"
sh -c "echo \"alias cbp='colcon build --symlink-install --packages-select'\" >> ~/.bashrc"

sh -c "echo \"alias rt='ros2 topic list'\" >> ~/.bashrc"
sh -c "echo \"alias re='ros2 topic echo'\" >> ~/.bashrc"
sh -c "echo \"alias rn='ros2 node list'\" >> ~/.bashrc"

# Delete Cache
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lcok*
sudo dpkg --configure -a
sudo apt update

echo "[COMPLETE]"
exit 0

***Docker image with ROS, Gazebo, Xfce4 VNC Desktop, and several robot packages***

**Maintainer:** *Sindhu Radhakrishnan*

![GitHub last commit (branch)](https://img.shields.io/github/last-commit/neoavalon/docker-ros-elg5228/main)
[![GitHub license](https://img.shields.io/github/license/neoavalon/docker-ros-elg5228)](https://github.com/neoavalon/docker-ros-elg5228/blob/main/LICENSE)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Disclaimer](#disclaimer)
- [Overview](#overview)
- [Quick Startup](#quick-startup)
    - [Docker Setup](#docker-setup)
        - [Troubleshooting](#troubleshooting)
    - [Running the Image](#running-the-image)
    - [Connecting to the Image after Running it on your Local Machine (Host)](#connecting-to-the-image-by-running-it-on-your-local-machine-host)
        - [Connecting Through Web Browser](#connecting-through-web-browser)
        - [Connecting Through VNC Viewer](#connecting-through-vnc-viewer)
    - [Stopping the Image](#stopping-the-image)
- [ROS Catkin Workspace](#ros-catkin-workspace)
- [Installed Robots](#installed-robots)
    - [Fixed Manipulators](#fixed-manipulators)
    - [Wheeled Mobile Robots](#wheeled-mobile-robots)
    - [Wheeled Mobile Manipulators](#wheeled-mobile-manipulators)
    - [Aerial Robots](#aerial-robots)
- [Utilities](#utilities)
    - [Text Editors](#text-editors)
    - [Terminal Emulators](#terminal-emulators)
    - [Web Browsers](#web-browsers)
    - [Document Viewers](#document-viewers)
    - [FTP Clients](#ftp-clients)
    - [Useful Shell Scripts](#useful-shell-scripts)
- [Getting the Docker Image](#getting-the-docker-image)
    - [Pulling the Docker Image from Docker Hub](#pulling-the-docker-image-from-docker-hub)
    - [Building the Docker Image Locally](#building-the-docker-image-locally)
- [Running the Container](#running-the-container)
    - [Connect & Control](#connect--control)
    - [Environment Settings](#environment-settings)
        - [Using root (user id `0`)](#using-root-user-id-0)
        - [Using user and group id of host system](#using-user-and-group-id-of-host-system)
        - [Overriding VNC and container environment variables](#overriding-vnc-and-container-environment-variables)
            - [Example: Overriding the VNC password](#example-overriding-the-vnc-password)
            - [Example: Overriding the VNC resolution](#example-overriding-the-vnc-resolution)
        - [Mounting a local directory to the container](#mounting-a-local-directory-to-the-container)
- [Acknowledgment](#acknowledgment)

<!-- markdown-toc end -->

# Disclaimer
The main purpose of this repository and docker image is to facilitate instructors and researchers efforts in experimenting and conducting realistic simulations of various types of robotic systems. However, it comes with no warranty. Please use it at your own discretion. 

I am no docker expert. It is very likely that the generated docker image and the provided `Dockerfile` are by no means optimal.

# Overview

This is a docker image to support teaching ROS-based robotic courses (including "ELG 5228: Mobile Robots" at the University of Ottawa) and to help researchers and hobbyists to experiment with a number of robots. It provides enough power and flexibility to cover various robotic topics (e.g., navigation, control, path planning, manipulators, wheeled mobile robots, aerial robots, etc.) with the ease to add more as needed. It comes with the following main components:
* ROS Melodic installed on Ubuntu 18.04
* Gazebo 9
* Xfce4 VNC Desktop to facilitate remote access
* ROS packages of a number of robots, as detailed blow

The Dockerfile is inspired by that of henry2423/docker-ros-vnc: [https://github.com/henry2423/docker-ros-vnc](https://github.com/henry2423/docker-ros-vnc). Most of the documentation for that repository is still valid here, except:
  * Only ROS Melodic is supported (ROS Kinetic and Lunar are not).
  * Tensorflow and Jupyter are not installed.
  
# Quick Startup

The docker image referred to in this repository is built to run on x86_64 systems. Any such system (most laptops and desktops) running the docker service should be able to run the image. If you're running the container locally on your system, you'll need to have the docker service installed before attempting to run the image.

## Docker Setup

The setup of docker is beyond the scope of this guide, however if you are not familiar with docker and don't have it installed, refer to the following links for a guide how to get started. Which link you follow depends on the OS you have installed and your level of comfort on that OS. For casual users not familiar w/ docker, it is recommended to use Docker Desktop.
* [For users running Linux](https://docs.docker.com/desktop/install/linux-install/) on their systems who want to install Docker Desktop
* [For users running Windows](https://docs.docker.com/desktop/install/windows-install/) on their systems who want to install Docker Desktop
* [For intermediate+ Linux users](https://docs.docker.com/engine/install/) who (dont want Docker Desktop) want to install the bare docker service

### Troubleshooting

When installing Docker Desktop on Windows systems, you may see a prompt regarding an incomplete WSL 2 installation, and that the WSL 2 Linux kernel is installed using a spearate MSI update package. Click "Restart" to complete this installation. If the same error repeats after restarting Docker Desktop, you'll need to manually install the update package from Microsoft. Visit the [Microsoft support page](https://learn.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package) and click on the link to download the latest package. Follow the steps to install. Close Docker Desktop and relaunch it. It may take a few connect attempts to see a green "Engine Running" notification in Docker Desktop.

Post restart and login, you may get a prompt to accept a lincense agreement in order to use Docker Desktop. Accept it. The Docker Dashboard is auto enabled to pop up at startup, however Docker Desktop is not set to start automatically. You can adjust both of these bahaviours by opening Docker Desktop, clicking the gear icon along the top right of the window, then going to "General". One you've made the changes described below, click "Apply & Restart" to save them.
	* You can select Docker Desktop to auto start by enabling "Start Docker Desktop when you log in"
	* You can disable the auto open of the Docker Desktop Dashboard by unchecking "Open Docker Dashboard at startup"

## Running the Image

The easiest way to run the docker image is to run the provided shell script file (`docker-run.sh` for Linux users or `docker-run.bat` for Windows users) at a command line while a docker server is running in the background. You may get the shell script file from [the image's Github repository](https://github.com/neoavalon/docker-ros-elg5228).

<span style="color:red">**NOTE:**</span> The first time you run the script `docker-run.sh` (Linux) or `docker-run.bat` (Windows), it will take a relatively long time to pull the image [from the docker hub](https://hub.docker.com/r/realjsk/docker-ros-elg5228)), due to its large size. However, subsequent runs should be much faster since the image will be cached locally by docker. You will see a progress bar indicating how far along the image download is, after which you'll automatically by prompted w/ a shell inside the container you just launched.

---
<span style="color:red">**WARNING (Use of Volumes):**</span> All changes made to any file/directory within the file system of a docker container are not permanent. They are lost once the container is stopped. To avoid this problem, the `docker-run.sh` and `docker-run.bat` scripts map a local folder `~/MyGDrive/Docker-ELG5228/course_dir` (Linux) or `C:/mobile_robotics/ros_work` (Windows) on your computer onto another folder `/home/ros/catkin_ws/src/course_dir` in the docker container. It is highly recommended that you dedicate a local folder on your computer as a ROS working folder (e.g., throughout the course). It can have any name and path (for example: `/C/Courses/Mobile-robotics/ROS-Work` for Windows hosts or `/Users/john/ELG5228/ROS-Work` for Mac hosts). To be even safer, you might want to have this folder as part of a cloud drive that is automatically synchronized on your local machine (such as Google Drive, OneDrive, etc.)

* For Linux users, inside the file `docker-run.sh`, replace `~/MyGDrive/Docker-ELG5228/course_dir` with the path to your dedicated local folder.
* For Windows users, inside the file `docker-run.bat`, replace `/C/mobile_robotics/ros_work` with the path to your dedicated local folder. Note the /C/ syntax to address your C<notextile>:</notextile>/ drive. If you have some other partitioning on your system, change the drive letter to reflect that.

That way, each time you run the docker image through `docker-run.sh` or `docker-run.bat` your local dedicated folder is automatically mapped onto `/home/ros/catkin_ws/src/course_dir` in the docker container. As such, whenever you make changes on your local dedicated folder or/and on `/home/ros/catkin_ws/src/course_dir` from within the container, those changes remain permanent on the local drive and are automatically made visible from within the container at `/home/ros/catkin_ws/src/course_dir` every time you run the image. 

To allow for more customization without having to rebuild the docker image, place the file `customization.bash` in the mapped drive in your host computer. It is sourced automatically in `.bashrc` when the docker image is fired. 

---

---
<span style="color:red">**WARNING (Windows Users):**</span> If you are running the docker image from a Windows host, please take note of the following remarks:
* You may not be able to run the file `docker-run.sh` as a shell script. To overcome this hurtle, simply run the whole command from `docker run` all the way to `bash` as a **single line** at the DOS prompt by replacing every occurrence of a backslash (\\) by a space. Do not include the first line (`#!/bin/sh`) as part of the command. A simpler way might be to simply run the file `docker-run.bat` at the DOS prompt. 
* Note that the full path of the local folder, which you would like to map to `/home/ros/catkin_ws/src/course_dir` on the docker image, must be in the format `/C/...`; for example, `/C/Courses/Mobile-robotics/ROS-Work`. Of course, you can use other drives if your folder isn't on the C: drive. 
* When you create a file in a Windows machine (e.g., `program.py`) and then you try to run a ROS command on it from inside the docker container (e.g., `rosrun`) you may get an error message of the form "`[...]\r`". This is due to the mismatch between the way Windows and Linux systems encode a carriage return (to mark the end of of a line). There are a few ways to go around this problem: 
	* Use any of the commands described in this link [[html](https://www.cyberciti.biz/faq/howto-unix-linux-convert-dos-newlines-cr-lf-unix-text-format/)] to convert the file to a "Linux-compatible" file.
	* Create the file inside the docker container. Then you should be able to edit it from the Windows machine without a problem. 

---

---

## Connecting to the Image after Running it on your Local Machine (Host)

Successfully running `docker-run.sh` (Linux) or `docker-run.bat` (Windows) takes you to a shell command inside the image. However, this doesn't allow you to run graphical applications. To do so, while the image is running, you need to connect to it from your host machine either through a web browser or a VNC viewer, such as the free multi-platform tigerVNC Viewer ([https://tigervnc.org](https://tigervnc.org)).

### Connecting Through Web Browser
Simply point your web browser to either of the following two URLs;
* connect via __noVNC HTML5 full client__: [`http://localhost:6901/vnc.html`](http://localhost:6901/vnc.html), default password: `vncpassword` 
* connect via __noVNC HTML5 lite client__: [`http://localhost:6901/?password=vncpassword`](http://localhost:6901/?password=vncpassword) 

### Connecting Through VNC Viewer
Point your VNC viewer as follows:
* connect via __VNC viewer `localhost:5901`__, default password: `vncpassword`
Once connected, it might be best to run the VNC viewer in full screen mode, for a better experience. 

---
<span style="color:red">**NOTE:**</span> If you connect to the image via a vnc viewer, it is important to remember to terminate the vnc connection before stopping the docker image, otherwise you may experience some difficulty (vnc lock) next time you try to connect to the image via a vnc viewer. Sometimes, when the vnc connection is not terminated properly, it causes some vnc lock files to remain behind inside the server (the docker image in this case). These files are `/tmp/.X1.lock` and `/tmp/.X11-unix/X1`. The proper way to terminate a vnc connection is to follow *either* of the following options:
* From the host computer, close the vnc viewer application (by closing its window for example).
* From within the docker image, run the command `vncserver -kill :1`, which terminates the connection from the server. This example terminates Display 1 (:1). If you use Display 4, for example, replace 1 with 4.
* The third option (better leave it as the last resort) is to delete files `/tmp/.X1.lock` and `/tmp/.X11-unix/X1` inside the container. 

---

More details about connecting to the image can be found down in Section [Connect & Control](#connect--control).

## Stopping the Image
After finishing working with the docker image, and after properly disconnecting your vnc connection, in case you connected via a VNC viewer, you can stop the image in one of the following methods:
* Graphically through Docker Desktop
* From the command line on your host computer by running `docker stop IMAGE_ID:tag`, where `IMAGE_ID` and `tag` are the ID and tag of the image you want to stop(e.g., `docker stop docker-ros-elg5228:20210908`). Another way is to use the command `docker stop $(docker ps -a -q)`, which will stop *all* docker images running on your computer.


# ROS Catkin Workspace 
The container comes with a catkin workspace already set up. By default, the path for the catkin workspace is  
`/home/ros/catkin_ws`

Some ROS packages are installed in the catkin workspace, including those of some of the robots listed in section [Installed Robots](#installed-robots).

In order for users to write their own ROS packages without running the risk of interfering with the pre-installed packages in this catkin workspace, it is recommended to include all user packages inside the `src` directory of the catkin workspace in a mapped directory. This is already setup in the provided `docker-run.sh` (Linux) or `docker-run.bat` (Windows) file through the `--volume` option of the `docker run` command. You just need to edit it to override the path to the local drive in there (`~/MyGDrive/Docker-ELG5228/course_dir`) to the one of your choice, as explained in section [Running the Image](#running-the-image).

# Installed Robots
The image comes loaded with pre-installed ROS packages for a number of robots.

## Fixed Manipulators
* Franka's Panda [[Official page](https://www.franka.de) | [Github](https://frankaemika.github.io) | [Franka ROS](https://frankaemika.github.io/docs/franka_ros.html)]
* Kinova's Jaco, Jaco2, and Micro arms [[Official page](https://www.kinovarobotics.com) | [Github](https://github.com/Kinovarobotics/kinova-ros)]
* PR2 [[ROS Wiki](http://wiki.ros.org/pr2_simulator) | [PR2 Simulator Tutorial](http://wiki.ros.org/pr2_simulator/Tutorials)]
* Universal Robots (UR3, UR5, UR10) [[Official page](https://www.universal-robots.com) | [Github](https://github.com/ros-industrial/universal_robot)]

## Wheeled Mobile Robots
* Husarion Rosbot 2.0 [[Official page](https://husarion.com) | [Github](https://github.com/husarion)]
* Husky [[Official page](https://clearpathrobotics.com/husky-unmanned-ground-vehicle-robot/) | [Github](https://github.com/husky)]
* Neobotix robots [[Official page](https://docs.neobotix.de) | [Github](https://github.com/neobotix)]
	* Neobotix differential drive robots (MP-400 and MP-500)
	* Neobotix omnidirectional robot with Mecanum wheels (MPO-500)
	* Neobotix omnidirectional robot with Omni-Drive-Modules (MPO-700)
* Turtlebot3 [[Official page](https://emanual.robotis.com/docs/en/platform/turtlebot3/overview/)] <br />
The directive `"export TURTLEBOT3_MODEL=burger"` is already included in `~/.bashrc` <br />
To change the TurtleBot3 model, modify that directive accordingly and don't forget to run `source ~/.bashrc` 

## Wheeled Mobile Manipulators
* Neobotix mobile platforms [[Official page](https://docs.neobotix.de) | [Github](https://github.com/neobotix)]
	* MM-400: Neobotix mobile platform MP-400 with a robot arm from PILZ, Schunk or Panda 
	* MMO-500: Neobotix mobile platform MPO-500 with a robot arm from Universal Robots, Kuka, Rethink Robotics or Schunk
	* MMO-700: Neobotix mobile platform MPO-700 with a robot arm from Universal Robots, Kuka, Rethink Robotics or Schunk

## Aerial Robots
* RotorS: A MAV gazebo simulator. It provides some multirotor models such as the AscTec Hummingbird, the AscTec Pelican, or the AscTec Firefly, and more.
[[ROS Wiki](http://wiki.ros.org/rotors_simulator) | [Github](https://github.com/ethz-asl/rotors_simulator) | [Github Wiki](https://github.com/ethz-asl/rotors_simulator/wiki)]

# Utilities
To facilitate working from within the docker image, it is loaded with a few useful utilities. 

## Text Editors
* Linux' iconic text editors vi, vim, and Emacs. The ROS command `rosed` has been associated to the latter in the file `~/.bashrc`. 
* [VS Code](https://code.visualstudio.com) with [ROS extension](https://marketplace.visualstudio.com/items?itemName=ms-iot.vscode-ros). You can launch it by running the command `code` or by following the menu: *Applications > Development*.

## Terminal Emulators
The image comes with a few standard Linux terminals, such as `XTerm`, `UXTerm`, and `Xfce Terminal`, which can be accessed through the *System* submenu under the *Applications* menu. However, when dealing with ROS, it might be more convenient to use multi-pane terminals. The following two are provided for this purpose. Although they offer many features, you will probably mostly be interested in adding and removing panes.
* [tmux](https://github.com/tmux/tmux): You can launch it at any terminal by running the command `tmux`. A gentle introduction can be found here [[html](https://www.ocf.berkeley.edu/~ckuehl/tmux)].
* The terminal emulator [Terminator](https://gnome-terminator.org): It allows you to add and close panes either using the mouse right button or through keyboard shortcut keys. You can find a brief tutorial at [[html](https://www.tecmint.com/terminator-a-linux-terminal-emulator-to-manage-multiple-terminal-windows/)].

## Web Browsers
* Firefox
* Brave

## Document Viewers
* Evince (document viewer; e.g., pdf, ps, djvu, tiff, dvi, and more)
* Viewnior (image viewer)

## FTP Clients
* [FileZilla](https://filezilla-project.org)

## Useful Shell Scripts
The following shell script files are included in `~/bin` which is already included in your `PATH` (you can run them from any directory in the docker file system).
* `killall_gazebo.sh`: Kills all running instances of gazebo. It can be useful in case gazebo stops responding, for instance.
* `killall_ros.sh`: Practically kills everything running, including the vnc connection to the docker image. You may keep this command as a last resort to terminate the connection if everything hangs up on you. Note that the command does not stop the image running in the docker background. You still need to do that as explained in section [Stopping the Image](#stopping-the-image).


<br /><br />

---
<span style="color:red">**NOTE:**</span> The sections above are all what you need to run the docker image. The rest of the information down below provide details which are less likely to be relevant if you are no expert in docker or/and Linux. You are still encouraged to go through them but don't be alarmed if you don't understand them. In that case, the chances that you won't need them are significant. 

---

<br /><br />


# Getting the Docker Image
The docker image can be either pulled directly from Docker Hub, or built locally on your personal computer. The former method may be much more convenient. 

## Pulling the Docker Image from Docker Hub
Currently, the docker image lives in a Docker Hub repository [realjsk/docker-ros-elg5228](https://hub.docker.com/r/realjsk/docker-ros-elg5228). It can be pulled using the docker command:

	docker pull realjsk/docker-ros-elg5228:<tag>
	
where `<tag>` is the tag you prefer to pull. A list of available tags is found at [https://hub.docker.com/r/realjsk/docker-ros-elg5228/tags](https://hub.docker.com/r/realjsk/docker-ros-elg5228/tags). For instance, you can replace `<tag>` in the above command by `20210908`.

## Building the Docker Image Locally
The source files to build the docker image on a local computer are stored at the Github repository [https://github.com/neoavalon/docker-ros-elg5228](https://github.com/neoavalon/docker-ros-elg5228).

1. Start by cloning the repository:  
   `git clone https://github.com/neoavalon/docker-ros-elg5228.git`
2. Then, cd to the directory including the file `Dockerfile` and (with the docker server running) build the image:  
   `docker build --squash -t name:<tag>  .` (note the dot at the end)  
   where `name` and `<tag>` are the name and tag you want to give to the built image.  
   This can also be done by editing and running the provided shell script `docker-build.sh` using the command:  
   `sh docker-build.sh`

# Running the Container
The container is developed under xfce-docker-container source, which makes it accessible through xfce-vnc or no-vnc (via http vnc service). In the following, it is assumed that the `name:<tag>` of the docker image is `realjsk/docker-ros-elg5228:20210908`. If you used a different one, please make the necessary adjustments to the proceeding commands.

- Run command with a mapping to local port `5901` (vnc protocol) and `6901` (vnc web access):

      `docker run -d -p 5901:5901 -p 6901:6901 realjsk/docker-ros-elg5228:20210908`

- Another alternative to connect to the container is to use the interactive mode `-it` and `bash`
      
      `docker run -it -p 5901:5901 -p 6901:6901 realjsk/docker-ros-elg5228:20210908 bash`

## Connect & Control
Once it is running, you can connect to the container in a number of ways to be able to run GUI applications, such as Gazebo and Rviz:
* connect via __VNC viewer `localhost:5901`__, default password: `vncpassword`
* connect via __noVNC HTML5 full client__: [`http://localhost:6901/vnc.html`](http://localhost:6901/vnc.html), default password: `vncpassword` 
* connect via __noVNC HTML5 lite client__: [`http://localhost:6901/?password=vncpassword`](http://localhost:6901/?password=vncpassword) 

The default username and password in the container is `ros:ros`.

The default password for the `sudo` command is `ros`.

## Environment Settings

### Using root (user id `0`)
Add the `--user` flag to your docker run command. For example:

    docker run -it --user root -p 5901:5901 realjsk/docker-ros-elg5228:20210908

### Using user and group id of host system
In Unix-like host systems, you may add the `--user` flag to your docker run command. For example:

    docker run -it -p 5901:5901 --user $(id -u):$(id -g) realjsk/docker-ros-elg5228:20210908

Note that it may not be always possible to map the user and group ids of the host system to those of the container, which is 1000:1000. In that case, you may want to try overriding the VNC and container envirenment variables, as explained below (see [Overriding VNC and container environment variables](#overriding-vnc-and-container-environment-variables)).

### Overriding VNC and container environment variables
The following VNC environment variables can be overwritten within the docker run command to customize the desktop environment inside the container:
* `VNC_COL_DEPTH`, default: `24`
* `VNC_RESOLUTION`, default: `1920x1080`
* `VNC_PW`, default: `vncpassword`
* `USER`, default: `ros`
* `PASSWD`, default: `ros`

#### Example: Overriding the VNC password
Simply overwrite the value of the environment variable `VNC_PW`. For example, in
the docker run command:

    docker run -it -p 5901:5901 -p 6901:6901 -e VNC_PW=vncpassword docker-ros-elg5228:20210908 

#### Example: Overriding the VNC resolution
Simply overwrite the value of the environment variable `VNC_RESOLUTION`. For example, in the docker run command:

    docker run -it -p 5901:5901 -p 6901:6901 -e VNC_RESOLUTION=800x600 docker-ros-elg5228:20210908

### Mounting a local directory to the container
Docker enables the mapping between directories on the host system and the container through the `--volume` directive. For example, the following command maps the host user/group with the container, and also maps a few directories between the host and the container. Note that in such cases, the host serves as the master while the container is the slave. With the following command, for instance, the user account in the container will be the same as the host account.

      docker run -it -p 5901:5901 \
        --user $(id -u):$(id -g) \
        --volume /etc/passwd:/etc/passwd \
        --volume /etc/group:/etc/group \
        --volume /etc/shadow:/etc/shadow \
        --volume /home/ros/Desktop:/home/ros/Desktop:rw \
        docker-ros-elg5228:20210908

You can learn more about volumes on this designated [docker reference page](https://docs.docker.com/storage/volumes/).

# Acknowledgment

This repository is a fork of Prof. Wail Guaeib's original repository [wail-uottawa/docker-ros-elg5228](https://github.com/wail-uottawa/docker-ros-elg5228) w/ running changes added to support semesters where I am teaching ELG5228.

Credit goes primarily to the maintainers of the following projects:

* [henry2423/docker-ros-vnc](https://github.com/henry2423/docker-ros-vnc) - developed the base Dockerfile used for this image
* [ConSol/docker-headless-vnc-container](https://github.com/ConSol/docker-headless-vnc-container) - developed the ConSol/docker-headless-vnc-container 
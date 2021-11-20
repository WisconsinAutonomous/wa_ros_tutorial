# Wisconsin Autonomous ROS Tutorial

This repository is meant to help members learn ROS in an easy to setup way. It's always a struggle to install ROS, especially on non-Linux systems. 

Please read through this entire document before getting started. It has critical background information and reading first will streamline the setup process.

## Table of Contents

- [Background](#background)
- [Installation](#installation)
  - [Starting the Containers](#starting-the-containers)
  - [Entering the Container](#entering-the-container)
  - [Stopping the Containers](#stopping-the-containers)
- [ROS Tutorial](#ros-tutorial)
	- [Visualizing GUI Apps](#visualizing-gui-apps)
- [Known Issues](#known-issues)
	- [Browser Window View](#browser-window-view)
	- [Missing Icons](#missing-icons)

## Background

The Robot Operating System or [ROS](https://www.ros.org/) (pronounced as it appears; as in, not R-O-S separately). It is essentially a way to organize code to be used for robotic systems. Wisconsin Autonomous (WA) uses it in this way, where our code is grouped into manageable pieces within ROS' framework.

The best way to learn ROS is to program with it. This README will not go into detail about the ROS framework itself; the creators of ROS have put together some really nice tutorials that explain the key concepts very well. This document will help you get started with these tutorials.

As you may know or may find out, there are two over-arching versions of ROS: ROS and ROS 2. ROS was initially realeased in 2007. ROS 2 was then released in 2017. ROS 2 took all the great things from ROS 1, and tried to fix the parts that weren't so great; for instance, ROS 1 required Ubuntu or Linux operating systems. ROS 2 natively runs on Windows and MacOS, as well as other operating systems. To stick with the times and ensure we are using the latest and greatest, we will stick to using ROS 2.

Further, ROS is not only a framework, but a collective community of roboticists and engineers who like to share and distribute code. As such, there are a lot of publically available packages that ROS, and the community, provide that we utilize often. For instance, [RVIZ](https://github.com/ros2/rviz), which stands for ROS Visualization, is a super useful tool for visualizing your robot in a simulated environment. Similarly, ROS has a simulation environment that is very popular: [Gazebo](http://gazebosim.org/tutorials?tut=ros2_overview).

ROS is a very popular tool and is even used by industry; learning it will tremendously help your ability to get an internship.

## Installation

Installing ROS is not always the easiest endeavor. It has become considerably easier since the release of ROS 2 since it's cross-platform, however. To simplify the installation process _specifically for the tutorial_, we will be using [Docker](https://www.docker.com/). Docker is a tool for creating containers. Basically, containers standardizes your development environment and isolates it from the host operating system; what this means is that you can create a docker container once and share it across computers, where it works exactly the same no matter the host operating system. Read more about containers [here](https://www.docker.com/resources/what-container). Within a container, you can run a full operating system and this psuedo-OS will be where we will install ROS. 

To get Docker, please follow [their official guides](https://docs.docker.com/get-docker/). 

You will also need `docker-compose`, which is a tool for generating and running multiple containers. On Mac and Windows, if you installed Docker Desktop, you should already have it. To check, run `docker-compose` on the command line. If it is not installed, see [their official installation guide](https://docs.docker.com/compose/install/).

Using `docker-compose`, we'll need to build the images, start the containers and then we'll be able to start the tutorial! **All of the commands suggested in the subsequent sections must be run anywhere inside the `wa_ros_tutorial` repository.**

### Starting the Containers

We'll first need to build and start the containers. To do this, run the following command:

```bash
docker-compose up -d
```

On the first time you run this command, the image will be built. It may take a few minutes. The image will only need to be built once, so the command should finish quicker in the future.

The `-d` flag tells docker to run the contanier in the background. This allows us to "enter" the container from multiple terminal windows, as well as frees up the terminal window that you called `docker-compose up`.

### Entering the Container

ROS is interfaced via the command line. As such, you need to actually enter the created container in order to use it and run through the tutorials. To do this, run the following (where `<shell>` is replaced with the shell you intend to use; such as `bash` or `zsh`:

```bash
docker-compose exec ros2-tutorial <shell>
```

This command can be run in as many terminal windows as you'd like. For the ROS tutorials, it is pretty likely you'll need multiple windows. You can either just run the aforementioned command in multiple terminals or use `tmux` (for more information on `tmux`, see [here](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/)).

As you'll see if you simply run `ls` in the terminal window, there will be a folder at `/root/dev_ws`. This is meant to be there. This is because Docker, by default, will be completely isolated from the host system. If you were to exit your container without using something called `volumes`, _none_ of your code will be saved. This wouldn't be ideal because you'd have to run through the tutorial all over again. As a result, the `dev_ws` was setup to be a `volume`. Docker volumes are simply folders and files that are both accessible from within the container and one the host system. To read more about volumes, please see [Docker's website](https://docs.docker.com/storage/volumes/). With all that being said, make sure you do all your work in the `dev_ws` folder. You should not need to do anything with the folder name or location, as the tutorials use this folder location by default.

### Stopping the Containers

It is not really necessary to stop the container, but if you'd like to free up resources, you can stop the container with the following command:

```
docker-compose down
```

## ROS Tutorial

ROS is released with multiple distributions. The one we use in WA is `foxy`. The tutorial pages we recommend you follow can be found [here](https://docs.ros.org/en/foxy/Tutorials.html). 

The Docker environment we've set up will allow you to run both ROS on the command line and visualize GUI (window-based) applications. Anything involving `turtlesim` or `rqt` in the ROS tutorials will require GUI access.

### Visualizing GUI Apps 

In the [Installation](#installation) section, we built multiple Docker images that we will use here. To be exact, we built two: one for ROS and one for visualizing GUIs. When you run `docker-compose up`, both are automatically spun up. When you do `docker-compose exec ros2-tutorial`, you're entering the ROS docker. Then, when you use GUI applications like `turtlesim` or `rqt`, the other container will be used in conjunction with your browser.

When you need GUI applications, and you've started them in the docker container and spun up both containers, you can go to `localhost:8080/vnc_auto.html` to see the windows. This _should_ work on all platforms.

## Known Issues

### Browser Window View

noVNC, which is what we use for visualizing GUI windows in the browser, has no good way of _automatically_ grabbing the monitor size. As a result, the display size for noVNC is set to 5000x5000, which is over what most monitors have. As a result, it is possible windows are created partially outside the view of the browser. It has only been seen that it is _partially_ outside of view, so you should be able to drag the window to be in view.

### Missing Icons 

It has been observed that some icons are not available in noVNC. There for, some buttons, especially `rqt`, will have buttons with no text or images inside. Please refer to the screenshots in the ROS tutorial to see what they should be.


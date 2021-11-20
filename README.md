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

## Prerequisites

You should learn a lot as you go! These prerequisites are more of a suggestion than a requirement. We suggest you're familiar with the following:

- Linux Command Line
- `git`
-	Ability to copy-and-paste 

## Background

The Robot Operating System or [ROS](https://www.ros.org/) (pronounced as it appears; as in, not R-O-S separately). It is essentially a way to organize code to be used for robotic systems. Wisconsin Autonomous (WA) uses it in this way, where our code is grouped into manageable pieces within the ROS framework.

The best way to learn ROS is to program with it. This README will not go into detail about the ROS framework itself; the creators of ROS have put together some really nice tutorials that explain the key concepts very well. This document will help you get started with these tutorials.

As you may know or may find out, there are two over-arching versions of ROS: ROS and ROS 2. ROS was initially realeased in 2007. ROS 2 was then released in 2017. ROS 2 took all the great things from ROS 1, and tried to fix the parts that weren't so great; for instance, ROS 1 required Ubuntu or some other Linux operating systems. ROS 2 natively runs on Windows and MacOS, as well as various Linux distros. To stick with the times and ensure we are using the latest and greatest, we will be using ROS 2 in WA.

Further, ROS is not only a framework, but a collective community of roboticists and engineers who like to share and distribute code. As such, there are a lot of publically available packages that ROS, and the community, provide that we utilize often. For instance, [RVIZ](https://github.com/ros2/rviz), which stands for ROS Visualization, is a super useful tool for visualizing your robot in a simulated environment. Similarly, ROS has a simulation environment that is very popular: [Gazebo](http://gazebosim.org/tutorials?tut=ros2_overview).

ROS is a very popular tool and is even used by industry; learning it will tremendously help your ability to get an internship or job.

## Installation

Installing ROS is not always the easiest endeavor. It has become considerably easier since the release of ROS 2 since it's cross-platform, however. To simplify the installation process _specifically for the tutorial_, we will be using [Docker](https://www.docker.com/). Docker is a tool for creating containers. Basically, containers standardizes your development environment and isolates it from the host operating system; what this means is that you can create a docker container once and share it across computers, where it works exactly the same no matter the host operating system. Read more about containers [here](https://www.docker.com/resources/what-container). Within a container, you can run a full operating system and this psuedo-OS will be where we will install ROS. 

To get Docker, please follow [their official guides](https://docs.docker.com/get-docker/). 

You will also need `docker-compose`, which is a tool for generating and running multiple containers. On Mac and Windows, if you installed Docker Desktop, you should already have it. To check, run `docker-compose` on the command line. If it is not installed, see [their official installation guide](https://docs.docker.com/compose/install/).

Using `docker-compose`, we'll need to build the images, start the containers and then we'll be able to start the tutorial! 

> **NOTE: All of the commands suggested in the subsequent sections must be run anywhere inside the `wa_ros_tutorial` repository.**

### Starting the Containers

We'll first need to build and start the containers. To do this, run the following command:

```bash
docker-compose up -d
```

On the first time you run this command, the image will be built. It may take a few minutes. The image will only need to be built once, so the command should finish quicker in the future.

The `-d` flag tells docker to run the contanier in the background. This allows us to "enter" the container from multiple terminal windows, as well as frees up the terminal window that you called `docker-compose up`.

### Entering the Container

ROS is interfaced via the command line. As such, you need to actually enter the created container in order to use it and run through the tutorials. To do this, run the following (where `bash` could be replaced with any other shell you intend to use; such as `zsh`):

```bash
docker-compose exec ros2-tutorial bash
```

This command can be run in as many terminal windows as you'd like. For the ROS tutorials, it is pretty likely you'll need multiple windows. You can either just run the aforementioned command in multiple terminals or use `tmux` (for more information on `tmux`, see [here](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/)).

As you'll see, there will be a folder at `/root/dev_ws`. We've purposefully placed this there. By default, if you were to exit a Docker container, no files or folders would be saved. This is because, as we discussed earlier, Docker isolates your system from the host operating system. Without explicitly telling docker to save your files, it will simply forget them when you exit the container. As such, we've set the build process up so that the `ros2_tutorial` folder in this directory will map to `dev_ws` in your container. We chose it to be named `dev_ws` because this is what the ROS tutorial's use as the main directory for writing code. You should not need to change the name or location of this folder. Anytime you write code in this container, make sure you are somewhere inside this folder! To learn more about this concept, called `volumes`, please see [Docker's website](https://docs.docker.com/storage/volumes/).

### Stopping the Containers

It is not really necessary to stop the container, but if you'd like to free up resources, you can stop the container with the following command:

```
docker-compose down
```

## ROS Tutorial

ROS is released with multiple distributions. The one we use in WA is `foxy`. The tutorial pages we recommend you follow can be found [here](https://docs.ros.org/en/foxy/Tutorials.html). 

The Docker environment we've set up will allow you to run both ROS on the command line and visualize Graphical User Interface or GUI (window-based; pronounced GEW-EE) applications. Anything involving `turtlesim` or `rqt` in the ROS tutorials will require GUIs.

### Visualizing GUI Apps 

In the [Installation](#installation) section, we built multiple Docker images that we will use here. To be exact, we built two: one for ROS and one for visualizing GUIs. When you run `docker-compose up`, both are automatically spun up. When you do `docker-compose exec ros2-tutorial`, you're entering the ROS docker. Then, when you use GUI applications like `turtlesim` or `rqt`, the other container will be used in conjunction with your browser.

When you need GUI applications, you can go to `localhost:8080/vnc_auto.html` to see the windows. This _should_ work on all platforms.

## Known Issues

### Browser Window View

noVNC, which is what we use for visualizing GUI windows in the browser, has no good way of _automatically_ grabbing the monitor size. As a result, the display size for noVNC is set to 5000x5000, which is over what most monitors have. As a result, it is possible windows are created partially outside the view of the browser. It has only been seen that it is _partially_ outside of view, so you should be able to drag the window to be completely in view.

### Missing Icons 

It has been observed that some icons are not available in noVNC. Therefore, some buttons, especially in `rqt`, will have no text or images inside. Please refer to the screenshots in the ROS tutorial to see what they should look like.


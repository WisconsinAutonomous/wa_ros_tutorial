FROM tiryoh/ros2-desktop-vnc:foxy

LABEL maintainer="Wisconsin Autonomous <wisconsinautonomous@studentorg.wisc.edu"

ARG DEBIAN_FRONTEND=noninteractive
ARG ROSDISTRO=foxy

# Check for updates
RUN apt update && apt upgrade -y && apt install -y expect

# Install some packages
RUN apt install -y tmux vim ssh git git-lfs zsh curl wget

# Various arguments and user settings
ARG USERSHELL
ARG USERSHELLPATH="/bin/${USERSHELL}"
ARG USERSHELLPROFILE="/home/ubuntu/.${USERSHELL}rc"

# Run the customize script so people can customize their shell, if they desire
COPY files/* /tmp/
RUN [ -f /tmp/customize.sh ] && $USERSHELL /tmp/customize.sh || $USERSHELL /tmp/customize.sh.template
ENV ZSH_DISABLE_COMPFIX true
RUN chmod 755 /usr/local/share/zsh
RUN chmod 755 /usr/local/share/zsh/site-functions

# ROS Setup
RUN echo ". /opt/ros/$ROSDISTRO/setup.sh" >> $USERSHELLPROFILE
RUN /bin/$USERSHELL -c "source /opt/ros/$ROSDISTRO/setup.$USERSHELL"

WORKDIR /home/ubuntu/

ENV USERSHELLPATH=$USERSHELLPATH
CMD $USERSHELLPATH

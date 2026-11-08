# ROS 2 Jazzy desktop on Ubuntu 24.04 (Noble).
# The base image already contains rclcpp/rclpy, RViz2, rqt, the demo nodes,
# colcon, rosdep and vcstool.
FROM osrf/ros:jazzy-desktop

# Non-root user that ships with the Ubuntu 24.04 base image (UID/GID 1000).
ARG USERNAME=ubuntu

# Extra development tools. Add the apt packages your project needs here.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        sudo \
        gdb \
        python3-pip \
        bash-completion \
    && rm -rf /var/lib/apt/lists/*

# Passwordless sudo, so rosdep can install system dependencies
# (the marker file hides Ubuntu's "To run a command as administrator" banner).
RUN echo "${USERNAME} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME} \
    && touch /home/${USERNAME}/.sudo_as_admin_successful \
    && chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.sudo_as_admin_successful

# Every interactive shell gets ROS 2, colcon tab-completion and, once it has
# been built, the workspace overlay (ROS2_WS is set in devcontainer.json).
RUN { \
        echo ''; \
        echo '# ROS 2 environment (added by .devcontainer/Dockerfile)'; \
        echo 'source /opt/ros/${ROS_DISTRO}/setup.bash'; \
        echo 'source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash'; \
        echo 'if [ -f "${ROS2_WS}/install/setup.bash" ]; then source "${ROS2_WS}/install/setup.bash"; fi'; \
    } >> /home/${USERNAME}/.bashrc

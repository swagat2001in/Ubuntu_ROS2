#!/usr/bin/env bash
# Runs once, after the dev container is created.
set -euo pipefail

WS="${ROS2_WS:?ROS2_WS is not set}"
mkdir -p "${WS}/src"

# Download the rosdep database (kept per user, so it is not baked into the image).
rosdep update --rosdistro "${ROS_DISTRO}"

# Install the system dependencies of any packages already in the workspace.
if find "${WS}/src" -name package.xml -print -quit | grep -q .; then
    sudo apt-get update
    rosdep install --from-paths "${WS}/src" --ignore-src -y --rosdistro "${ROS_DISTRO}"
fi

echo "ROS 2 ${ROS_DISTRO} dev container ready. Workspace: ${WS}"

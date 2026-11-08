# Ubuntu_ROS2

A ready-to-use **ROS 2 Jazzy** development environment on **Ubuntu 24.04**, packaged as a
dev container. Run it in **GitHub Codespaces** from any browser, or locally in VS Code.

## Start it

- **Codespaces (any computer):** on GitHub, click **Code → Codespaces → Create codespace on main**.
  The first build takes about 5 minutes. After that, starting a stopped codespace takes seconds.
- **Already inside a codespace created before `.devcontainer/` existed?** Run
  **Codespaces: Rebuild Container** from the Command Palette (`Ctrl/Cmd+Shift+P`).
- **Locally:** install Docker and the VS Code *Dev Containers* extension, clone this repo, then run
  **Dev Containers: Reopen in Container**.

## Check that ROS 2 works

In two terminals:

```bash
ros2 run demo_nodes_cpp talker
ros2 run demo_nodes_py listener   # prints "I heard: [Hello World: N]"
```

## GUI tools (RViz2, rqt)

1. Open the **Ports** tab and open port **6080 – Desktop (noVNC)** in the browser.
2. Click **Connect**. No password is needed: the port is private to your GitHub account.
3. Run a GUI tool from any VS Code terminal, for example `rviz2`. It appears on that desktop.

There is no GPU, so rendering is done in software. That is fine for RViz2 and rqt, but slow for
large Gazebo worlds.

## Your workspace

Put your packages in `ros2_ws/src`, then:

```bash
cd ros2_ws
sudo apt-get update && rosdep install --from-paths src --ignore-src -y   # system dependencies
colcon build
source install/setup.bash   # new terminals do this automatically
```

## What's where

| Path | Purpose |
|---|---|
| `.devcontainer/Dockerfile` | Image: `osrf/ros:jazzy-desktop` plus dev tools. Add apt packages here. |
| `.devcontainer/devcontainer.json` | Desktop, ports, VS Code extensions and settings. |
| `.devcontainer/post-create.sh` | Runs once per container: `rosdep update` and dependency install. |
| `ros2_ws/colcon_defaults.yaml` | Defaults for `colcon build`: symlink install, and `compile_commands.json` for C++ IntelliSense. |

To use Gazebo, change the base image to `osrf/ros:jazzy-desktop-full`. It is much larger.

## Codespaces usage limits

Personal accounts get 120 core-hours (60 hours on the default 2-core machine) and 15 GB of
storage free per month. Stop the codespace when you are done. It also stops by itself after the
idle timeout, which you can set in GitHub **Settings → Codespaces**.

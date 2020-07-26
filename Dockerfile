FROM ubuntu:20.04
RUN apt-get update
# Install godot deps
RUN DEBIAN_FRONTEND="noninteractive" TZ="America/New_York" apt-get install -y build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm
# Install llvm
RUN apt-get install -y wget lsb-release software-properties-common
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"


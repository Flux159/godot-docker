FROM ubuntu:20.04

RUN apt-get update

# Install git
RUN apt-get install -y git

# Install cross compilation deps for windows

# MinGW for Windows
RUN apt-get install -y mingw-w64
# RUN echo "1" | update-alternatives --config x86_64-w64-mingw32-cc
# RUN echo "1" | update-alternatives --config x86_64-w64-mingw32-g++

# Install godot deps
RUN DEBIAN_FRONTEND="noninteractive" TZ="America/New_York" apt-get install -y build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm
# Install llvm deps
RUN apt-get install -y wget lsb-release software-properties-common
# Install llvm
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

# Install emscripten for web platform
RUN git clone https://github.com/emscripten-core/emsdk.git && cd ./emsdk && ./emsdk install latest && ./emsdk activate latest

# TODO: OS X Cross compilation, iOS, Android

# For testing, want this as part of github workflow normally
RUN git clone https://github.com/godotengine/godot.git && cd ./godot && git checkout 3.2.2-stable && git clone https://github.com/GodotExplorer/ECMAScript.git ./modules/ECMAScript


FROM ubuntu:20.04

RUN apt-get update

# Install git
RUN apt-get install -y git

# Install cross compilation deps for windows

# MinGW for Windows
RUN apt-get install -y mingw-w64
# TODO: Currently still need to do the following manually
# RUN echo "1" | update-alternatives --config x86_64-w64-mingw32-cc
# RUN echo "1" | update-alternatives --config x86_64-w64-mingw32-g++
# Then this should work (note the checkout due to an error w/ socket.h on windows platform):
# cd modules/ECMAScript/ && git checkout 01bc02 && cd ../.. && scons -j8 p=windows bits=64

# Install godot deps
RUN DEBIAN_FRONTEND="noninteractive" TZ="America/New_York" apt-get install -y build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm
# Install llvm deps
RUN apt-get install -y wget lsb-release software-properties-common
# Install llvm
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

# Install emscripten for web platform
RUN git clone https://github.com/emscripten-core/emsdk.git && cd ./emsdk && ./emsdk install latest && ./emsdk activate latest

# For testing, want this as part of github workflow normally
RUN git clone https://github.com/godotengine/godot.git && cd ./godot && git checkout 3.2.2-stable && git clone https://github.com/GodotExplorer/ECMAScript.git ./modules/ECMAScript

# OSXCross for os x cross compilation
# RUN apt-get install -y clang gcc g++ zlib1g-dev libmpc-dev libmpfr-dev libgmp-dev curl cmake libxml2-dev libssl-dev
# ENV OSX_SDK MacOSX10.15.sdk
# ENV OSX_CROSS_COMMIT a9317c18a3a457ca0a657f08cc4d0d43c6cf8953
# ENV OSX_CROSS_COMMIT master
# RUN set -x \
#	&& export OSXCROSS_PATH="/osxcross" \
#	&& git clone https://github.com/tpoechtrager/osxcross.git $OSXCROSS_PATH \
#	&& ( cd $OSXCROSS_PATH && git checkout -q $OSX_CROSS_COMMIT) \
 #	&& curl -sSL https://github.com/phracker/MacOSX-SDKs/releases/download/10.15/${OSX_SDK}.tar.xz -o "${OSXCROSS_PATH}/tarballs/${OSX_SDK}.tar.xz" \
#	&& UNATTENDED=yes OSX_VERSION_MIN=10.6 ${OSXCROSS_PATH}/build.sh
#ENV PATH /osxcross/target/bin:$PATH

# TODO: HTML5, iOS, Android export builds

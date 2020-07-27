# godot-docker
Dockerfile to generate godot compilation container

To run:

Make sure docker is installed on machine.

```
sudo docker build .
```

View tag hashes with:
```
sudo docker images
```

Tag the images with:
```
docker tag TAGHASH ubuntu:20.04godot
```

To test running in the container
```
docker run -it ubuntu:20.04godot bash
```

In the container, can build godotjs using:
```
git clone https://github.com/godotengine/godot.git
cd ./godot
git checkout 3.2.2-stable
git clone https://github.com/GodotExplorer/ECMAScript.git ./modules/ECMAScript
scons -j8 platform=x11
```

## Publishing

The image is published as [flux159/godot](https://hub.docker.com/r/flux159/godot) on Dockerhub.

To publish, need to tag as above, except with the correct repo:
```
docker tag TAGHASH flux159/godot:1.0.TAG_BUG_FIX
docker login
docker push flux159/godot:1.0.TAG_BUG_FIX
```

Its also published as a package on github's docker registry [here](https://github.com/Flux159/godot-docker/packages/330543).

The publish process for githubs docker registry is a bit more complicated. First you need to get a token with the repo public permission, and add, read, and delete packages permissions. Save that token & use that to login via docker login to docker.pkg.github.com as below:
```
docker login 
```


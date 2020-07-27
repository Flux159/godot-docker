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


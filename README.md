# Python Drake workspace

*Configuration for Drake*
## Using the docker image
Build the docker images
```
docker build -t pydrake_focal .
```

## Running the docker image and connect the Jupyter server
Forwarding the port 8888 for jupyter server connection, 7000 for rendering services, 6000 for ZeroMQ service.
```
docker run -it -p 8888:8888 -p 7000:7000 -p 6000:6000 pydrake_focal:latest
```

### Removing all docker containers and images
```
docker rm $(docker ps -a -q) -f # remove containers
docker rmi $(docker images) -f # remove images
docker images
```

## Reference
- [Robotic Manipulation:  Perception, Planning, and Control](http://manipulation.csail.mit.edu/)
- [MIT 6.881 - Robotic Manipulation - Schedule](http://manipulation.csail.mit.edu/Fall2020/schedule.html)
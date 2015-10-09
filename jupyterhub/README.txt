apt-get install docker.io git
git clone https://github.com/davidemalagoli/docker-stacks.git
cd /docker-stacks/jupyterhub

docker build .
docker run -it -p 8888:8888 >>IMAGEID<< /usr/local/bin/start-notebook.sh

## IF YOU NEED TO RUN THE JUPYTERHUB
docker run -it -p 8000:8000 >>IMAGEID<< jupyterhub

## IF YOU NEED TO MOVE THE DOCKER VAR TO EXTERNAL DRIVE
#stop the docker daemon
docker ps -q | xargs docker kill
service docker stop

#if it exists
cd /var/lib/docker/devicemapper/mnt
umount ./*

mv /var/lib/docker $dest
ln -s $dest/docker /var/lib/docker

#modify defaults options in docker in /etc/defaults/docker
DOCKER_OPTS="-g $(readlink -f /var/lib/docker)"

#mine edited opts on Google compute engine now looks like:
# DOCKER_OPTS="-H unix:// -r=false -g $(readlink -f /var/lib/docker)

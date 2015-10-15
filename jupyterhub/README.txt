apt-get install docker.io git
git clone https://github.com/davidemalagoli/docker-stacks.git
cd /docker-stacks/jupyterhub

docker build .
## at the end of the process the imageid will be provided, otherwise use "docker ps -a" to see al images

---------------------------------------------------------------------------------------
##  TO RUN THE JUPYTER NOTEBOOK
docker run -it -p 8888:8888 >>IMAGEID<< /usr/local/bin/start-notebook.sh

---------------------------------------------------------------------------------------
##  TO RUN THE JUPYTERHUB
docker run -it -p 8000:8000 >>IMAGEID<< jupyterhub

---------------------------------------------------------------------------------------
## TO MOUNT HOST VOLUME INSIDE DOCKER (suggested for tmp storage on amazon ssd)
docker run -it -p 8888:8888 -v /mnt/:/opt >>IMAGEID<< /usr/local/bin/start-notebook.sh 

---------------------------------------------------------------------------------------
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

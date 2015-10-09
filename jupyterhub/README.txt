apt-get install docker.io git
git clone https://github.com/davidemalagoli/docker-stacks.git
cd /docker-stacks/jupyterhub

docker build .
docker run -it -p 8888:8888 d2b290fb4f8c /usr/local/bin/start-notebook.sh


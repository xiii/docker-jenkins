#!/usr/bin/env bash
set -e

# Getting file permissions on host for docker socket
if [ -e /var/run/docker.sock ]; then
  DOCKER_GID_ON_HOST=$(stat -c %g /var/run/docker.sock)
  sudo groupmod -g $DOCKER_GID_ON_HOST docker
else
  echo -e "\nThe host docker.sock is not mounted in the container"
  echo -e "To give jenkins access to the docker host, run this image with '-v /var/run/docker.sock:/var/run/docker.sock'\n"
fi

# Continue with the jenkins image entrypoint.
exec /bin/tini -- /usr/local/bin/jenkins.sh "$@"

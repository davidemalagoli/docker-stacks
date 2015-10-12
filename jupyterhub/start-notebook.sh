#!/bin/bash

# Change UID of NB_USER to NB_UID if it does not match
if [ "1000" != $(id -u admin) ] ; then
    usermod -u 1000 admin
    chown -R 1000 $CONDA_DIR
fi

# Enable sudo if requested
if [ ! -z "$GRANT_SUDO" ]; then
    echo "$NB_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/notebook
fi

# Start the notebook server
exec su admin -c "env PATH=$PATH jupyter notebook $@"


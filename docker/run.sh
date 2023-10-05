#!/usr/bin/env bash

# Get dependent parameters
source "$(dirname "$(readlink -f "${0}")")/get_param.sh"

docker run --rm \
    --privileged \
    --network=host \
    --ipc=host \
    --runtime nvidia \
    -v /tmp/.Xauthority:/home/"${user}"/.Xauthority \
    -e XAUTHORITY=/home/"${user}"/.Xauthority \
    -e DISPLAY="${DISPLAY}" \
    -e QT_X11_NO_MITSHM=1 \
    -v /etc/udev/rules.d/:/etc/udev/rules.d/ \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v /etc/timezone:/etc/timezone:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v ${WS_PATH}/:/home/${user}/work \
    -it --name "${CONTAINER}" "${DOCKER_HUB_USER}"/"${IMAGE}" 

# --runtime=nvidia ${GPU_FLAG} \
# -v /dev:/dev \
# --rm
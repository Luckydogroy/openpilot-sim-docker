#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
cd $DIR
OPENPILOT_DIR="/openpilot"
if ! [[ -z "$MOUNT_OPENPILOT" ]]; then
  OPENPILOT_DIR="$(dirname $(dirname $DIR))"
  EXTRA_ARGS="-v $OPENPILOT_DIR:$OPENPILOT_DIR -e PYTHONPATH=$OPENPILOT_DIR:$PYTHONPATH"
fi
if [[ "$CI" ]]; then
  CMD="CI=1 ${OPENPILOT_DIR}/tools/sim/tests/test_carla_integration.py"
else
  # expose X to the container
  xhost +local:root
  EXTRA_ARGS="${EXTRA_ARGS} -it"
fi
docker run --net=host  --name openpilot_client   --rm   -it  --gpus all  --device=/dev/dri:/dev/dri   -v /tmp/.X11-unix:/tmp/.X11-unix   --shm-size 1G   -e QT_X11_NO_MITSHM=1   luckydogry/openpilot /bin/bash

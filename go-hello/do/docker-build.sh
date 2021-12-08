# https://docs.docker.com/engine/reference/commandline/build/

[[ -z "${IMAGE:-}" ]] && IMAGE='test'
[[ -z "${TAG:-}" ]] && TAG='latest'

docker build -t ${IMAGE}:${TAG} .

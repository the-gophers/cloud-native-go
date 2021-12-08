# https://docs.docker.com/buildx/working-with-buildx/#build-multi-platform-images

[[ -z "${IMAGE:-}" ]] && IMAGE='test'
[[ -z "${TAG:-}" ]] && TAG='latest'

docker buildx build -t ${IMAGE}:${TAG} --platform linux/amd64 .

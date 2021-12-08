[[ -z "${IMAGE:-}" ]] && IMAGE='test'
[[ -z "${TAG:-}" ]] && TAG='latest'
[[ -z "${PORT:-}" ]] && PORT='80'

docker run -p ${PORT}:${PORT} -e LISTEN_ADDR=":${PORT}" ${IMAGE}:${TAG}

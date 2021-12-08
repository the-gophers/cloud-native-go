[[ -z "${OWNER:-}" ]] && OWNER='asw101'
[[ -z "${LOCAL:-}" ]] && LOCAL='test'
[[ -z "${IMAGE:-}" ]] && IMAGE='test'
[[ -z "${TAG:-}" ]] && TAG='latest'

docker tag ${LOCAL} ghcr.io/${OWNER}/${IMAGE}:${TAG}
docker push ghcr.io/${OWNER}/${IMAGE}:${TAG}

echo "ghcr.io/${OWNER}/${IMAGE}:${TAG}"

# create a personal access token
# create a pat
# see: https://github.com/settings/tokens

# https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

# ensure it has the correct scopes
# https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-to-the-container-registry

[[ -z "${CR_PAT:-}" ]] && echo "CR_PAT not set" && exit 1

echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin

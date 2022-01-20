# Cloud Native Go (More)

[Back (1. Cloud Native Go)](README.md)

## 2. Serverless Go with Azure Container Apps (ACA)

## 2.2. Option 1 - Quickstart & go-hello sample app

First, deploy an Azure Container App using:

- [Quickstart: Deploy your first container app (sample image)](https://docs.microsoft.com/en-ca/azure/container-apps/get-started?tabs=bash)

Then, build and deploy the [go-hello](go-hello) sample application using:

- [GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry) (including the public [ghcr.io/asw101/hello](https://github.com/users/asw101/packages/container/package/hello) sample image).
- [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-quickstart-task-cli) and [Quickstart: Deploy your first container app (custom image)](https://docs.microsoft.com/en-ca/azure/container-apps/get-started-existing-container-image?tabs=bash&pivots=container-apps-private-registry#create-a-container-app)

## 2.2. Option 2 - Dapr (Distributed Application Runtime) or Background Processing Tutorials

If you would like to build on the above, or are looking for something more advanced you can try one of our tutorials for Azure Container Apps:

- [Tutorial: Deploy a Dapr application to Azure Container Apps using the Azure CLI](https://docs.microsoft.com/en-ca/azure/container-apps/microservices-dapr?tabs=bash)
- [Tutorial: Deploy a Dapr application to Azure Container Apps using an ARM template](https://docs.microsoft.com/en-ca/azure/container-apps/microservices-dapr-azure-resource-manager?tabs=bash)
- [Tutorial: Deploy a background processing application with Azure Container Apps Preview](https://docs.microsoft.com/en-ca/azure/container-apps/background-processing?tabs=bash)

## 3. Get Go-ing with GitHub Actions

Below is our self-paced "GitHub Action Using Go" session originally delivered at GopherCon 2021 by David Justice ([@davidjustice](https://twitter.com/davidjustice)) and Aaron Wislang ([@as_w](https://twitter.com/as_w)):

- Visit the [the-gophers/go-action](https://github.com/the-gophers/go-action) repo and see "Lab Instructions" to complete the lab asynchronously.

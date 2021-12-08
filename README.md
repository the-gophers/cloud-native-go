# Cloud Native Go

## 1. Cloud Native Go with Azure Kubernetes Service (AKS), KEDA + KEDA HTTP Addon

In this lab you will deploy an Azure Kubernetes Service (AKS) cluster and other Azure services (Container Registry, Managed Identity, Storage Account, Service Bus, Key Vault), the open source KEDA (Kubernetes Event-driven Autoscaling) project, the KEDA HTTP Addon ([kedacore/http-add-on](https://github.com/kedacore/http-add-on)) with [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) and [Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview). You will then deploy a sample Go application, go-hello, to your cluster using [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) and [kustomization](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/).

### Requirements
- An **Azure Subscription** (e.g. [Free](https://aka.ms/azure-free-account) or [Student](https://aka.ms/azure-student-account) account)
- The [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Bash shell (e.g. macOS, Linux, [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/about), [Multipass](https://multipass.run/), [Azure Cloud Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/quickstart), [GitHub Codespaces](https://github.com/features/codespaces), etc)
- A [GitHub Account](https://github.com)
- Recommended: [hey](https://github.com/rakyll/hey#readme) for load testing, and [k9s](https://k9scli.io/) to monitor your cluster during testing
### Instructions

1. Use the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) and [Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview) templates to deploy the infrastructure for your application.

    ```bash
    # login to the azure cli
    az login

    # if you need kubectl, install it
    az aks install-cli

    # 01-aks/
    cd 01-aks
    bash deploy-main.sh
    ```

    You can optionally deploy an Azure Key Vault. This template is deployed in [incremental mode](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-modes#incremental-mode).

    ```bash
    # 01-keyvault/
    cd 01-keyvault
    bash deploy-group.sh
    ```

2. Use another Bicep template to run a [Deployment Script](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/deployment-script-bicep#work-with-outputs-from-cli-script) that runs inside a container and installs the following on your AKS cluster.

    ```bash
    # 01-deploy-script/
    cd 01-deploy-script
    bash deploy-group.sh
    ```

3. (Optional) Step 2 uses the bash scripts in [02-keda-http](02-keda-http) to install the dependencies. If you prefer, you can run these manually at any time via [up.sh](up.sh) or [down.sh](down.sh).
    
    ```bash
    # 02-keda-http/
    cd keda-http

    # install
    bash up.sh

    # uninstall
    bash down.sh

    # authenticate
    bash auth.sh
    ```

4. Use the kubectl CLI tool and `kubectl apply -k` ([via kustomize](https://kustomize.io/)) to deploy a pre-built container `hello` container image of our [go-hello](go-hello) sample application.

    ```bash
    # 03-app/
    cd 03-app

    # (optional) run "az aks get-credentials" using the script mentioned in step 3.
    # bash ../02-keda-http/auth.sh

    # base
    kubectl apply -k ./base

    # keda-http
    # edit: my-image/kustomization.yaml
    # replace "host: 52.151.224.146" with the ip of your ingress controller
    kubectl apply -k ./keda-http

    # my-image
    # edit: my-image/kustomization.yaml
    # replace "newName: acrjxasx2.azurecr.io/asw101/test" with the name of your image, and "newTag" with the tag of your image, as applicable
    kubectl apply -k ./my-image
    ```

    You may now test and/or load test your application using curl or hey, and monitor it using kubectl or k9s. See [03-app/README.md](03-app/README.md#test) for sample snippets.

6. Build the [go-hello](go-hello) sample app, using a [distroless](https://github.com/GoogleContainerTools/distroless#why-should-i-use-distroless-images) container image, and deploy it from your own container registry.

    ```bash
    # go-hello/
    cd go-hello

    # build locally
    bash do/docker-build.sh

    # build locally using buildx (e.g. Apple Silicon/M1)
    bash do/docker-buildx.sh

    # login to github container registry
    bash do/ghcr-login.sh

    # push to github container registry
    export OWNER='asw101'
    export IMAGE='test'
    export TAG='latest'

    bash do/ghcr-push.sh

    # build with azure container registry
    bash do/acr-build
    ```

## 2. Serverless Go with Azure Container Apps (ACA)

## 2.2. Option 1: Quickstart + go-hello

Deploy your first Azure Container App using:

- [Quickstart: Deploy your first container app](https://docs.microsoft.com/en-ca/azure/container-apps/get-started?tabs=bash)

Build and deploy the [go-hello](go-hello) sample application using:

- [GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry) (including the public [ghcr.io/asw101/hello](https://github.com/users/asw101/packages/container/package/hello) sample image).
- [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-quickstart-task-cli) (See also: [Azure Container Apps > Concepts > Container registries](https://docs.microsoft.com/en-ca/azure/container-apps/containers#container-registries))

## 2.2. Option 2: Dapr (Distributed Application Runtime) or Background Processing Tutorials
- [Tutorial: Deploy a Dapr application to Azure Container Apps using the Azure CLI](https://docs.microsoft.com/en-ca/azure/container-apps/microservices-dapr?tabs=bash)
- [Tutorial: Deploy a Dapr application to Azure Container Apps using an ARM template](https://docs.microsoft.com/en-ca/azure/container-apps/microservices-dapr-azure-resource-manager?tabs=bash)
- [Tutorial: Deploy a background processing application with Azure Container Apps Preview]()

## 3. Get Go-ing with GitHub Actions

- See GopherCon 2021 sessions ([8 December @ 11:30am & 2:30pm EST](https://www.gophercon.com/agenda?speakers=1103097)) with David Justice ([@davidjustice](https://twitter.com/davidjustice)) and Aaron Wislang ([@as_w](https://twitter.com/as_w)).

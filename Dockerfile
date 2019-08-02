FROM bitnami/minideb:stretch
LABEL maintainer "Kubedex <admin@kubedex.com>"

ENV KUBE_LATEST_VERSION="v1.15.1"
ENV HELM_LATEST_VERSION="v2.14.3"
ENV HELMDIFF_LATEST_VERSION="v2.11.0%2B5"
ENV HELMSMAN_LATEST_VERSION="v1.11.0"
ENV K3S_LATEST_VERSION="v0.7.0"

RUN install_packages ca-certificates wget ansible \
    && wget -P /usr/local/bin https://github.com/rancher/k3s/releases/download/${K3S_LATEST_VERSION}/k3s \
    && wget -P /usr/local/bin https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl \
    && wget -c https://get.helm.sh/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz -O - | tar -xz -C /tmp && mv /tmp/linux-amd64/helm /tmp/linux-amd64/tiller -t /usr/local/bin \
    && mkdir -p /root/.helm/plugins && wget -c https://github.com/databus23/helm-diff/releases/download/${HELMDIFF_LATEST_VERSION}/helm-diff-linux.tgz -O - | tar -C /root/.helm/plugins -xzv \
    && wget -c https://github.com/Praqma/helmsman/releases/download/${HELMSMAN_LATEST_VERSION}/helmsman_1.11.0_linux_amd64.tar.gz -O - | tar -xz -C /tmp && mv /tmp/helmsman /usr/local/bin \
    && chmod +x -R /usr/local/bin \
    && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash", "-c"]

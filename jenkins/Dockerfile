FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    docker.io \
    curl \
    apt-transport-https \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# ✅ Install kubectl manual tanpa apt/gpg
RUN curl -LO https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

USER jenkins

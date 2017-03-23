FROM jenkins

# Install Skopos CLI
ADD https://s3.amazonaws.com/datagrid-public/sks-ctl /skopos/bin/
USER root
RUN chmod 755 /skopos/bin/sks-ctl

# Install docker
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable" && \
    apt-get update && \
    apt-get install -y docker-ce

USER jenkins

# Pre install Jenkins docker plugin
RUN /usr/local/bin/install-plugins.sh docker




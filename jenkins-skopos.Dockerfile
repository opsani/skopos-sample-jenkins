FROM jenkins

# Install Skopos CLI
USER root
ADD https://s3.amazonaws.com/get-skopos/edge/linux/skopos /skopos/bin/
RUN chmod 755 /skopos/bin/skopos

# Install docker
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
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

# Pre install Jenkins docker plugin
USER jenkins
RUN /usr/local/bin/install-plugins.sh docker

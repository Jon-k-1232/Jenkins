# Start with the official Jenkins image
FROM jenkins/jenkins:lts

# Switch to root user to install packages
USER root

# Update package list and install dependencies
RUN echo "deb http://ftp.de.debian.org/debian bookworm main" > /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y \
        jq \
        curl \
        gnupg \
        lsb-release

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-20.10.7.tgz | tar xzvf - --strip 1 -C /usr/local/bin docker/docker

# Switch back to the Jenkins user
USER jenkins

# Set a working directory
WORKDIR /var/jenkins_home

# Expose necessary ports
EXPOSE 8080
EXPOSE 50000

# Default entrypoint
ENTRYPOINT ["/usr/local/bin/jenkins.sh"]

# Use an official Jenkins LTS image as the base image
FROM jenkins/jenkins:lts

# Switch to root user for installation
USER root

# Install prerequisites and the .NET SDK
RUN apt-get update && \
    apt-get install -y wget gnupg && \
    wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-sdk-7.0

# Switch back to the Jenkins user
USER jenkins
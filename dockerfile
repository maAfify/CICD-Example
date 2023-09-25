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

# Install SonarScanner
RUN apt-get install -y unzip
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip -O sonar-scanner.zip && \
    unzip sonar-scanner.zip -d /opt && \
    mv /opt/sonar-scanner-4.6.2.2472-linux /opt/sonar-scanner && \
    ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
    rm sonar-scanner.zip

# Switch back to the Jenkins user
USER jenkins
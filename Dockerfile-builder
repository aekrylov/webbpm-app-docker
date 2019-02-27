FROM maven:3.6-jdk-8

# Install required nodejs version
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -qy nodejs

# Install additional tools
RUN apt-get install -qy zip unzip cabextract aria2 p7zip rsync

CMD mvn clean && mvn package -P CI,dev
FROM jetbrains/teamcity-agent:2019.1.2

# Install required nodejs version
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -qy nodejs

# Install additional tools
RUN apt-get install -qy zip unzip cabextract aria2 p7zip-full rsync

# Copy SSH keys
COPY .ssh /root/.ssh

# Set up Maven auth
COPY settings.xml /root/.m2/repository/

# Set up NPM auth
COPY .npmrc /root/
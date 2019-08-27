FROM jetbrains/teamcity-agent:2019.1.2

# Install utility packages for builds
RUN apt-get -q update && apt-get install -qy zip unzip cabextract aria2 p7zip-full rsync

# Install JavaFX
# TODO wrong; installs one more openjdk copy
RUN apt-get install -qy openjfx=8u161-b12-1ubuntu2 libopenjfx-jni=8u161-b12-1ubuntu2 libopenjfx-java=8u161-b12-1ubuntu2

# Install required nodejs version
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -qy nodejs

# Copy SSH keys
COPY .ssh /root/.ssh

# Set up Maven auth
COPY settings.xml /root/.m2/

# Set up NPM auth
COPY .npmrc /root/

# TODO make Docker available
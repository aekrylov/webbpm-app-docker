FROM jetbrains/teamcity-agent:2019.1.2

# Install utility packages for builds
RUN apt-get -q update && apt-get install -qy zip unzip cabextract aria2 p7zip-full rsync

# Install JavaFX
#TODO clean up afterwards
RUN apt-get download libopenjfx-java=8u161-b12-1ubuntu2 \
    && dpkg -x libopenjfx-java_8u161-b12-1ubuntu2*.deb openjfx \
    && cp -r openjfx/usr/share/java/openjfx/* /opt/java/openjdk/ \
    && rm -rf openjfx

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
# TODO chrome headless dependencies

# Use Ubuntu as base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV SERVER_NAME="Railway Minecraft Server"
ENV GAMEMODE=survival
ENV DIFFICULTY=easy
ENV ALLOW_CHEATS=false
ENV MAX_PLAYERS=10
ENV ONLINE_MODE=true
ENV WHITE_LIST=false
ENV SERVER_PORT=19132
ENV IPV4_PORT=19132
ENV IPV6_PORT=19133
ENV VIEW_DISTANCE=32
ENV TICK_DISTANCE=4
ENV PLAYER_IDLE_TIMEOUT=30
ENV MAX_THREADS=8
ENV LEVEL_NAME="Bedrock level"
ENV LEVEL_SEED=""
ENV DEFAULT_PLAYER_PERMISSION_LEVEL=member
ENV TEXTUREPACK_REQUIRED=false

# Install required packages
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create minecraft user and directory
RUN useradd -m -s /bin/bash minecraft
RUN mkdir -p /opt/minecraft
RUN chown minecraft:minecraft /opt/minecraft

# Download Minecraft Bedrock Server (Latest Version)
RUN wget https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.102.1.zip -O bedrock-server.zip
RUN unzip bedrock-server.zip
RUN rm bedrock-server.zip

# Make the server executable
RUN chmod +x bedrock_server

# Copy configuration script
COPY configure.sh /opt/minecraft/configure.sh
RUN chmod +x configure.sh

# Create worlds directory
RUN mkdir -p /opt/minecraft/worlds

# Expose the default Minecraft Bedrock port
EXPOSE 19132/udp

# Create startup script that handles volume permissions properly
RUN echo '#!/bin/bash' > start.sh && \
    echo 'cd /opt/minecraft' >> start.sh && \
    echo '# Check if worlds directory exists and create if needed' >> start.sh && \
    echo 'if [ ! -d "worlds" ]; then' >> start.sh && \
    echo '  mkdir -p worlds' >> start.sh && \
    echo 'fi' >> start.sh && \
    echo '# Check if we can write to worlds directory' >> start.sh && \
    echo 'if [ ! -w "worlds" ]; then' >> start.sh && \
    echo '  echo "WARNING: Cannot write to worlds directory. World data may not persist."' >> start.sh && \
    echo 'fi' >> start.sh && \
    echo './configure.sh' >> start.sh && \
    echo 'LD_LIBRARY_PATH=. ./bedrock_server' >> start.sh && \
    chmod +x start.sh

# Run as root to handle volume permissions
USER root

# Start the server
CMD ["./start.sh"]

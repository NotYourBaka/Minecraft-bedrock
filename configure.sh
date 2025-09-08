#!/bin/bash

# Configure server.properties
cat > server.properties << EOF
server-name=${SERVER_NAME}
gamemode=${GAMEMODE}
difficulty=${DIFFICULTY}
allow-cheats=${ALLOW_CHEATS}
max-players=${MAX_PLAYERS}
online-mode=${ONLINE_MODE}
white-list=${WHITE_LIST}
server-port=${SERVER_PORT}
server-portv6=${IPV6_PORT}
view-distance=${VIEW_DISTANCE}
tick-distance=${TICK_DISTANCE}
player-idle-timeout=${PLAYER_IDLE_TIMEOUT}
max-threads=${MAX_THREADS}
level-name=${LEVEL_NAME}
level-seed=${LEVEL_SEED}
default-player-permission-level=${DEFAULT_PLAYER_PERMISSION_LEVEL}
texturepack-required=${TEXTUREPACK_REQUIRED}
content-log-file-enabled=false
compression-threshold=1
server-authoritative-movement=server-auth
player-movement-score-threshold=20
player-movement-action-direction-threshold=0.85
player-movement-distance-threshold=0.3
player-movement-duration-threshold-in-ms=500
correct-player-movement=false
server-authoritative-block-breaking=false
EOF

echo "Server configured successfully!"
echo "Server will start on port ${SERVER_PORT}"
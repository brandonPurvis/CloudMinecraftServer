#!/bin/bash

DOWNLOAD_URL="https://launcher.mojang.com/v1/objects/ed76d597a44c5266be2a7fcd77a8270f1f0bc118/server.jar"
SERVER_FILENAME="server.jar"
wget -O $SERVER_FILENAME $DOWNLOAD_URL
echo "eula=true" > "eula.txt"
#!/bin/bash
JDK_DOWNLOAD_URL="https://download.java.net/java/GA/jdk12.0.1/69cfe15208a647278a19ef0990eea691/12/GPL/openjdk-12.0.1_linux-x64_bin.tar.gz"
JDK_FOLDER_NAME="jdk-12.0.1"
wget -O java-jar.tar.gz $JDK_DOWNLOAD_URL
mkdir -p /usr/lib/jvm
tar -zxf java-jar.tar.gz -C /usr/lib/jvm
update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/$JDK_FOLDER_NAME/bin/java" 1


DOWNLOAD_URL="https://launcher.mojang.com/v1/objects/ed76d597a44c5266be2a7fcd77a8270f1f0bc118/server.jar"
SERVER_FILENAME="server.jar"
SERVER_ROOT="/server"

mkdir $SERVER_ROOT
cd $SERVER_ROOT
wget -O $SERVER_FILENAME $DOWNLOAD_URL
echo "eula=true" > "eula.txt"
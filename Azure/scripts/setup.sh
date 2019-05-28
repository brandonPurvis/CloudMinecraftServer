#!/bin/bash

# Install Java
jdk_url="https://download.java.net/java/GA/jdk12.0.1/69cfe15208a647278a19ef0990eea691/12/GPL/openjdk-12.0.1_linux-x64_bin.tar.gz"
jdk_folder="jdk-12.0.1"
wget -O java-jar.tar.gz $jdk_url
mkdir -p /usr/lib/jvm
tar -zxf java-jar.tar.gz -C /usr/lib/jvm
update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/$jdk_folder/bin/java" 1

# Install Server
server_jar_url="https://launcher.mojang.com/v1/objects/ed76d597a44c5266be2a7fcd77a8270f1f0bc118/server.jar"
minecraft_server_path="/server"
server_jar="server.jar"
owner_username="bcpmax"

# adjust memory usage depending on VM size
totalMem=$(free -m | awk '/Mem:/ { print $2 }')
if [ $totalMem -lt 2048 ]; then
    memoryAllocs=1g
    memoryAllocx=2g
else
    memoryAllocs=2g
    memoryAllocx=4g
fi

mkdir $minecraft_server_path
cd $minecraft_server_path
wget -O $server_jar $server_jar_url

# create the eula file
touch $minecraft_server_path/eula.txt
echo 'eula=true' >> $minecraft_server_path/eula.txt

# create a service
touch /etc/systemd/system/minecraft-server.service
printf '[Unit]\nDescription=Minecraft Service\nAfter=rc-local.service\n' >> /etc/systemd/system/minecraft-server.service
printf '[Service]\nWorkingDirectory=%s\n' $minecraft_server_path >> /etc/systemd/system/minecraft-server.service
printf 'ExecStart=/usr/bin/java -Xms%s -Xmx%s -jar %s/%s nogui\n' $memoryAllocs $memoryAllocx $minecraft_server_path $server_jar >> /etc/systemd/system/minecraft-server.service
printf 'ExecReload=/bin/kill -HUP $MAINPID\nKillMode=process\nRestart=on-failure\n' >> /etc/systemd/system/minecraft-server.service
printf '[Install]\nWantedBy=multi-user.target\nAlias=minecraft-server.service' >> /etc/systemd/system/minecraft-server.service
chmod +x /etc/systemd/system/minecraft-server.service

# set user preferences in server.properties
touch $minecraft_server_path/server.properties
printf 'difficulty=1\n' >> $minecraft_server_path/server.properties
printf 'level-name=world\n' $3 >> $minecraft_server_path/server.properties
printf 'gamemode=0\n' $4 >> $minecraft_server_path/server.properties
systemctl start minecraft-server
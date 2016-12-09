#!/usr/bin/env bash
echo "Please enter your sudo password:"
sudo ls &> $BASEDIR/logs/logs.txt
clear
if curl --output /dev/null --silent --head --fail "www.tcpr.ca"; then
  clear
else
  echo "Connection can not be made to www.tcpr.ca"
  exit 1
fi
if curl --output /dev/null --silent --head --fail "hub.spigotmc.org"; then
  echo "Can contact hub.spigotmc.org"
else
  echo "Connection can not be made to hub.spigotmc.org"
  exit 1
fi
if curl --output /dev/null --silent --head --fail "dev.bukkit.org"; then
  echo "Can contact dev.bukkit.org"
else
  echo "Connection can not be made to dev.bukkit.org"
  exit 1
fi
VER=$(ls | grep "jar" | grep "spigot")
BASEDIR=$(dirname "$0")
mkdir $BASEDIR/BuildTools
mkdir $BASEDIR/logs/
touch $BASEDIR/logs/logs.txt &> $BASEDIR/logs/logs.txt
which java &> /dev/null || { echo >&2 "I require java but it's not installed.  Aborting."; exit 1; }
				echo "Java is installed."
cd $BASEDIR

which git &> /dev/null || { echo >&2 "I require git but it's not installed.  Aborting."; exit 1; }
echo "Git is installed."
clear
# Debugging: echo "Everything required is installed. Downloading BuildTools.jar..."0
echo -ne '### (23%)\r'
wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar &> /dev/null && java -jar BuildToo.jar &> /dev/null
echo -ne '#####                     (33%)\r'
#wget  http://tcpr.ca/files/spigot/spigot-latest.jar  --no-check-certificate &> $BASEDIR/logs/logs.txt
# Debugging: echo "Compiling your tools. Will take a while."
echo -ne '#########                (66%)\r'
java -jar $BASEDIR/BuildTools.jar &> $BASEDIR/logs/logs.txt
# Debugging: echo "Creating startup script"
wget -N  174.56.96.124/mc/start.sh --no-check-certificate &> $BASEDIR/logs/logs.txt
cd $BASEDIR/plugins/ &> $BASEDIR/logs/logs.txt
mkdir ./plugins
wget -N  https://dev.bukkit.org/media/files/909/154/PermissionsEx-1.23.4.jar --no-check-certificate &> $BASEDIR/logs/logs.txt
wget -N  https://dev.bukkit.org/media/files/911/841/ChatEx.jar --no-check-certificate &> $BASEDIR/logs/logs.txt 
wget -N  https://dev.bukkit.org/media/files/922/48/worldedit-bukkit-6.1.3.jar --no-check-certificate &> $BASEDIR/logs/logs.txt
mv PermissionsEx-1.23.4.jar ./plugins
mv ChatEx.jar ./plugins
mv worldedit-bukkit-6.1.3.jar ./plugins
touch $BASEDIR/start.sh
cat > $BASEDIR/start.sh << 'EndOfMessage'  # Quotes prevent expansions in the here-doc
 BASEDIR=$(dirname "$0")
 cd $BASEDIR/
 VER=$(ls | grep "jar" | grep "spigot")
 java -Xmx1024M -XX:MaxPermSize=128M -jar $VER -o true 
 sleep 5
 echo "Restarting..." && bash $BASEDIR/start.sh
EndOfMessage

 echo -ne '###########             (90%)\r'
 sleep 1
 rm     $BASEDIR/craftbukkit-*
 echo -ne '###########             (91%)\r'
 sleep 1
 rm -rf $BASEDIR/CraftBukkit 
 echo -ne '#############           (92%)\r'
 sleep 1
 rm -rf $BASEDIR/Bukkit
 echo -ne '###############         (93%)\r'
 sleep 1
 rm -rf $BASEDIR/BuildTools.log.*
 echo -ne '#################      (94%)\r'
 sleep 1
 rm -rf $BASEDIR/plugins
 echo -ne '##################     (95%)\r'
 sleep 1
 rm -rf $BASEDIR/work
 echo -ne '###################    (96%)\r'
 sleep 1
 rm -rf $BASEDIR/plugins
 echo -ne '####################   (97%)\r'
 sleep 1
 rm -rf $BASEDIR/BuildData
 echo -ne '#####################  (98%)\r'
 sleep 1
 rm -rf $BASEDIR/BuildTools
 echo -ne '######################  (99%)\r'
 sleep 1
 sudo chmod 775 -R $BASEDIR 
 cd $BASEDIR/
 VER=$(ls | grep "jar" | grep "spigot")
 java -Xmx1024M -XX:MaxPermSize=128M -jar $VER -o true | grep "agree"
 echo -ne '#######################   (100%)\r\n'
 #echo Finished. You can start your server by typing "bash $BASEDIR/start.sh" in your terminal. 
 

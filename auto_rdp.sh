#!/bin/bash
clear

# ASCII Banner
echo " /$$$$$$$   /$$$$$$   /$$$$$$  /$$$$$$$$       /$$   /$$  /$$$$$$  /$$$$$$$  /$$$$$$"
echo "| $$__  $$ /$$__  $$ /$$__  $$|__  $$__/      | $$$ | $$ /$$__  $$| $$__  $$|_  $$_/"
echo "| $$  \ $$| $$  \ $$| $$  \ $$   | $$         | $$$$| $$| $$  \ $$| $$  \ $$  | $$  "
echo "| $$$$$$$/| $$  | $$| $$  | $$   | $$         | $$ $$ $$| $$  | $$| $$$$$$$   | $$  "
echo "| $$__  $$| $$  | $$| $$  | $$   | $$         | $$  $$$$| $$  | $$| $$__  $$  | $$  "
echo "| $$  \ $$| $$  | $$| $$  | $$   | $$         | $$\  $$$| $$  | $$| $$  \ $$  | $$  "
echo "| $$  | $$|  $$$$$$/|  $$$$$$/   | $$         | $$ \  $$|  $$$$$$/| $$$$$$$/ /$$$$$$"
echo "|__/  |__/ \______/  \______/    |__/         |__/  \__/ \______/ |_______/ |______"
                                                                                    
echo "                    root@nobi"
echo


# Install Docker if not installed
if ! command -v docker &> /dev/null; then
    echo "[INFO] Installing Docker..."
    apt-get update -y && apt-get install -y docker.io
    systemctl enable --now docker
fi

# Pull Web RDP Docker image
echo "[INFO] Pulling Web RDP Docker image..."
docker pull dorowu/ubuntu-desktop-lxde-vnc

# Remove old container if exists
docker rm -f mc-web-rdp &>/dev/null

# Run Web RDP container
echo "[INFO] Starting Web RDP container..."
docker run -d \
  -p 8080:80 \
  -e USER=root \
  -e PASSWORD=123456 \
  --name mc-web-rdp \
  dorowu/ubuntu-desktop-lxde-vnc

# Done
echo "[SUCCESS] Web RDP running at: http://localhost:8080"
echo "[LOGIN] Username: root | Password: 123456"

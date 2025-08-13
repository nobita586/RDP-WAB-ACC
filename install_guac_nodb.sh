#!/bin/bash
set -e

echo "📦 Installing Apache Guacamole (No MySQL)..."

# Pull Guacamole and guacd images
docker pull guacamole/guacd
docker pull guacamole/guacamole

# Create network
docker network create guacnet || true

# Run guacd
docker run -d --name guacd --network guacnet guacamole/guacd

# Run Guacamole (in-memory auth, default user/pass)
docker run -d \
  --name guacamole \
  --network guacnet \
  -e GUACAMOLE_HOME=/guac-home \
  -v $(pwd)/guac-home:/guac-home \
  -p 8080:8080 \
  guacamole/guacamole

# Wait for Guacamole to start
echo "⏳ Waiting for Guacamole to start..."
sleep 15

# Create default user mapping (no MySQL)
mkdir -p guac-home
cat > guac-home/user-mapping.xml <<EOF
<user-mapping>
    <authorize username="guacadmin" password="guacadmin">
        <connection name="My RDP Server">
            <protocol>rdp</protocol>
            <param name="hostname">127.0.0.1</param>
            <param name="port">3389</param>
            <param name="ignore-cert">true</param>
        </connection>
    </authorize>
</user-mapping>
EOF

echo "✅ Guacamole installed!"
echo "🌐 Open: http://$(hostname -I | awk '{print $1}'):8080/guacamole"
echo "👤 Login: guacadmin / guacadmin"

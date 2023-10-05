#!/bin/bash

# Install Apache
sudo apt-get update
sudo apt-get install -y apache2

# Get the VM's hostname, private IP address, and Azure region
hostname=$(hostname)
ip_address=$(hostname -I | awk '{print $1}')
region=$(curl -H Metadata:true "http://169.254.169.254/metadata/instance/compute/location?api-version=2020-09-01&format=text" | tr -d '\r')

# Create an HTML file with the VM information
cat <<EOF | sudo tee /var/www/html/default.html
<!DOCTYPE html>
<html>
<head>
    <title>Azure VM Info</title>
</head>
<body>
    <h1>Hostname: $hostname</h1>
    <h1>IP Address: $ip_address</h1>
    <h1>Region: $region</h1>
</body>
</html>
EOF

# Restart Apache to apply the configuration
sudo systemctl restart apache2

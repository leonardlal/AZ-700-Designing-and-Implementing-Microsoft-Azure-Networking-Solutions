<powershell>
# Install IIS and required components
Install-WindowsFeature -Name Web-Server -IncludeManagementTools -LogPath "$env:TEMP\init-webservervm_webserver_install_log_$logLabel.txt"

# Get the VM's hostname, private IP address, and Azure region
$hostname = $env:COMPUTERNAME
$ipAddress = (Get-NetIPAddress | Where-Object {$_.AddressFamily -eq "IPv4" -and $_.InterfaceAlias -eq "Ethernet"}).IPAddress
$region = (Invoke-RestMethod -Uri "http://169.254.169.254/metadata/instance/compute/location?api-version=$apiVersion&format=text").ToLower()

# Create an HTML file with the VM information
$htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>Azure VM Info</title>
</head>
<body>
    <h1>Hostname: $hostname</h1>
    <h1>IP Address: $ipAddress</h1>
    <h1>Region: $region</h1>
</body>
</html>
"@

# Save the HTML content to the default IIS website folder
$htmlContent | Set-Content -Path "C:\inetpub\wwwroot\default.html" -Force

</powershell>

$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=VPNRoot" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign

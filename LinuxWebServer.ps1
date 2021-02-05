Configuration LinuxWebServer 
{

Import-DSCResource -Module nx

Node localhost
 {
    nxPackage httpd
    {
        Name = "httpd"
        Ensure = "Present"
        PackageManager = "Yum"
    }

    nxFile DocumentRoot
    {
        DestinationPath = "/var/www/html/index.html"
        Contents = "Hello World I'm Hall`n"
        Ensure = "Present"
        Type = "File"
    }

    #Apache Service
    nxService ApacheService {
        Name = 'httpd'
        State = 'running'
        Enabled = $true
        Controller = 'systemd'
    }

    nxScript AddFirewallRuleFirewalld {
    SetScript = @'
#!/bin/bash
firewall-cmd --permanent --add-service http
firewall-cmd --reload
'@
    }
 }
}
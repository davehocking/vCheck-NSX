# Start of Settings
# Enter the FQDN of the NSX Manager
$nsxmgr = ""
# End of Settings

<#

    NOTES ON SECURE CREDENTIAL STORAGE
    Use the following to create a credential interactively, then store it as an XML file
    
    $newPScreds = Get-Credential -message "Enter the NSX manager admin credentials here:"
    $newPScreds | Export-Clixml nsxmgrCreds.xml

    Once you have the file, move it into the root of the NSX plugins folder, overwriting the blank file that's there

#>

$creds = Import-Clixml "$(Split-Path $MyInvocation.ScriptName)\Plugins\15 NSX\nsxmgrCreds.xml"
Connect-NsxServer -Server $nsxmgr -Credential $creds -DisableVIautoconnect

$Title = "Connection settings for NSX"
$Author = "Dave Hocking"
$PluginVersion = 0.1
$Header = "Connection Settings"
$Comments = "Connection Plugin for connecting to NSX"
$Display = "None"
$PluginCategory = "NSX"

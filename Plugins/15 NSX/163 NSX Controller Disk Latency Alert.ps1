# Start of Settings
# End of Settings 

# Ideal state of Latency Warning Field
$latencyWarning = "FALSE"

# Controller Components
$nsxCtrls = Get-NsxController

# Check for controllers with no "UNKNOWN" status and where it doesn't match the ideal value above
if ($nsxCtrls | Where-Object {$_.diskLatencyAlertDetected -ne $latencyWarning} | Where-Object {$_.diskLatencyAlertDetected -ne "UNKNOWN"})
{
    $NsxCtrlDiskLatTable = New-Object system.Data.DataTable "NSX Controller Disk Latency Warnings"

    # Define Columns
    $cols = @()
    $cols += New-Object system.Data.DataColumn Name,([string])
    $cols += New-Object system.Data.DataColumn Datastore,([string])
    $cols += New-Object system.Data.DataColumn "Latency Alert",([string])
    
    #Add the Columns
    foreach ($col in $cols) {$NsxCtrlDiskLatTable.columns.add($col)}

    # Enumerate through each controller and populate the table
    foreach ($ctrl in $nsxCtrls)
    {
        # Populate a row in the Table
        $row = $NsxCtrlDiskLatTable.NewRow()

        # Enter data in the row
        $row.Name = $ctrl.name
        $row.Datastore = $ctrl.datastoreInfo.name
        $row."Latency Alert" = $ctrl.diskLatencyAlertDetected
                
        # Add the row to the table
        $NsxCtrlDiskLatTable.Rows.Add($row)
    }   

    # Display the Status Table
    $NsxCtrlDiskLatTable | Select-Object Name,Datastore,"Latency Alert"
}

# Plugin Outputs
$PluginCategory = "NSX"
$Title = "NSX Controller Disk Latency Alert"
$Header = "NSX Controller Disk Latency Alert"
$Comments = "NSX Controller(s) are reporting disk latency warnings"
$Display = "Table"
$Author = "Dave Hocking"
$PluginVersion = 0.1



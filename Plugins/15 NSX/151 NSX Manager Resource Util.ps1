# Start of Settings
# Define %-age threshold for CPU Use
$NSXmgrCPUuseThreshold = 50
# Define %-age threshold for Memory Use
$NSXmgrRAMuseThreshold = 75
# Define %-age threshold for Disk Space consumption
$NSXmgrDiskUseThreshold = 75
# End of Settings


# Gather system info for NSX manager
$nsxmgrsysinfo = Get-NsxManagerSystemSummary
$NSXmgrCPUuse = $nsxmgrsysinfo.cpuInfoDto.usedPercentage
$NSXmgrRAMuse = $nsxmgrsysinfo.memInfoDto.usedPercentage
$NSXmgrDiskUse = $nsxmgrsysinfo.storageInfodto.usedPercentage

# Check if info exceeds thresholds, then report
if ($NSXmgrCPUuse -gt $NSXmgrCPUuseThreshold -or $NSXmgrRAMuse -gt $NSXmgrRAMuseThreshold -or $NSXmgrDiskUse -gt $NSXmgrDiskUseThreshold)
{
    # Build new table
    $resourceTable = New-Object system.Data.DataTable "NSX Manager"

    # Define Columns
    $cols = @()
    $cols += New-Object system.Data.DataColumn Name,([string])
    $cols += New-Object system.Data.DataColumn "CPU Use",([int])
    $cols += New-Object system.Data.DataColumn "RAM Use",([int])
    $cols += New-Object system.Data.DataColumn "Disk Use",([int])

    #Add the Columns
    foreach ($col in $cols) {$resourceTable.columns.add($col)}

    # Populate a row in the Table
    $row = $resourceTable.NewRow()

    # Enter data in the row
    $row.Name = $nsxmgr
    $row."CPU Use" = $NSXmgrCPUuse
    $row."RAM Use" = $NSXmgrRAMuse
    $row."Disk Use" = $NSXmgrDiskUse
        
    # Add the row to the table
    $resourceTable.Rows.Add($row)

    # Display the resource table
    $resourceTable | Select-Object Name,"CPU Use","RAM Use","Disk Use"
}

# Plugin Outputs
$PluginCategory = "NSX"
$Title = "NSX Manager Resource Util"
$Header = "NSX Manager Resource Util"
$Comments = "The following NSX Manager is using > $($NSXmgrCPUuseThreshold)% CPU, >$($NSXmgrRAMuseThreshold)% RAM or >$($NSXmgrDiskuseThreshold)% Disk"
$Display = "Table"
$Author = "Dave Hocking"
$PluginVersion = 0.1



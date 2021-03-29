$Location = "C:\Temp"
# Filter result from Get-Command
Get-Command -Name *Diag*
# Get all params and info about Get-Command
Get-Help Get-Command -Detailed
Get-Help Get-ComputerInfo
# Manage files and folders
# Get items in specified location
Get-ChildItem "$($Location)"

# Create, Copy, move, rename, remove item
"Create new item" | New-Item "$($Location)\Data\item1.txt"
Copy-Item "$($Location)\Data\item1.txt" -Destination "$($Location)\Data\item1 - Copy.txt"
Copy-Item "$($Location)\Data" -Destination "$($Location)\Copied Data" -Recurse
Move-Item "$($Location)\Data\item1 - Copy.txt" -Destination "$($Location)\Data\Moved Items\item1_copy.txt" -Force
Rename-Item "$($Location)\Data\Moved Items\item1_copy.txt" -NewName "item1_renamed.txt"
Remove-Item "$($Location)\Copied Data\item1.txt"

# Powershell for reporting
# Export-csv send output to a csv file
Get-Command -Verb Export | Select-Object CommandType, Name, Version, Source | Export-Csv -NoTypeInformation "$($Location)\data\reports_cmd.csv"
# Out-File send output to a text file. Use -Append to append text to existing text file
Get-Command -Verb Export | Select-Object CommandType, Name, Version, Source | Out-File "$($Location)\Data\reports_cmd.txt"

# Manage processes
$session = New-PSSession -ComputerName localhost
Enter-PSSession -Session $session
Get-Process
Exit-PSSession
Get-Process -Id 17912 | Stop-Process

# Manage Event logs
Get-Command -Name *Event*
# Get-EventLog
Get-WinEvent -LogName System -MaxEvents 5
$logs = Get-WinEvent -LogName Application -MaxEvents 5
# Clear EventLog
foreach($log in $logs){ wevtutil.exe cl $log.LogName }

# Get computer information
$report = "C:\Temp\Data\reports.log"
$physicalMemory = Get-CimInstance -ClassName Win32_PhysicalMemory
$processor = Get-CimInstance -ClassName Win32_Processor
$logicalDisk = Get-CimInstance -ClassName Win32_LogicalDisk
$diskDrive = Get-CimInstance -ClassName Win32_DiskDrive
$operatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem

New-Item -Path $report -ItemType File -Value "Computer Information"
Add-Content $report "************Physical Memory************"
Add-Content $report $physicalMemory
Add-Content $report "*************Processor******************"
Add-Content $report $processor
Add-Content $report "**************Logical Disk***************"
Add-Content $report $logicalDisk
Add-Content $report "************Disk Drive****************"
Add-Content $report $diskDrive
Add-Content $report "*************Operating System*************"
Add-Content $report $operatingSystem

# Powershell remoting
Enter-PSSession localhost
Exit-PSSession
# Execute command on remote computer
Invoke-Command -ComputerName localhost -ScriptBlock { Get-Process }
$session = New-PSSession -ComputerName localhost
# $Processes = Invoke-Command -Session $session { Get-Process }
foreach($process in $Processes) { Write-Output $process.Name }

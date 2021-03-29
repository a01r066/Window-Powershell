#Understand cmdlet syntax
// Retrieve all services, sorted by current status
Get-Service | Sort-Object -Property Status

// Get all services, excluding stoppec services and display names only
Get-Service | Where-Object { $_.Status -eq "Running" } | Select-Object DisplayName

// Display text, then save to text file
"I can now use Powershell Pipe Command!!" | Out-File "C:\Temp\file.txt"

#Understand terse commands
Get-Command Format-Table
Get-Command ft
gcm ft
Get-Alias
Set-Alias -Name "" -Value "" -Description ""
Get-Command | Where-Object { $_.ParameterSets.Count -gt 2 } | Format-List Name
gcm | ?  { $_.ParameterSets.Count -gt 2 } | fl Name
Write-Output "Test Message"
echo "Test Message"
Get-Process
gps

#Utilize variable
$var1 = "Test value 1"
$var1
Write-Host $var1
$var2 = Get-ComputerInfo
$var2
$var2.BiosBIOSVersion
$var2.TimeZone
$var3 = "WSearch"
$var3
Get-Service -Name $var3
Get-Service | Sort-Object -Property Status
Get-Service | Where-Object { $_.Status -eq "Running" } | Select-Object displayName
$var4 = Get-Service
$var5 = $var4 | Where-Object { $_.Status -eq "Running" }
$var6 = $var5 | Select-Object DisplayName
$var6
"This is some sample text" | Out-File "C:\Temp\file.text"
Get-ChildItem Env:
$env:SystemRoot
// Create environment variable
$env:DEOMO = "My Test Value" 
$varTest = "1"
$varTest
[Int32]$varTest
[float]$varTest
[string]$varTest
[boolean]$varTest
$varTest

#Understand powershell objects
Get-Service -ServiceName 'Dnscache' | Get-Member
Get-Service -ServiceName 'Dnscache' | Get-Member -MemberType Property
Get-Service -ServiceName 'Dnscache' | Select-Object -Property 'StartType'
Get-Service -ServiceName 'Dnscache' | Get-Member -MemberType 'AliasProperty'
$svc = Get-Service -ServiceName 'Dnscache'
$svc
$svc.RequiredServices
Get-Service -ServiceName 'Dnscache' | Get-Member -MemberType 'Method'
Get-Service -Servicename * | Select-Object -Property 'Status', 'DisplayName' | Sort-Object -Property 'Status' -Descending

#Powershell security
// Change the execution policy to unrestricted
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
// Change the execution policy to unrestricted for the current user scope
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
// Launching Powershell with execution policy set
pwsh.exe -ExecutionPolicy Unrestricted

#Create your first script
$service = Read-Host "Please type the service to view"
$variable = Get-Service -Name $service

Write-Host $variable.Name -ForegroundColor Yellow
Write-Host $variable.DisplayName -ForegroundColor Green
Write-Host $variable.Description -ForegroundColor Red

#Parameter attributes for scripts and functions
$myMessage = "My message"
function Display-Message1($message){
    Write-Host $message
}
Display-Message1($myMessage)

function Display-Message2(){
    [String]$value1 = $args[0]
    [string]$value2 = $args[1]
    Write-Host $value1 $value2
}
Display-Message2 "Value1", "Value 2"
Display-Message2 "Value1"


function Display-Message3() {
    param (
        [Parameter(Mandatory=$true)]
        [String]$Text
    )
    Write-Host $Text
}
Display-Message3

function Display-Message4() {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("Lexus", "Porsche", "Toyota")]
        [String]$Text
    )
    Write-Host "I like to drive a " $Text
}
Display-Message4
Display-Message4 -Text Porsche

#Select information
Get-Process | Select-Object -Property ProcessName, Id, WS
Get-Process explorer | Select-Object ProcessName
$variable = Get-Process explorer
$variable
Get-Process explorer | Select-Object -Property ProcessName -ExpandProperty Modules
Get-Process | Sort-Object -Property WS | Select-Object -Last 5
"one", "two", "three", "one", "two" | Select-Object -Unique -Skip 1
$object = [pscustomobject]@{Name="MyObject";Expand=@("one", "two", "three", "four", "five")}
$object | Select-Object -ExpandProperty Expand -Property Name | Get-Member

#Filter specific data
Get-Command | Where-Object { $_.CommandType -eq 'cmdlet' }
Get-Command | Where-Object { $_.Name -like '*invoke*' }
Get-Command | Where-Object { ($_.Name -like '*invoke*') -and ($_.CommandType -eq 'cmdlet') }
Get-Command -CommandType Cmdlet | Where-Object { $_.Name -like '*invoke*' }
Get-Service | Where-Object -Property Status -eq -Value 'running'
Get-Service | Where-Object { $_.Status -eq 'running' }

#Control flow of powershell
$value = 15
if($value -lt 9)
    { Write-Host "We have a value less than 9" }
else{ Write-Host "Value is greater than 9" }
$a = 1
$b = 2
if($a -eq $b){ $message1 = "True" }
else { $message1 = "False"}

if($a -lt $b){ $message2 = "True" }
else { $message2 = "False"}

if($a -gt $b){ $message3 = "True" }
else { $message3 = "False"}

$message1
$message2
$message3

$messageObject = [PSCustomObject]@{
    "message1" = $message1 
    "message2" = $message2 
    "message3" = $message3
}
$messageObject.message2

#Switch statement
$input = Read-Host "Enter you brand new car: "
switch ($input) {
    Brand1 { "You typed: " + $input  }
    Brand2 { "You typed: " + $input }
    Default { "You did not type a brand" }
}

#Define custom help
function addThreeNumber() {
    param (
        # specify the number
        [Int32]$first,
        [Int32]$second,
        [Int32]$third
    )

    # calculate the result
    $result = $first + $second + $third

    # send result to the console
    Write-Host $first " + " $second " + " $third " = " $result
}
addThreeNumber -first 2 -second 3 -third 4

# Navigate the file system
Get-ChildItem C:\Temp
Get-ChildItem -Path C:\Temp
# show system and hidden items
Get-ChildItem -Force C:\Temp
Get-ChildItem C:\Temp -Name
Get-ChildItem -Path C:\Temp\*.txt -Recurse -Force

# Manage files and directories
Get-Command *item*
$Location = "C:\Temp"
Get-ChildItem -Force -Recurse $Location
Get-ChildItem -Path $Location -Recurse -Exclude *.xlsx
Get-ChildItem -Path $Location -Recurse | Where-Object -FilterScript { ($_.LastWriteTime -gt '2020-10-22') }
$Location = "C:\Temp"
New-Item -Path "$($Location)'\PSFolderNew\PSFile.txt" -ItemType File -Force
$document = "Lorem ipsum dolr sit"
$document | Out-File -FilePath "$($Location)\PsFolderNew\PSDocument.txt"
New-Item -Path "$($Location)\PSFolderNew\PSFile.txt" -ItemType File -Force
Remove-Item -Path "$($Location)\PSFolderDelete" -Recurse -Force
Copy-Item -Path "$($Location)\PSFolderNew\PSDocument.txt" -Destination "$($Location)\PSFolderNewCopy\PSDocumentCopy.txt"
Copy-Item -Path "$($Location)\PSFolderNew" -Destination "$($Location)\PSFolderNewCopy" -Recurse -Force
Rename-Item -Path "$($Location)\PSFolderNewCopy\PSFile.txt" -NewName "PSFileRename.txt"
Get-ChildItem "$($Location)\PSFolderNew\*.txt" | Rename-Item -NewName { $_.Name -replace '\.txt$', '.bak'}

# Retrieve data
$Location = "C:\Temp\PSFolderNew"
1..100 | ForEach-Object { Add-Content -Path "$($Location)\PSNumber.txt" -Value "Line: $_" }
Get-Content -Path "$($Location)\PSNumber.txt"
$Path = "$($Location)\simple.xml"
$XPath = "breakfast_menu/food/name"
Select-Xml -Path $Path -XPath $XPath | Select-Object -ExpandProperty Node

Get-Process | Export-Csv -Path "$($Location)\processes.csv"
$processes_csv = Import-Csv -Path "$($Location)\processes.csv" 
$processes_csv | Format-Table

Get-Process | Export-Csv -Path "$($Location)\processes_delimeter.csv" -Delimiter :
$processes_csv_delimeter = Import-Csv -Path "$($Location)\processes_delimeter.csv" -Delimiter :
$processes_csv_delimeter | Format-Table

$Location = "C:\Temp\PSFolderNew"
$simplecsv = Import-Csv -Path "$($Location)\simple.csv" 
$simplecsv | Format-Table

$processes_csv = Import-Csv -Path "$($Location)\processes.csv" | ForEach-Object { Write-Host "$($_.Name) of $($_.Company)" }
$processes_csv | Format-Table

# Working with json objects
$Location = "C:\Temp\PSFolderNew"
systeminfo /fo CSV | ConvertFrom-Csv | ConvertTo-Json | Out-File -Path "$($Location)\ComputerInfo.json"
$jsonObject = Get-Content -path "$($Location)\ComputerInfo.json" | ConvertFrom-Json
$jsonObject
$jsonObject.'Host Name'

$jsonObject = @{}
$jsonObject
$arrayList = New-Object System.Collections.ArrayList
$arrayList.Add(@{ "name" = "Andy"; "gender" = "M"})
$arrayList.Add(@{ "name" = "Murray"; "gender" = "F"})
$arrayList.Add(@{ "name" = "Charlies"; "gender" = "M"})
$arrayList
$employees = @{ "Employees" = $arrayList }
$employees
$jsonObject.Add("Data", $employees)
$jsonObject | ConvertTo-Json -Depth 10

# Powershell remoting
Enable-PSRemoting -Force
Get-PSSessionConfiguration
$session = New-PSSession -ComputerName localhost
$session
Invoke-Command -Session $session -ScriptBlock { $PSVersionTable }
Enter-PSSession localhost
HOSTNAME
Get-UICulture
Exit-PSSession

# Combine commands
# template
Get-Command | Where-Object {} | Sort-Object {} | Select-Object Name
Write-Host "Primary message" && Write-Host "Second message"
Write-Error "Primary error" && Write-Host "Secondary message"
Write-Host "Primary message" || Write-Host "Secondary message"
Write-Error "Primary error" || Write-Host "Secondary message"

$variable = $null
$variable 
if($null -eq $variable) { "No value is found "} else { $variable }

# Practical powershell remoting
# Script to retrieve details about the desktop
$Location = "C:\Temp\PSFolderNew"

# Retrieve Desktop Settings
$desktop = Get-CimInstance -ClassName Win32_Desktop

# Retrieve BIOS Information
$bios = Get-CimInstance -ClassName Win32_BIOS

# Retrieve Processor Information
$processor = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property SystemType

# Get Computer Manufacturer Details
$manufacturer = Get-CimInstance -ClassName Win32_ComputerSystem

# Get Installed Hotfixes
$hotfixes = Get-CimInstance -ClassName Win32_QuickFixEngineering

# Get Operating System Version Information
$operatingsystem = Get-CimInstance -ClassName Win32_OperatingSystem | `
    Select-Object -Property BuildNumber,BuildType,OSType,ServicePackMajorVersion,ServicePackMinorVersion

# Get Users and Owners
$usergroups = Get-CimInstance -ClassName Win32_OperatingSystem | `
    Select-Object -Property NumberOfLicensedUsers,NumberOfUsers,RegisteredUser

# Get Currently Logged-on User
$loggedon = Get-CimInstance -ClassName Win32_ComputerSystem -Property UserName

# Get All Services Status
$services = Get-CimInstance -ClassName Win32_Service | Select-Object -Property Status,Name,DisplayName


# Create File
$report = "$($Location)\Report.log"
New-Item $report -ItemType File -Value "Desktop Report"
Add-Content $report "********** Desktop Details **********"
Add-Content $report $desktop
Add-Content $report "********** Bios Details **********"
Add-Content $report $bios
Add-Content $report "********** Processor Details **********"
Add-Content $report $processor
Add-Content $report "********** Manufacturer Details **********"
Add-Content $report $manufacturer
Add-Content $report "********** Hotfix Details **********"
Add-Content $report $hotfixes
Add-Content $report "********** Operating System Details **********"
Add-Content $report $operatingsystem
Add-Content $report "********** Users and Groups Details **********"
Add-Content $report $usergroups
Add-Content $report "********** Logged On User Details **********"
Add-Content $report $loggedon
Add-Content $report "********** Services Details **********"
Add-Content $report $services

# Powershell in remote computer
$Location = "C:\Temp\PSFolderNew"
$session = New-PSSession -ComputerName localhost
$session
Invoke-Command -Session $session -ScriptBlock { "$($Location)\Remote.ps1" }
Invoke-Command -Session $session -FilePath "$($Location)\Remote.ps1"

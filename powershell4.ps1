# collection filtering
Get-Service | Where-Object { $_.Status -eq 'running' }
$processes = Get-Process | Sort-Object WS -Descending | Where-Object { $_.WS -gt 100MB }
$processes | Select-Object -First 5
$processes | Select-Object -Unique

# Foreach loop
("alice", "bob", "kathy", "christina") | ForEach-Object { $_.subString(0,1).toUpper() + $_.subString(1).toLower() }
("alice", "bob", "kathy", "christina").ForEach({ $_.subString(0,1).toUpper() + $_.subString(1).toLower() })
(1..10).ForEach({ [Math]::PI * [Math]::POW($_, 2) })

$Location = "D:\02. E-Learning\06. Database\[TutsNode.com] - PowerShell 7 Essential Training - Fin\Lab"
Get-ChildItem -Path $Location | Where-Object { $_.Length -gt 5kb } | Select-Object -Skip 1

Add-Type -Assembly System.IO.Compression.FileSystem
$psItems = Get-ChildItem | Where-Object { $_.Extension -like '*.ps1' }
$psItems.ForEach({
    write-Host "zipping $($_.fullname)" -ForegroundColor Green
    $zip = [System.IO.Compression.ZipFile]::Open("$($Location)\backup\$($_.basename).zip","Create")
    [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip,$_.fullname,$_.name)
    $zip.Dispose()
})

#zip folders that haven't changed in the last 30 days. Ex: 0 day
Set-Location -Path get-location
$psFolders = Get-ChildItem -Directory | Where-Object { $_.LastWriteTime -le (Get-Date).AddDays(-0) }
$psFolders.ForEach({ 
    $zipPath = Join-Path "$($Location)\backup\" "$($_.name).zip"
    Write-Host "Zipping $($_.fullname) to $zipPath" -ForegroundColor Green
    [System.IO.Compression.ZipFile]::CreateFromDirectory($_.FullName,
    $zipPath)
    Get-Item $zipPath
 })

$psFiles = Get-ChildItem -File -Recurse | Where-Object { $_.Length -ge 2kb } | Get-Acl
$psFiles | Select-Object @{Name="Path";Expression={(Resolve-Path $_.Path).Providerpath}},
@{Name="Size";Expression={ (get-item $_.path).length }},Owner

$psFiles = Get-ChildItem -File -Recurse | Where-Object { $_.Length -ge 2kb }
$psFiles.foreach({
    $size = $_.length ;
    Get-Acl $_.fullname | 
    Select-Object @{Name="Path";Expression={(Resolve-Path $_.Path).ProviderPath}},
    @{Name="Size";Expression={$size}},Owner})
$homeDir = $home
if (-not (Test-Path $home)) { 
    $homeDir = $env:USERPROFILE
}

$zipURL = "https://github.com/uditkumar01/init_setup/archive/refs/heads/main.zip"
$tmpFileName = "tmp-$((Get-Random).ToString())"
$tmpDir = Join-Path $homeDir $tmpFileName

# create a tmp directory
New-Item -ItemType Directory -Path $tmpDir | Out-Null

# download the zip file
Invoke-WebRequest -Uri $zipURL -OutFile (Join-Path $tmpDir "main.zip")

# extract the zip file
Expand-Archive -Path (Join-Path $tmpDir "main.zip") -DestinationPath $tmpDir

$scriptPath = Join-Path $tmpDir "init_setup-main\windows-terminal-setup.ps1"

# run the powershell file
Invoke-Expression $scriptPath

# remove the tmp directory
Remove-Item -Path $tmpDir -Recurse
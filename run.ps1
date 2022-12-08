$zipURL = "https://github.com/uditkumar01/init_setup/archive/refs/heads/main.zip"
$tmpFileName = "tmp-$((Get-Random).ToString())"
$tmpDir = Join-Path $HOME $tmpFileName
$usrCurrentDir = $PWD

# create a tmp directory
New-Item -ItemType Directory -Path $tmpDir | Out-Null

# download the zip file
Invoke-WebRequest -Uri $zipURL -OutFile (Join-Path $tmpDir "main.zip")

# extract the zip file
Expand-Archive -Path (Join-Path $tmpDir "main.zip") -DestinationPath $tmpDir

# cd to the extracted directory
Set-Location (Join-Path $tmpDir "init_setup-main")

$scriptPath = Join-Path $PWD "windows-terminal-setup.ps1"

# run the powershell file
Invoke-Expression $scriptPath

# cd back to the original directory
Set-Location $usrCurrentDir

# remove the tmp directory if it exists
if (Test-Path $tmpDir) { Remove-Item -Path $tmpDir -Recurse }
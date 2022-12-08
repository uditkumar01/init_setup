# import module member Write-Color
Import-Module (Join-Path $PSScriptRoot "utils\write-color.psm1")
Import-Module (Join-Path $PSScriptRoot "utils\write-file.psm1")
Import-Module (Join-Path $PSScriptRoot "utils\read-file.psm1")
Import-Module (Join-Path $PSScriptRoot "utils\test-if-module-is-installed.psm1")

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (!$isAdmin) {
    Write-Error "You must run this script as an administrator"
    # remove the tmp directory if it exists
    # if (Test-Path $tmpDir) { Remove-Item -Path $tmpDir -Recurse }
    exit
}

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# install starship if not installed
if (!(Get-Command starship -ErrorAction SilentlyContinue)) {
    Write-Color "Installing starship..." -Color DarkGray
    winget install --id Starship.Starship
    Write-Color "Installed starship" -Color DarkGray
}
else {
    Write-Color "starship is already installed" -Color DarkGray
}

# install PSReadline
$installPSReadline = Read-Host -Prompt "Do you want to install PSReadline? [y/n]: [default: n]"
if ($installPSReadline -eq "y") { Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck }


# install terminal icons
Test-IfModuleIsInstalled -ModuleName Terminal-Icons -CMDString "Install-Module -Name Terminal-Icons -Repository PSGallery"


# check if git is installed
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    # ask use if they want to use git or posh-git
    $coloredText = @(
        "Git is not installed. Do you want to install it?`n"
        " 1. Git Bash"
        " 2. posh-git"
        " 3. None"
    )
    $gitChoice = Read-Host -Prompt (Write-Color $coloredText -Color White, DarkGray, DarkGray, DarkGray -Separator "`n")

    # install git
    switch ($gitChoice) {
        1 {
            Write-Color "Installing Git Bash..." -Color DarkGray
            # install git
            winget install --id Git.Git -e -i --source winget
        }
        2 {
            Write-Color "Installing posh-git..." -Color DarkGray
            # install posh-git
            Install-Module -Name posh-git -AllowClobber -Force
        }
        default {
            Write-Color "Skipping git installation." -Color DarkGray
        }
    }
}
else {
    Write-Color "Git is already installed" -Color DarkGray
}

# read the current profile
$profileText = Read-File -Path (Join-Path $PWD "pwsh/profile.ps1")
# write to the profile
Write-File -Path $PROFILE -Content $profileText

$starshipConfigPath = Join-Path $HOME ".config\starship.toml"
# read the current starship config
$starshipConfigText = Read-File -Path (Join-Path $PWD "starship/starship.toml")
# write to the starship config
Write-File -Path $starshipConfigPath -Content $starshipConfigText

# set bash profile check for .bashrc and .bash_profile
$bashProfilePath = Join-Path $HOME ".bash_profile"
if (!(Test-Path $bashProfilePath)) {
    $bashProfilePath = Join-Path $HOME ".bashrc"
}

$bprofileName = Read-Host -Prompt "Enter the name of your bash profile (e.g. .bashrc) [default: .bash_profile]:"
if ($bprofileName -eq "") {
    $bprofileName = ".bash_profile"
}
$bashProfilePath = Join-Path $HOME $bprofileName
$bashPorfileText = Read-File -Path (Join-Path $PWD "bash/example.bash_profile")
Write-File -Path $bashProfilePath -Content $bashPorfileText

# install nodejs lts latest version
if (!(Get-Command node -ErrorAction SilentlyContinue)) {
    $installNodeJS = Read-Host -Prompt "Do you want to install nodejs? [y/n]: [default: n]"
    if ($installNodeJS -eq "y") {
        Write-Color "Installing nodejs..." -Color DarkGray
        winget install --id OpenJS.NodeJS.LTS -e -i --source winget
        Write-Color "Installed nodejs" -Color DarkGray
    }
    else {
        Write-Color "Skipping nodejs installation." -Color DarkGray
    }
}
else {
    Write-Color "nodejs is already installed" -Color DarkGray
}

# install firefox
if (!(Get-Command firefox -ErrorAction SilentlyContinue)) {
    $installFirefox = Read-Host -Prompt "Do you want to install firefox? [y/n]: [default: n]"
    if ($installFirefox -eq "y") {
        Write-Color "Installing firefox..." -Color DarkGray
        winget install --id Mozilla.Firefox -e -i --source winget
        Write-Color "Installed firefox" -Color DarkGray
    }
    else {
        Write-Color "Skipping firefox installation." -Color DarkGray
    }
}
else {
    Write-Color "firefox is already installed" -Color DarkGray
}

# install vscode
if (!(Get-Command code -ErrorAction SilentlyContinue)) {
    $installVSCode = Read-Host -Prompt "Do you want to install vscode? [y/n]: [default: n]"
    if ($installVSCode -eq "y") {
        Write-Color "Installing vscode..." -Color DarkGray
        winget install --id Microsoft.VisualStudioCode -e -i --source winget
        Write-Color "Installed vscode" -Color DarkGray
    }
    else {
        Write-Color "Skipping vscode installation." -Color DarkGray
    }
}
else {
    Write-Color "vscode is already installed" -Color DarkGray
}

# install telegram
$installTg = Read-Host -Prompt "Do you want to install telegram? [y/n]: [default: n]"
if ($installTg -eq "y") {
    Write-Color "Installing telegram..." -Color DarkGray
    winget install --id Telegram.TelegramDesktop -e -i --source winget
    Write-Color "Installed telegram" -Color DarkGray
}
else {
    Write-Color "Skipping telegram installation." -Color DarkGray
}

# install zoom
$installZoom = Read-Host -Prompt "Do you want to install zoom? [y/n]: [default: n]"
if ($installZoom -eq "y") {
    Write-Color "Installing zoom..." -Color DarkGray
    winget install --id Zoom.Zoom -e -i --source winget
    Write-Color "Installed zoom" -Color DarkGray
}
else {
    Write-Color "Skipping zoom installation." -Color DarkGray
}

# few steps to follow
Write-Color "Few steps to follow:" -Color DarkGray
Write-Color @("1. Install a nerd font ", "nerdfonts.com/font-downloads") -Color DarkGray, Yellow
Write-Color "2. Set the nerd font as the terminal font (in Settings.Defaults)" -Color DarkGray
Write-Color "3. Change the VSCode font to the nerd font" -Color DarkGray
Write-Color @("4. Set up Github ssh key", " [bash <(curl -s https://raw.githubusercontent.com/uditkumar01/init_setup/main/bash/create_git_ssh_key.sh)]") -Color DarkGray, Yellow

Write-Color "`nRestart Windows Terminal to see changes" -Color DarkGray
Write-Color "Finished setting up Windows Terminal" -Color DarkGray

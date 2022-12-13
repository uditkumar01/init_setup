# Powershell script to setup my windows machine

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser # this will allow remotely signed scripts to execute
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/uditkumar01/init_setup/main/run.ps1')
```

Copy the above code and paste it in the powershell terminal and hit enter. It will download the script and run it. It will take some time to download and run the script.

### By default, it will setup:

- `Starship` cross-shell prompt
- `PSReadLine` for autocomplete
- `Terminal-Icons` for better command line experience

It will ask you for installing various softwares like firefox, vscode, git, etc. You can choose to install them or not.

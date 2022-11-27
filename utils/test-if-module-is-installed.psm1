function Test-IfModuleIsInstalled($ModuleName, [String]$CMDString = "") {
    $module = Get-Module -Name $ModuleName -ListAvailable
    if ($module -eq $null) {
        Write-Color @("Installing", " $ModuleName...") -Color DarkGray, DarkGreen
        if ($CMDString -ne "") {
            Invoke-Expression $CMDString
        }
    } else {
        Write-Color @("$ModuleName", " is already installed") -Color Green, DarkGray
    }
}

Export-ModuleMember -Function Test-IfModuleIsInstalled
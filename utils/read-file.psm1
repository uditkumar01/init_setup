function Read-File([string]$Path) {
    if (Test-Path $Path) {
        $file = Get-Content -Path $Path
        $fileString = $file -join "`n"
        return $fileString
    } else {
        Write-Error "$Path File does not exist"
    }
}

Export-ModuleMember -Function Read-File
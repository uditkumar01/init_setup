function Write-Color([String[]]$Text, [ConsoleColor[]]$Color, [String]$Separator = " ") {
    for ($i = 0; $i -lt $Text.Length; $i++) {
        $sep = if ($i -eq 0) { "" } else { $Separator }
        Write-Host $Text[$i] -Foreground $Color[$i] $sep -NoNewline -Separator ''
    }
    Write-Host
}

Export-ModuleMember -Function Write-Color